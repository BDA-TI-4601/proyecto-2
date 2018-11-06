
# Cantidad de veces de un tipo de tratamiento
@type = params[:type]
Treatment.where(type: @type).count

# Monto promedio de un tipo de tratamiento
Treatment.where(type: @type).avg(:total)

# Rango de enfermedades
# ------------------NO SÉ--------------------

# Enfermedades más comunes
## Retorna la lista de las distintas enfermedades 
listaEnfermedades = Array.new
listaEnfermedades = Diagnose.distinct(:name)
# Iterar sobre la lista
nombreMayor=""
cantidadMayor=0
## Para cada enfermedad de <listaEnfermedades> hacer: 
Diagnose.where(name: listaEnfermedades[i]).count
## Comparar el resultado con mayor
### Si es mayor entonces actualizar nombreMayor(listaEnfermedades[i]) y cantidadMayor (Diagnose.where(name: listaEnfermedades[i]).count) 

# Cantidad de citas por paciente
@p_id = params[:id_patient]
Appointment.where(id_patient: @p_id).count

# Cantidad de citas en un rango de fechas
@p_initial_date = params[:initial_date]
@p_final_date = params[:final_date]
query = 
{
  'app_date' => 
  {
    '$gte' => Date.strptime(@p_initial_date, '%Y-%m-%d'),
    '$lt' => Date.strptime(@p_final_date, '%Y-%m-%d')
  }
}
Appointment.where(query).count

# Cantidad de citas por especialidad
@p_area = params[:area]
Appointment.where(area: @p_area).count

# Cantidad de citas por estado
@p_status = params[:status]
Appointment.where(status: @p_status).count


/*  Por tipo de tratamiento,
    cantidad de veces asignado y
    promedio de monto */
db.Treatment.aggregate( 
    [
        {
            $group : {
                "_id" : 0,
                "count" : {
                    $sum : 1
                },
                "average" : {
                    $avg : "$total"
                }
            }
        }
    ]
)

/*  Rango de diagnosticos */
db.appointments.aggregate(
    [
        {
            $group : {
                "_id" : "$id_patient",
                "count" : {
                    $push : {
                        $size : "$id_diagnoses"
                    }
                }
            }
        },
        {
            $project : {
                "_id" : 0,
                "patient" : "$_id",
                "max" : {
                    $max : "$count"
                },
                "min" : {
                    $min : "$count"
                }
            }
        }
    ]
)


/*  Enfermedad más diagnosticada con
    cantidad de veces que ha sido asignada*/
db.appointments.aggregate(
    [
        {
            $project : {
                "_id" : 0,
                "id_diagnoses" : 1
            }
        },
        {
            $unwind : "$id_diagnoses"
        },
        {
            $lookup : {
                from : "diagnoses",
                localField : "id_diagnoses.id",
                foreignField : "id_diagnose",
                as : "illness"
            }
        },
        {
            $group : {
                "_id" : "$illness.name",
                "count" : {
                    "$sum" : 1
                }
            }
        },
        {
            $unwind : "$_id"
        },
        {
            $sort : {
                "count" : -1
            }
        }
    ]
)


