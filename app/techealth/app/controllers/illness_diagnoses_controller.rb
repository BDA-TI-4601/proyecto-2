class IllnessDiagnosesController < ApplicationController
  before_action :set_illness_diagnosis, only: [:show, :edit, :update, :destroy]

  # GET /illness_diagnoses
  # GET /illness_diagnoses.json
  def index
    @illness_diagnoses = IllnessDiagnosis.all
  end

  # GET /illness_diagnoses/1
  # GET /illness_diagnoses/1.json
  def show
  end

  # GET /illness_diagnoses/new
  def new
    @illness_diagnosis = IllnessDiagnosis.new
  end

  # GET /illness_diagnoses/1/edit
  def edit
  end

  # POST /illness_diagnoses
  # POST /illness_diagnoses.json
  def create
    @illness_diagnosis = IllnessDiagnosis.new(illness_diagnosis_params)

    respond_to do |format|
      if @illness_diagnosis.save
        format.html { redirect_to @illness_diagnosis, notice: 'Illness diagnosis was successfully created.' }
        format.json { render :show, status: :created, location: @illness_diagnosis }
      else
        format.html { render :new }
        format.json { render json: @illness_diagnosis.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /illness_diagnoses/1
  # PATCH/PUT /illness_diagnoses/1.json
  def update
    respond_to do |format|
      if @illness_diagnosis.update(illness_diagnosis_params)
        format.html { redirect_to @illness_diagnosis, notice: 'Illness diagnosis was successfully updated.' }
        format.json { render :show, status: :ok, location: @illness_diagnosis }
      else
        format.html { render :edit }
        format.json { render json: @illness_diagnosis.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /illness_diagnoses/1
  # DELETE /illness_diagnoses/1.json
  def destroy
    @illness_diagnosis.destroy
    respond_to do |format|
      format.html { redirect_to illness_diagnoses_url, notice: 'Illness diagnosis was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_illness_diagnosis
      @illness_diagnosis = IllnessDiagnosis.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def illness_diagnosis_params
      params.require(:illness_diagnosis).permit(:name, :symptoms, :treatments)
    end
end
