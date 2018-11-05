class SecretariesController < ApplicationController
  before_action :set_secretary, only: [:edit, :update, :destroy]

  # GET /secretaries
  # GET /secretaries.json
  def index
    @secretaries = Appointment.all
  end

  def index2
    @p_initial_date = params[:initial_date]
    @p_final_date = params[:final_date]
    if (@p_initial_date == "" || @p_final_date == "")
      @secretaries = []
    else
      query = {
        'app_date' => 
        {
          '$gte' => Date.strptime(@p_initial_date, '%Y-%m-%d'),
          '$lt' => Date.strptime(@p_final_date, '%Y-%m-%d')
        }
      }
      @secretaries = Appointment.where(query)
    end
    render 'index'
  end
  helper_method :index2

  def index3
    @p_status = params[:status]
    if (@p_status == "")
      @secretaries = []
    else
      @secretaries = Appointment.where(status: @p_status)
    end
    render 'index'
  end
  helper_method :index3

  def index4
    @p_area = params[:area]
    if (@p_area == "")
      @secretaries = []
    else
      @secretaries = Appointment.where(area: @p_area)
    end
    render 'index'
  end
  helper_method :index4

  def index5
    p_patient_name = params[:patient_name]
    p_exist = Patient.where(name: p_patient_name).exists?
    if p_exist
      patients = Patient.where(name: p_patient_name)    
      @secretaries = Appointment.where(id_patient: patients[0].id_patient)
    else
      @secretaries = Appointment.all
    end
    render 'index'
  end
  helper_method :index5

  def delete_app
    @p_app_id = params[:app_id]
    if (@p_app_id == "")
    else
      Appointment.where(id_appointment: @p_app_id).update(status: 'Cancelada por centro medico')
    end
    @secretaries = Appointment.all
    render 'index'
  end
  helper_method :delete_app

  def assign_app
    @p_app_id = params[:app_id]
    if (@p_app_id == "")
    else
      Appointment.where(id_appointment: @p_app_id).update(status: 'Asignada')
    end
    @secretaries = Appointment.all
    render 'index'
  end
  helper_method :assign_app

  def by_patient
    @p_id = params[:id_patient]
    if (@p_id == "")
      @secretaries = []
    else
      @secretaries = Appointment.where(id_patient: @p_id)
    end
    render 'index'
  end

  # GET /secretaries/1
  # GET /secretaries/1.json
  def show
    render 'show'
  end

  # GET /secretaries/new
  def new
    @secretary = Secretary.new
  end

  # GET /secretaries/1/edit
  def edit
  end

  def create
    p_area = params[:area]
    p_year = params[:secretary]["app_date(1i)"].to_i
    p_month = params[:secretary]["app_date(2i)"].to_i
    p_day = params[:secretary]["app_date(3i)"].to_i
    p_hour = params[:secretary]["app_date(4i)"].to_i
    p_minute = params[:secretary]["app_date(5i)"].to_i
    p_observation = params[:secretary][:observation]
    p_id_patient = params[:secretary][:id_patient].to_i
    p_status = "Registrada"

    patient = Patient.find_by(id_patient: p_id_patient)
    if( patient.nil? )
      flash[:notice] = "error: Patient doesn't exist"
      redirect_to controller: secretaries_path and return
    end

    @appointment = Appointment.new(
      id_appointment: 0,
      area: p_area,
      app_date: Time.new(
        p_year,
        p_month,
        p_day,
        p_hour,
        p_minute
      ),
      observation: p_observation,
      status: p_status,
      id_patient: p_id_patient,
      id_diagnoses: []
    )

    if @appointment.save
      flash[:notice] = "Appointment assigned to -> " + patient.name
      redirect_to controller: secretaries_path, notice: @msg and return
    else
      flash[:notice] = "error: saving new appointment fails..."
      redirect_to controller: secretaries_path and return
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_secretary
      @secretary = Secretary.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def secretary_params
      params.require(:secretary).permit(:id_appointment, :area, :app_date, :observation, :status, :id_patient)
    end
end
