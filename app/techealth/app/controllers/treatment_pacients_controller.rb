class TreatmentPacientsController < ApplicationController
  before_action :set_treatment_pacient, only: [:show, :edit, :update, :destroy]

  # GET /treatment_pacients
  # GET /treatment_pacients.json
  def index
    @treatment_pacients = TreatmentPacient.all
  end

  # GET /treatment_pacients/1
  # GET /treatment_pacients/1.json
  def show
  end

  # GET /treatment_pacients/new
  def new
    @treatment_pacient = TreatmentPacient.new
  end

  # GET /treatment_pacients/1/edit
  def edit
  end

  # POST /treatment_pacients
  # POST /treatment_pacients.json
  def create
    @treatment_pacient = TreatmentPacient.new(treatment_pacient_params)

    respond_to do |format|
      if @treatment_pacient.save
        format.html { redirect_to @treatment_pacient, notice: 'Treatment pacient was successfully created.' }
        format.json { render :show, status: :created, location: @treatment_pacient }
      else
        format.html { render :new }
        format.json { render json: @treatment_pacient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /treatment_pacients/1
  # PATCH/PUT /treatment_pacients/1.json
  def update
    respond_to do |format|
      if @treatment_pacient.update(treatment_pacient_params)
        format.html { redirect_to @treatment_pacient, notice: 'Treatment pacient was successfully updated.' }
        format.json { render :show, status: :ok, location: @treatment_pacient }
      else
        format.html { render :edit }
        format.json { render json: @treatment_pacient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /treatment_pacients/1
  # DELETE /treatment_pacients/1.json
  def destroy
    @treatment_pacient.destroy
    respond_to do |format|
      format.html { redirect_to treatment_pacients_url, notice: 'Treatment pacient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_treatment_pacient
      @treatment_pacient = TreatmentPacient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def treatment_pacient_params
      params.require(:treatment_pacient).permit(:id_patient, :dosis, :days, :secundary_effects)
    end
end
