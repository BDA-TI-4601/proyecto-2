class SecretariesController < ApplicationController
  before_action :set_secretary, only: [:show, :edit, :update, :destroy]

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
  end

  # GET /secretaries/new
  def new
    @secretary = Secretary.new
  end

  # GET /secretaries/1/edit
  def edit
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
