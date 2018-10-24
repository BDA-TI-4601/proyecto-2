class FunctionaryTypesController < ApplicationController
  before_action :set_functionary_type, only: [:show, :edit, :update, :destroy]

  # GET /functionary_types
  # GET /functionary_types.json
  def index
    @functionary_types = FunctionaryType.all
  end

  # GET /functionary_types/1
  # GET /functionary_types/1.json
  def show
  end

  # GET /functionary_types/new
  def new
    @functionary_type = FunctionaryType.new
  end

  # GET /functionary_types/1/edit
  def edit
  end

  # POST /functionary_types
  # POST /functionary_types.json
  def create
    @functionary_type = FunctionaryType.new(functionary_type_params)

    respond_to do |format|
      if @functionary_type.save
        format.html { redirect_to @functionary_type, notice: 'Functionary type was successfully created.' }
        format.json { render :show, status: :created, location: @functionary_type }
      else
        format.html { render :new }
        format.json { render json: @functionary_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /functionary_types/1
  # PATCH/PUT /functionary_types/1.json
  def update
    respond_to do |format|
      if @functionary_type.update(functionary_type_params)
        format.html { redirect_to @functionary_type, notice: 'Functionary type was successfully updated.' }
        format.json { render :show, status: :ok, location: @functionary_type }
      else
        format.html { render :edit }
        format.json { render json: @functionary_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /functionary_types/1
  # DELETE /functionary_types/1.json
  def destroy
    @functionary_type.destroy
    respond_to do |format|
      format.html { redirect_to functionary_types_url, notice: 'Functionary type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_functionary_type
      @functionary_type = FunctionaryType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def functionary_type_params
      params.require(:functionary_type).permit(:name)
    end
end
