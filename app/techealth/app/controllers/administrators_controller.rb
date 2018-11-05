class AdministratorsController < ApplicationController
  before_action :set_administrator, only: [:show, :edit, :update, :destroy]

  # GET /administrators
  # GET /administrators.json
  def index
    @assigned_treatments = []
    @range_diagnoses = []
    @disease_stadistics = []
    @amount_apps = []
  end

  def refresh
    query_1
    @assigned_treatments = []
    @range_diagnoses = []
    @disease_stadistics = []
    @amount_apps = []
    render 'index'
  end
  helper_method :refresh

  private
  
  class Query1
    attr_accessor :type, :amount, :average 
  end
  
  class Query2
    attr_accessor :patient, :amount
  end

  class Query3
    attr_accessor :illness, :amount 
  end

  class Query4
    attr_accessor :patient, :amount
  end

  def query_1
    all_treatments = Treatment.all
    results = []
    all_treatments.each do |a_t|
      new_obj = Query1.new
      new_obj.type = a_t.name
      results += [new_obj]
    end
    all_appointments = Appointment.all
    aux_diag = []
    aux_amount = []
    all_appointments.each do |a_a|
      if !a_a.id_diagnoses.nil?
        aux_diag += a_a.id_diagnoses
      end
    end
    aux_diag.each do |a_d|
      aux_amount += Treatment.find_by(id_treatment: a_d)
    end


  end

  def query_2
  end

  def query_3
  end

  def query_4
  end

end
