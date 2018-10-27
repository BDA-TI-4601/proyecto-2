/* Registrar diagnósticos */
db.Diagnose.insert(
    {
        "name": ,
        "symptoms": ,
        "level": ,
        "observation": ,
        "id_patient":
    }
)

/* Registrar tratamientos */
db.Treatment.insert(
    {
      "name": ,
      "type": ,
      "dosis": ,
      "total": ,
      "id_patient":		  
    }
)   

/* Consultar información de paciente */
db.Patient.find(
        {
            "identification": 304960870
        } 
)

/* Citas por rango de fechas */
db.Appointment.find({
    "app_date": {
        $gte: ISODate("2011-04-29T00:00:00.000Z"),
        $lt: ISODate("2011-06-01T00:00:00.000Z")
    }
})

/* Citas por estado */
db.Appointment.find(	
    {
        "status":"Registrada"
    } 
)

/* Citas por especialidad */
db.Appointment.find(	
    {
        "area":"Emergencias"
    } 
)

/* Citas por cedula del paciente */
db.Appointment.aggregate ([
    {   
        $match:  
        {
            "id_patient":111111111
        } 
    },
    {
        $lookup:
        {
            from: "Patient",
            localField: "id_patient",
            foreignField: "identification",
            as: "info_patient"
        }		 
    }
  ])


/* Información de citas, info del paciente de la cita y sus diagnosticos */
db.Appointment.aggregate ([
	{
		$lookup:
			{
				from: "Patient",
				localField: "id_patient",
				foreignField: "identification",
				as: "info_patient"
			}		 
 	}, 
 	{
 		$lookup:
			{
				from: "Diagnose",
				localField: "id_patient",
				foreignField: "id_patient",
				as: "patient_diagnoses"
			}
 	},
 	{
 		$lookup:
			{
				from: "Treatment",
				localField: "id_patient",
				foreignField: "id_patient",
				as: "patient_treatments"
			}
 	}
])