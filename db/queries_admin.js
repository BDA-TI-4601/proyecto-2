//QUERY 1



//----------------------------------------------------------//


//QUERY 2
//Rango de diagnosticos asociados por paciente 
db.appointments.aggregate([ 
    {
        $project: {
            _id:0,
             id_patient:1, 
             id_appointment:1,
              count: {
                         $size:"$id_diagnoses"
                    } 
        }
    }
])

//----------------------------------------------------------//

//QUERY 3
//Tres enfermedades mas diagnosticadas
db.appointments.aggregate( [
     {
          $unwind: "$id_diagnoses"
     },
     { 
         $sortByCount: "$id_diagnoses.id"
     },
     {
          $limit: 3
     }
 ] )


//----------------------------------------------------------//


//QUERY 4
//Cantidad de citas por paciente 
db.appointments.aggregate([ 
    {
         $match : {
             id_patient : 207440546
             }
    },
    {
         $group: { 
             _id: null, 
             count: { $sum: 1 }
         }
    }
])

//Cantidad de citas por especialidad 
db.appointments.aggregate([ 
    {
         $match : {
             area : "Ginecologia"
             }
    },
    {
         $group: { 
             _id: null, 
             count: { $sum: 1 }
         }
    }
])



//Cantidad de citas por estado 
db.appointments.aggregate([ 
    {
         $match : {
             status : "Registrada"
             }
    },
    {
         $group: { 
             _id: null, 
             count: { $sum: 1 }
         }
    }
])

//Cantidad de citas por rango de fechas
db.appointments.aggregate([ 
    { 
        $match : {
            "app_date" : {
                                $gte: ISODate("2014-01-01T00:00:00.0Z"), 
                                $lt:ISODate("2016-01-01T00:00:00.0Z")
                            } 
        } 
    },
    
    {
         $group: {
              _id: null, 
              count: { $sum: 1 } 
        }
    }
])

//Tres pacientes con más citas registradas
db.appointments.aggregate([ 
    {
        $sortByCount : "$id_patient"
    },
    {
        $limit : 3
    }
])