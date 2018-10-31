class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]

  # GET /appointments
  # GET /appointments.json
  def index
    @appointments = Appointment.all
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
    
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new
  end

  # GET /appointments/1/edit
  def edit
    if (@appointment.status != "Asignada")
      redirect_to controller: 'appointments' and return
    end
  end

  # POST /appointments
  # POST /appointments.json
  def create
    p_id_appointment = params[:appointment][:id_appointment].to_i
    p_area = params[:appointment][:area]
    p_year = params[:appointment]["app_date(1i)"].to_i
    p_month = params[:appointment]["app_date(2i)"].to_i
    p_day = params[:appointment]["app_date(3i)"].to_i
    p_hour = params[:appointment]["app_date(4i)"].to_i
    p_minute = params[:appointment]["app_date(5i)"].to_i
    p_observation = params[:appointment][:observation]
    p_id_patient = params[:appointment][:id_patient].to_i
    p_id_diagnoses = params[:appointment][:id_diagnoses].split(',')
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
      flash.now[:error] = "Appointment assigned"
      redirect_to controller: 'appointment_patients', id: p_id_patient and return
    else
      flash.now[:error] = "FAILED!!"
      redirect_to controller: 'appointment_patients', id: p_id_patient and return
    end
  end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update
    p_id_diagnoses = params[:appointment][:id_diagnoses].split(',')
    p_id_diagnoses.each do |diag|
      actual_check = Diagnose.where(id_diagnose: diag).exists?
      if !actual_check
        flash[:notice] = "Diagnose id " + diag + " doesn't exist!"
        redirect_to controller: 'appointments' and return
      end
    end
    respond_to do |format|
      if @appointment.update(id_diagnoses: p_id_diagnoses)
        flash[:notice] = "Diagnoses assigned"
        redirect_to controller: 'appointments' and return
      else
        flash[:notice] = "Error assigning diagnoses"
        redirect_to controller: 'appointments' and return
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to appointments_url, notice: 'Appointment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end
end
