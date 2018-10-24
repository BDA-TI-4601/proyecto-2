class CenterTypesController < ApplicationController
  before_action :set_center_type, only: [:show, :edit, :update, :destroy]

  # GET /center_types
  # GET /center_types.json
  def index
    @center_types = CenterType.all
  end

  # GET /center_types/1
  # GET /center_types/1.json
  def show
  end

  # GET /center_types/new
  def new
    @center_type = CenterType.new
  end

  # GET /center_types/1/edit
  def edit
  end

  # POST /center_types
  # POST /center_types.json
  def create
    @center_type = CenterType.new(center_type_params)

    respond_to do |format|
      if @center_type.save
        format.html { redirect_to @center_type, notice: 'Center type was successfully created.' }
        format.json { render :show, status: :created, location: @center_type }
      else
        format.html { render :new }
        format.json { render json: @center_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /center_types/1
  # PATCH/PUT /center_types/1.json
  def update
    respond_to do |format|
      if @center_type.update(center_type_params)
        format.html { redirect_to @center_type, notice: 'Center type was successfully updated.' }
        format.json { render :show, status: :ok, location: @center_type }
      else
        format.html { render :edit }
        format.json { render json: @center_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /center_types/1
  # DELETE /center_types/1.json
  def destroy
    @center_type.destroy
    respond_to do |format|
      format.html { redirect_to center_types_url, notice: 'Center type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_center_type
      @center_type = CenterType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def center_type_params
      params.require(:center_type).permit(:type)
    end
end
