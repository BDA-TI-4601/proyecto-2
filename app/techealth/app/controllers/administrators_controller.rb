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

    # clean tables before start
    clean_tables()

    # treatments type
    query_1()
    
    # diagnoses range
    query_2()
    
    # illness most frecuent
    query_3()
    
    @amount_apps = []
    
    render 'index'
  end
  helper_method :refresh

  def operations
    # clean tables before start
    clean_tables()

    # read parameter "operation"
    p_operation = params[:operation]

    # choose filter by "operation"
    if ( p_operation == 'date_filter' )

      # read parameters
      p_initial_date = params[:initial_date]
      p_final_date = params[:final_date]

      # call function
      filter_by_date( p_initial_date, p_final_date )

      # return result
      flash[:notice] = "OK: Filtered by date"
      render 'index'

    elsif ( p_operation == 'status_filter' )
      
      # read parameters
      p_status = params[:status]

      # call function
      filter_by_status( p_status )

      # return result
      flash[:notice] = "OK: Filtered by status"
      render 'index'

    elsif ( p_operation == 'area_filter' )
      
      # read parameters
      p_area = params[:area]

      # call function
      filter_by_area( p_area )

      # return result
      flash[:notice] = "OK: Filtered by area"
      render 'index'
    elsif ( p_operation == 'patient_filter' )

      # read parameters
      p_id_patient = params[:patient].to_i

      # call function
      filter_by_patient( p_id_patient )

      #return result
      flash[:notice] = "OK: Filtered by patient's id"
      render 'index'

    else

      # return error result
      flash[:notice] = "error: Operation doesn't exist!"
      render 'index'

    end
  end

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
    group = {
      '$group' => {
        '_id' => '$type',
        'count' => {
          '$sum' => 1
        },
        'average' => {
          '$avg' => '$total'
        }
      }
    }

    list = []
    data = Treatment.collection.aggregate( [group] )
    data.each do |i|
      actual = Query1.new
      actual.type = i[:_id]
      actual.amount = i[:count].to_i
      actual.average = i[:average]
      list += [actual]
    end
    @assigned_treatments = list
  end

  def query_2
    group = {
      '$group' => {
        '_id' => '$id_patient',
        'count' => {
          '$push' => {
            '$size' => '$id_diagnoses'
          }
        }
      }
    }

    project = {
      '$project' => {
        '_id' => 0,
        'patient' => '$_id',
        'max' => {
          '$max' => '$count'
        },
        'min' => {
          '$min' => '$count'
        }
      }
    }

    list = []
    data = Appointment.collection.aggregate([
      group,
      project
    ])
    data.each do |i|
      actual = Query2.new
      actual.patient = i[:patient]
      actual.amount = [i[:max], i[:min]]
      list += [actual]
    end
    @range_diagnoses = list
  end

  def query_3
    project = {
      '$project' => {
        '_id' => 0,
        'id_diagnoses' => 1
      }
    }

    unwind_1 = {
      '$unwind' => '$id_diagnoses'
    }

    lookup = {
      '$lookup' => {
        'from' => 'diagnoses',
        'localField' => 'id_diagnoses.id',
        'foreignField' => 'id_diagnose',
        'as' => 'illness'
      }
    }

    group = {
      '$group' => {
        '_id' => '$illness.name',
        'count' => {
          '$sum' => 1
        }
      }
    }

    unwind_2 = {
      '$unwind' => '$_id'
    }

    descending_sort = {
      '$sort' => {
        'count' => -1
      }
    }

    list = []
    data = Appointment.collection.aggregate([
      project,
      unwind_1,
      lookup,
      group,
      unwind_2,
      descending_sort
    ])
    data.each do |i|
      actual = Query3.new
      actual.illness = i[:_id]
      actual.amount = i[:count].to_i
      list += [actual]
      break
    end
    @disease_stadistics = list
  end

  def clean_tables
    @assigned_treatments = []
    @range_diagnoses = []
    @disease_stadistics = []
    @amount_apps = []
  end

  def filter_by_date( initial_date, final_date )

    match = {
      '$match' => {
        'app_date' => {
          '$gte' => Date.strptime(initial_date, '%Y-%m-%d'),
          '$lt' => Date.strptime(final_date, '%Y-%m-%d')
        }
      }
    }

    group = {
      '$group' => {
        '_id' => '$id_patient',
        'count' => {
          '$sum' => 1
        }
      }
    }

    data = Appointment.collection.aggregate([
      match,
      group
    ])

    list = []
    data.each do |i|
      actual = Query4.new
      actual.patient = i[:_id]
      actual.amount = i[:count]
      list += [actual]
    end
    @amount_apps = list
  end

  def filter_by_status( status )
    match = {
      '$match' => {
        'status' => {
          '$eq' => status
        }
      }
    }

    group = {
      '$group' => {
        '_id' => '$id_patient',
        'count' => {
          '$sum' => 1
        }
      }
    }

    data = Appointment.collection.aggregate([
      match,
      group
    ])

    list = []
    data.each do |i|
      actual = Query4.new
      actual.patient = i[:_id]
      actual.amount = i[:count]
      list += [actual]
    end
    @amount_apps = list
  end

  def filter_by_area( area )
    match = {
      '$match' => {
        'area' => {
          '$eq' => area
        }
      }
    }

    group = {
      '$group' => {
        '_id' => '$id_patient',
        'count' => {
          '$sum' => 1
        }
      }
    }

    data = Appointment.collection.aggregate([
      match,
      group
    ])

    list = []
    data.each do |i|
      actual = Query4.new
      actual.patient = i[:_id]
      actual.amount = i[:count]
      list += [actual]
    end
    @amount_apps = list
  end

  def filter_by_patient( patient )
    match = {
      '$match' => {
        'id_patient' => {
          '$eq' => patient
        }
      }
    }

    group = {
      '$group' => {
        '_id' => '$id_patient',
        'count' => {
          '$sum' => 1
        }
      }
    }

    data = Appointment.collection.aggregate([
      match,
      group
    ])

    list = []
    data.each do |i|
      actual = Query4.new
      actual.patient = i[:_id]
      actual.amount = i[:count]
      list += [actual]
    end
    @amount_apps = list
  end

end
