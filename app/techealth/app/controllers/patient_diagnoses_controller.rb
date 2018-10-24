class PatientDiagnosesController < ApplicationController
  before_action :set_patient_diagnosis, only: [:show, :edit, :update, :destroy]

  # GET /patient_diagnoses
  # GET /patient_diagnoses.json
  def index
    @patient_diagnoses = PatientDiagnose.all
  end

  # GET /patient_diagnoses/1
  # GET /patient_diagnoses/1.json
  def show
  end

  # GET /patient_diagnoses/new
  def new
    @patient_diagnosis = PatientDiagnose.new
  end

  # GET /patient_diagnoses/1/edit
  def edit
  end

  # POST /patient_diagnoses
  # POST /patient_diagnoses.json
  def create
    @patient_diagnosis = PatientDiagnose.new(patient_diagnosis_params)

    respond_to do |format|
      if @patient_diagnosis.save
        format.html { redirect_to @patient_diagnosis, notice: 'Patient diagnose was successfully created.' }
        format.json { render :show, status: :created, location: @patient_diagnosis }
      else
        format.html { render :new }
        format.json { render json: @patient_diagnosis.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patient_diagnoses/1
  # PATCH/PUT /patient_diagnoses/1.json
  def update
    respond_to do |format|
      if @patient_diagnosis.update(patient_diagnosis_params)
        format.html { redirect_to @patient_diagnosis, notice: 'Patient diagnose was successfully updated.' }
        format.json { render :show, status: :ok, location: @patient_diagnosis }
      else
        format.html { render :edit }
        format.json { render json: @patient_diagnosis.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patient_diagnoses/1
  # DELETE /patient_diagnoses/1.json
  def destroy
    @patient_diagnosis.destroy
    respond_to do |format|
      format.html { redirect_to patient_diagnoses_url, notice: 'Patient diagnose was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient_diagnosis
      @patient_diagnosis = PatientDiagnose.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def patient_diagnosis_params
      params.require(:patient_diagnosis).permit(:id_patient, :diagnose_id, :level, :observation)
    end
end
