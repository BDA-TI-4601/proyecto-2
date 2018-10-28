/* Solicitar cita */
db.Appointment.insert(
	{
		"area": ,
		"app_date": ,
		"observation": ,
		"id_patient":
	}
)

/* Cancelar cita */
db.Appointment.update(
	{"app_number": id
	{ $set: 
		{
			"status":"Cancelada"
		} 
	}
)

/* Citas asociadas al paciente */

// Por fecha
db.Appointment.find(
	{
    	"app_date": 
    		{
        		$gte: ISODate("2011-04-29T00:00:00.000Z"),
        		$lt: ISODate("2011-06-01T00:00:00.000Z")
			}
	}
)

// Por estado 
db.Appointment.find(
	{
		"status":
	}
)

// Por especialidad
db.Appointment.find(
	{
		"area":
	}
)