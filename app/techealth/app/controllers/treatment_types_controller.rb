class TreatmentTypesController < ApplicationController
  before_action :set_treatment_type, only: [:show, :edit, :update, :destroy]

  # GET /treatment_types
  # GET /treatment_types.json
  def index
    @treatment_types = TreatmentType.all
  end

  # GET /treatment_types/1
  # GET /treatment_types/1.json
  def show
  end

  # GET /treatment_types/new
  def new
    @treatment_type = TreatmentType.new
  end

  # GET /treatment_types/1/edit
  def edit
  end

  # POST /treatment_types
  # POST /treatment_types.json
  def create
    @treatment_type = TreatmentType.new(treatment_type_params)

    respond_to do |format|
      if @treatment_type.save
        format.html { redirect_to @treatment_type, notice: 'Treatment type was successfully created.' }
        format.json { render :show, status: :created, location: @treatment_type }
      else
        format.html { render :new }
        format.json { render json: @treatment_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /treatment_types/1
  # PATCH/PUT /treatment_types/1.json
  def update
    respond_to do |format|
      if @treatment_type.update(treatment_type_params)
        format.html { redirect_to @treatment_type, notice: 'Treatment type was successfully updated.' }
        format.json { render :show, status: :ok, location: @treatment_type }
      else
        format.html { render :edit }
        format.json { render json: @treatment_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /treatment_types/1
  # DELETE /treatment_types/1.json
  def destroy
    @treatment_type.destroy
    respond_to do |format|
      format.html { redirect_to treatment_types_url, notice: 'Treatment type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_treatment_type
      @treatment_type = TreatmentType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def treatment_type_params
      params.require(:treatment_type).permit(:name)
    end
end
