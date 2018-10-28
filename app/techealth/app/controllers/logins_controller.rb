class LoginsController < ApplicationController
  before_action :set_login, only: [:show, :edit, :update, :destroy]

  # GET /logins
  # GET /logins.json
  def index
  end

  # GET /logins/new
  def new
    @login = Login.new
  end

  # POST /logins
  # POST /logins.json
  def create
    @actual_user = 0
    p_username = params[:login][:username]
    p_password = params[:login][:password]
    @user_exist = User.where(username: p_username).exists?
    if @user_exist
      @user_exist = User.find_by(username: p_username)
      if (@user_exist.password == p_password)
        @user_exist_1 = Patient.where(id_patient: @user_exist.id_user).exists?
        if @user_exist_1
          @actual_user = Patient.find_by(id_patient: @user_exist.id_user)
          redirect_to controller: 'appointment_patients', id: @actual_user.id_patient and return
        else
          @actual_user = Functionary.find_by(identification: @user_exist.id_user)
          type_functionary = @actual_user.type
          if (type_functionary == 'Secretario')
            redirect_to secretaries_path, notice: "USER TYPE: Secretario" and return
          elsif (type_functionary == 'Doctor')
            redirect_to doctors_path, notice: "USER TYPE: Doctor" and return
          elsif (type_functionary == 'Administrador')
            redirect_to administrators_path, notice: "USER TYPE: Administrador" and return
          end
        end
      else
        redirect_to logins_path, notice: "WRONG PASSWORD" and return
      end
    else
      redirect_to logins_path, notice: "USERNAME NOT FOUNDED" and return
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_login
      @login = Login.find(params[:id])
    end
end
