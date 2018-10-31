class DoctorsController < ApplicationController
  before_action :set_doctor, only: [:show, :edit, :update, :destroy]

  # GET /doctors
  # GET /doctors.json
  def index
    @doctors = Appointment.all
    @patients = []
  end

  def index2
    @p_initial_date = params[:initial_date]
    @p_final_date = params[:final_date]
    if (@p_initial_date == "" || @p_final_date == "")
      @doctors = []
    else
      query = {
        'app_date' => 
          {
            '$gte' => Date.strptime(@p_initial_date, '%Y-%m-%d'),
            '$lt' => Date.strptime(@p_final_date, '%Y-%m-%d')
          }
      }
    }
    @doctors = Appointment.where(query)
    @patients = []
    end
    flash[:notice] = "OK"
    render 'index'
  end
  helper_method :index2

  def index3 
    @id_patient_actual = params[:id]
    @p_status = params[:status]
    @doctors = Appointment.where(status: @p_status)
    @patients = []
    render 'index'
  end 
  helper_method :index3

  def index4
    @id_patient_actual = params[:id]
    @p_area = params[:area]
    @doctors = Appointment.where(area: @p_area)
    @patients = []
    render 'index'
  end
  helper_method :index4

  def index5
    p_id_patient = params[:patient_id]
    @patients = Patient.where(id_patient: p_id_patient)
    @doctors = Appointment.all
    render 'index'
  end
  helper_method :index5

  def index6
    p_patient_name = params[:patient_name]
    p_exist = Patient.where(name: p_patient_name).exists?
    if p_exist
      @patients = Patient.where(name: p_patient_name)    
      @doctors = Appointment.where(id_patient: @patients[0].id_patient)
    else
      @doctors = Appointment.all
      @patients = []
    end
    render 'index'
  end
  helper_method :index6

  # GET /doctors/1
  # GET /doctors/1.json
  def show
    p_id = params[:app_id]
    @appointment = Appointment.find_by(id_appointment: p_id)
    @id_patient_actual = @appointment.id_patient
    list = @appointment.id_diagnoses
    temp_treats = []
    @diagnoses = []
    if list.nil?
      @diagnoses = []
      @treatments = []
    else
      list.each do |i|
        @diagnoses += [Diagnose.find_by(id_diagnose: i)]
        temp_treats += Diagnose.find_by(id_diagnose: i).id_treatments
      end
      @treatments = []
      temp_treats.each do |j|
        @treatments += [Treatment.find_by(id_treatment: j)]
      end
    end
  end

  # GET /doctors/new
  def new
    @doctor = Doctor.new
  end

  # GET /doctors/1/edit
  def edit
    
  end

  # POST /doctors
  # POST /doctors.json
  def create
    @doctor = Doctor.new(doctor_params)

    respond_to do |format|
      if @doctor.save
        format.html { redirect_to @doctor, notice: 'Doctor was successfully created.' }
        format.json { render :show, status: :created, location: @doctor }
      else
        format.html { render :new }
        format.json { render json: @doctor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /doctors/1
  # PATCH/PUT /doctors/1.json
  def update
    respond_to do |format|
      if @doctor.update(doctor_params)
        format.html { redirect_to @doctor, notice: 'Doctor was successfully updated.' }
        format.json { render :show, status: :ok, location: @doctor }
      else
        format.html { render :edit }
        format.json { render json: @doctor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /doctors/1
  # DELETE /doctors/1.json
  def destroy
    @doctor.destroy
    respond_to do |format|
      format.html { redirect_to doctors_url, notice: 'Doctor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def showall
    @p_initial_date = params[:initial_date]
    @p_final_date = params[:final_date]
    if (@p_initial_date == "" || @p_final_date == "")
      @doctors = []
    else
      query = {
        'app_date' => 
        {
          '$gte' => Date.strptime(@p_initial_date, '%Y-%m-%d'),
          '$lt' => Date.strptime(@p_final_date, '%Y-%m-%d')
        }
      }
      @doctors = Appointment.where(query)
    end
    flash[:notice] = "OK"
    render 'index'
  end
  helper_method :showall

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_doctor
      @doctor = Doctor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def doctor_params
      params.require(:doctor).permit(:id_appointment, :area, :app_date, :observation, :status, :id_patient, :id_diagnoses)
    end
end
