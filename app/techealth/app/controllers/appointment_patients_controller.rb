class AppointmentPatientsController < ApplicationController
  before_action :set_appointment_patient, only: [:show, :edit, :update, :destroy]
  protect_from_forgery except: :show

  # GET /appointment_patients
  # GET /appointment_patients.json
  def index 
    @id_patient_actual = params[:id]
    @appointment_patients = Appointment.where(id_patient: @id_patient_actual)
    @actual_user = Patient.find_by(id_patient: @id_patient_actual)
    #render 'index'
  end

  def index2
    @id_patient_actual = params[:id]
    @p_initial_date = params[:initial_date]
    @p_final_date = params[:final_date]
    @actual_user = Patient.find_by(id_patient: @id_patient_actual)
    query = {
      'app_date' => 
      {
        '$gte' => Date.strptime(@p_initial_date, '%Y-%m-%d'),
        '$lt' => Date.strptime(@p_final_date, '%Y-%m-%d')
      },
      'id_patient' => @id_patient_actual
    }
    @appointment_patients = Appointment.where(query)
    flash[:notice] = "OK"
    render 'index'
  end
  helper_method :index2

  def index3
    @id_patient_actual = params[:id]
    @p_status = params[:status]
    @appointment_patients = Appointment.where(status: @p_status, id_patient: @id_patient_actual)
    @actual_user = Patient.find_by(id_patient: @id_patient_actual)
    flash[:notice] = "OK"
    render 'index'
  end
  helper_method :index3

  def index4
    @id_patient_actual = params[:id]
    @p_area = params[:area]
    @appointment_patients = Appointment.where(area: @p_area, id_patient: @id_patient_actual)
    @actual_user = Patient.find_by(id_patient: @id_patient_actual)
    flash[:notice] = "OK"
    render 'index'
  end
  helper_method :index4

  def delete_app
    @p_app_id = params[:app_id]
    @id_patient_actual = params[:id]
    @actual_user = Patient.find_by(id_patient: @id_patient_actual)
    if (@p_app_id == "")
      flash[:notice] = "empty field"
    else
      if (Appointment.where(
        id_appointment: @p_app_id, 
        id_patient: @id_patient_actual
      ).exists?) 
        Appointment.where(
          id_appointment: @p_app_id, 
          id_patient: @id_patient_actual
        ).update(status: 'Cancelada por paciente')
        flash[:notice] = "appointment cancelled"
      else
        flash[:notice] = "error: check appointment id"
      end
    end
    @appointment_patients = Appointment.all
    redirect_to controller: 'appointment_patients', id: @id_patient_actual and return
  end
  helper_method :delete_app

  # GET /appointment_patients/1
  # GET /appointment_patients/1.json
  def show
    p_id = params[:app_id].to_i
    @id_patient_actual = params[:id_patient_actual]
    @appointment = Appointment.find_by(id_appointment: p_id, id_patient: @id_patient_actual)
    temp_treats = []
    @diagnoses = []
    @treatments = []
    if @appointment.nil?
      @actual_user = Patient.find_by(id_patient: @id_patient_actual)
      flash[:notice] = "appointment doesn't exist"
      redirect_to controller: 'appointment_patients', id: @id_patient_actual and return
    else
      list = @appointment.id_diagnoses
    end
    if list.nil?
      @diagnoses = []
      @treatments = []
    else
      list.each do |i|
        app_actual = Diagnose.find_by(id_diagnose: i[:id])
        if !app_actual.nil?
          @diagnoses += [app_actual]
          temp_treats += Diagnose.find_by(id_diagnose: i[:id]).id_treatments
        end
      end
      if !temp_treats.nil?
        temp_treats.each do |j|
          algo = Treatment.find_by(id_treatment: j)
          if !algo.nil? 
            @treatments += [algo]
          end
        end
      end
    end
  end

  # GET /appointment_patients/new
  def new
    @id_patient_actual = params[:id_patient_actual]
    @appointment_patient = AppointmentPatient.new
    @appointment_patient.id_patient = @id_patient_actual
  end

  # GET /appointment_patients/1/edit
  def edit
  end

  # POST /appointments
  # POST /appointments.json
  def create
    p_id_appointment = params[:appointment_patient][:id_appointment].to_i
    p_area = params[:area]
    p_year = params[:appointment_patient]["app_date(1i)"].to_i
    p_month = params[:appointment_patient]["app_date(2i)"].to_i
    p_day = params[:appointment_patient]["app_date(3i)"].to_i
    p_hour = params[:appointment_patient]["app_date(4i)"].to_i
    p_minute = params[:appointment_patient]["app_date(5i)"].to_i
    p_observation = params[:appointment_patient][:observation]
    p_id_patient = params[:appointment_patient][:id_patient].to_i
    p_id_diagnoses = params[:appointment_patient][:id_diagnoses]
    p_status = params[:status]
    
    @appointment = Appointment.new(
      id_appointment: p_id_appointment,
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
      id_diagnoses: p_id_diagnoses
    )
    
    if @appointment.save
      flash[:notice] = "OK"
      redirect_to controller: 'appointment_patients', id: p_id_patient and return
    else
      flash[:notice] = "FAIL"
      redirect_to controller: 'appointment_patients', id: p_id_patient and return
    end
  end

  # PATCH/PUT /appointment_patients/1
  # PATCH/PUT /appointment_patients/1.json
  def update
    respond_to do |format|
      if @appointment_patient.update(appointment_patient_params)
        format.html { redirect_to @appointment_patient, notice: 'Appointment patient was successfully updated.' }
        format.json { render :show, status: :ok, location: @appointment_patient }
      else
        format.html { render :edit }
        format.json { render json: @appointment_patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointment_patients/1
  # DELETE /appointment_patients/1.json
  def destroy
    @appointment_patient.destroy
    respond_to do |format|
      format.html { redirect_to appointment_patients_url, notice: 'Appointment patient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment_patient
      @appointment_patient = Appointment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def appointment_patient_params
      params.require(:appointment_patient).permit(:id_appointment, :area, :app_date, :observation, :status, :id_patient, :id_diagnoses)
    end
end
