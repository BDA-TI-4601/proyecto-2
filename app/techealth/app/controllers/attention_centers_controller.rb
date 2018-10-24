class AttentionCentersController < ApplicationController
  before_action :set_attention_center, only: [:show, :edit, :update, :destroy]

  # GET /attention_centers
  # GET /attention_centers.json
  def index
    @attention_centers = AttentionCenter.all
  end

  # GET /attention_centers/1
  # GET /attention_centers/1.json
  def show
  end

  # GET /attention_centers/new
  def new
    @attention_center = AttentionCenter.new
  end

  # GET /attention_centers/1/edit
  def edit
  end

  # POST /attention_centers
  # POST /attention_centers.json
  def create
    @attention_center = AttentionCenter.new(attention_center_params)

    respond_to do |format|
      if @attention_center.save
        format.html { redirect_to @attention_center, notice: 'Attention center was successfully created.' }
        format.json { render :show, status: :created, location: @attention_center }
      else
        format.html { render :new }
        format.json { render json: @attention_center.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attention_centers/1
  # PATCH/PUT /attention_centers/1.json
  def update
    respond_to do |format|
      if @attention_center.update(attention_center_params)
        format.html { redirect_to @attention_center, notice: 'Attention center was successfully updated.' }
        format.json { render :show, status: :ok, location: @attention_center }
      else
        format.html { render :edit }
        format.json { render json: @attention_center.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attention_centers/1
  # DELETE /attention_centers/1.json
  def destroy
    @attention_center.destroy
    respond_to do |format|
      format.html { redirect_to attention_centers_url, notice: 'Attention center was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attention_center
      @attention_center = AttentionCenter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attention_center_params
      params.require(:attention_center).permit(:code, :name, :place, :capacity, :center_type)
    end
end
