/* Cancelar cita del paciente */
db.Appointment.update(
	{"app_number":12}, 
	{ $set: {"status":"Cancelada"} }
)

/* Asignar cita del paciente */
db.Appointment.update(
	{"app_number":12}, 
	{ $set: {"status":"Asignada"} }
)

/* Citas registradas en el sistema */
db.Appointment.find()

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

/* Citas por nombre paciente */
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