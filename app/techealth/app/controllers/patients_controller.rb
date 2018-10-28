class PatientsController < ApplicationController

  require 'digest'

  before_action :set_patient, only: [:show, :edit, :update, :destroy]

  # GET /patients
  # GET /patients.json
  def index
    @patients = Patient.all
  end

  # GET /patients/1
  # GET /patients/1.json
  def show
  end

  # GET /patients/new
  def new
    @patient = Patient.new
  end

  # GET /patients/1/edit
  def edit
  end

  # POST /patients
  # POST /patients.json
  def create
    p_id = params[:patient][:id_patient].to_i
    p_name = params[:patient][:name]
    p_year = params[:patient]["birth_date(1i)"].to_i
    p_month = params[:patient]["birth_date(2i)"].to_i
    p_day = params[:patient]["birth_date(3i)"].to_i
    p_blood = params[:patient][:blood]
    p_nationality = params[:patient][:nationality]
    p_residence = params[:patient][:residence]
    p_telephone = params[:patient][:telephone].split(',')
    p_username = params[:patient][:username]
    p_password = params[:patient][:password]
    #enc_password = Digest::SHA256.digest p_password

    user_exist = User.where(username: p_username).exists?
    @new_patient = 0
    @new_user = 0
    if user_exist
      redirect_to logins_path, notice: "Username not available!" and return
    else
      @new_patient = Patient.new(
        id_patient: p_id,
        name: p_name,
        birth_date: Date.new(p_year, p_month, p_day),
        blood: p_blood,
        nationality: p_nationality,
        residence: p_residence,
        telephone: p_telephone
      )
      @new_user = User.new(
        id_user: p_id,
        username: p_username,
        password: p_password
      )
      if @new_patient.save
        if @new_user.save
          redirect_to logins_path, notice: "New user created!" and return
        else
          redirect_to logins_path, notice: "Error creating new user!" and return
        end
      else
        redirect_to logins_path, notice: "Error creating new user!" and return
      end
    end
  end

  # PATCH/PUT /patients/1
  # PATCH/PUT /patients/1.json
  def update
    respond_to do |format|
      if @patient.update(patient_params)
        format.html { redirect_to @patient, notice: 'Patient was successfully updated.' }
        format.json { render :show, status: :ok, location: @patient }
      else
        format.html { render :edit }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1
  # DELETE /patients/1.json
  def destroy
    @patient.destroy
    respond_to do |format|
      format.html { redirect_to patients_url, notice: 'Patient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end
end
