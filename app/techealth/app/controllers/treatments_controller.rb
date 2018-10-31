class TreatmentsController < ApplicationController
  before_action :set_treatment, only: [:show, :edit, :update, :destroy]

  # GET /treatments
  # GET /treatments.json
  def index
    @treatments = Treatment.all
  end

  # GET /treatments/1
  # GET /treatments/1.json
  def show
  end

  # GET /treatments/new
  def new
    @treatment = Treatment.new
  end

  # GET /treatments/1/edit
  def edit
  end

  # POST /treatments
  # POST /treatments.json
  def create
    p_id_treatment = params[:treatment][:id_treatment].to_i
    p_name = params[:treatment][:name]
    p_type = params[:type]
    p_dosis = params[:treatment][:dosis]
    p_total = params[:treatment][:total].to_i
    p_secondary_effects = params[:treatment][:secondary_effects]
    p_days = params[:treatment][:days].to_i

    # verificar
    
    @treatment = Treatment.new(
               id_treatment: p_id_treatment,
               name: p_name,
               type: p_type,
               dosis: p_dosis,
               total: p_total,
               secondary_effects: p_secondary_effects,
               days: p_days     
    )

    respond_to do |format|
      if @treatment.save
        redirect_to controller: "doctors", notice: "OK" and return
      else
        redirect_to controller: "doctors", notice: "Unsuccessful..." and return
      end
    end
  end

  # PATCH/PUT /treatments/1
  # PATCH/PUT /treatments/1.json
  def update
    respond_to do |format|
      if @treatment.update(treatment_params)
        format.html { redirect_to @treatment, notice: 'Treatment was successfully updated.' }
        format.json { render :show, status: :ok, location: @treatment }
      else
        format.html { render :edit }
        format.json { render json: @treatment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /treatments/1
  # DELETE /treatments/1.json
  def destroy
    @treatment.destroy
    respond_to do |format|
      format.html { redirect_to treatments_url, notice: 'Treatment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_treatment
      @treatment = Treatment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def treatment_params
      params.require(:treatment).permit(:name, :id_treatment, :type, :dosis, :total, :secondary_effects, :days)
    end
end
