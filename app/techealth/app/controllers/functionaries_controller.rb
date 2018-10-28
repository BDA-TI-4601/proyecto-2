class FunctionariesController < ApplicationController
  before_action :set_functionary, only: [:show, :edit, :update, :destroy]

  # GET /functionaries
  # GET /functionaries.json
  def index
    @functionaries = Functionary.all
  end

  # GET /functionaries/1
  # GET /functionaries/1.json
  def show
  end

  # GET /functionaries/new
  def new
    @functionary = Functionary.new
  end

  # GET /functionaries/1/edit
  def edit
  end

  # POST /functionaries
  # POST /functionaries.json
  def create
    p_name = params[:functionary][:name]
    p_year = params[:functionary]['init_date(1i)'].to_i
    p_month = params[:functionary]['init_date(2i)'].to_i
    p_day = params[:functionary]['init_date(3i)'].to_i
    p_area = params[:area]
    p_identification = params[:functionary][:identification]
    p_type = params[:type]
    p_institution = params[:institution]
    p_username = params[:functionary][:username]
    p_password = params[:functionary][:password]
    
    @functionary = Functionary.new(
      name: p_name,
      init_date: Date.new(
        p_year,
        p_month,
        p_day
      ),
      area: p_area,
      identification: p_identification,
      type: p_type,
      institution: p_institution 
    )

    @new_user = User.new(
      id_user: p_identification,
      username: p_username,
      password: p_password
    )

    respond_to do |format|
      if @functionary.save
        @new_user.save
        format.html { redirect_to @functionary, notice: 'Functionary was successfully created.' }
        format.json { render :show, status: :created, location: @functionary }
      else
        format.html { render :new }
        format.json { render json: @functionary.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /functionaries/1
  # PATCH/PUT /functionaries/1.json
  def update
    respond_to do |format|
      if @functionary.update(functionary_params)
        format.html { redirect_to @functionary, notice: 'Functionary was successfully updated.' }
        format.json { render :show, status: :ok, location: @functionary }
      else
        format.html { render :edit }
        format.json { render json: @functionary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /functionaries/1
  # DELETE /functionaries/1.json
  def destroy
    @functionary.destroy
    respond_to do |format|
      format.html { redirect_to functionaries_url, notice: 'Functionary was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_functionary
      @functionary = Functionary.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def functionary_params
      params.require(:functionary).permit(:name, :init_date, :area, :identification, :type, :institution)
    end
end
