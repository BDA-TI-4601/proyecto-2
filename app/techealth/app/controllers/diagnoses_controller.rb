class DiagnosesController < ApplicationController
  before_action :set_diagnosis, only: [:show, :edit, :update, :destroy]

  # GET /diagnoses
  # GET /diagnoses.json
  def index
    @diagnoses = Diagnose.all
  end

  # GET /diagnoses/1
  # GET /diagnoses/1.json
  def show
    list_treatments = @diagnosis.id_treatments
    @treatments = []
    list_treatments.each do |i|
      actual = Treatment.find_by(id_treatment: i[:id])
      if !actual.nil?
        @treatments += [actual]
      end
    end
  end

  # GET /diagnoses/new
  def new
    @diagnosis = Diagnose.new
  end

  # GET /diagnoses/1/edit
  def edit
    list = @diagnosis.id_treatments
    aux_list = []
    list.each do |i|
      aux_list += [i[:id]]
    end
    @diagnosis.id_treatments = aux_list
  end

  # POST /diagnoses
  # POST /diagnoses.json
  def create
    p_name = params[:diagnose][:name]
    p_symptoms = params[:diagnose][:symptoms].split(' ')
    p_level = [:level]
    p_observations = params[:diagnose][:observations]
    p_treatments = params[:diagnose][:id_treatments].split(' ')
    
    aux_list = []
    p_treatments.each do |p_t|
      aux_list += [{"id" => p_t.to_i}]
    end
    
    @diagnosis = Diagnose.new(
      name: p_name,
      symptoms: p_symptoms,
      level: p_level,
      observations: p_observations,
      id_treatments: aux_list
    )
    respond_to do |format|
      if @diagnosis.save
        redirect_to controller: "doctors" and return
      else
        redirect_to controller: "doctors", notice: "Unsuccessful..." and return
      end
    end
  end

  # PATCH/PUT /diagnoses/1
  # PATCH/PUT /diagnoses/1.json
  def update
    p_name = params[:diagnose][:name]
    p_symptoms = params[:diagnose][:symptoms].split(' ')
    p_level = params[:level]
    p_observations = params[:diagnose][:observations]
    p_treatments = params[:diagnose][:id_treatments].split(' ')

    aux_list = []
    p_treatments.each do |i|
      aux_list += [{"id" => i.to_i}]
    end

    respond_to do |format|
      if @diagnosis.update(
        name: p_name,
        symptoms: p_symptoms,
        level: p_level,
        observations: p_observations,
        id_treatments: aux_list
        )
        format.html { redirect_to @diagnosis, notice: 'Diagnose was successfully updated.' }
        format.json { render :show, status: :ok, location: @diagnosis }
      else
        format.html { render :edit }
        format.json { render json: @diagnosis.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diagnoses/1
  # DELETE /diagnoses/1.json
  def destroy
    @diagnosis.destroy
    respond_to do |format|
      format.html { redirect_to diagnoses_url, notice: 'Diagnose was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diagnosis
      @diagnosis = Diagnose.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def diagnosis_params
      params.require(:diagnosis).permit(:id_diagnose, :name, :symptoms, :level, :observations, :id_treatments)
    end
end
