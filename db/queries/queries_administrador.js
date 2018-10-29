/* Centros de atención */

// Registrar 
db.AttentionCenter.insert(
    {
    	"code":
        "name": ,
        "place": ,
        "capacity": ,
        "center_type": 
    }
)

// Modificar
db.AttentionCenter.update(
	{"code": }, 
	{ $set: 
		{
			"name": , 
			"place": ,
			"capacity" ,
			"center_type"  
		}
	}
)

// Eliminar
db.AttentionCenter.remove(
	{"code": }
)

/* Funcionario */

// Registrar
db.Functionary.insert(
    {
    	"name":
        "init_date": ,
        "area": ,
        "id": ,
        "type": 
    }
)

// Modificar
db.Functionary.update(
	{"id": }, 
	{ $set: 
		{
			"name": , 
			"init_date": ,
			"area" ,
			"type"  
		}
	}
)

// Eliminar
db.Functionary.remove(
	{"id": }
)

/* Diagnósticos */

// Registrar
db.Diagnose.insert(
    {
    	"name":
        "symptoms": ,
        "id": ,
        "level": ,
        "observations": ,
        "id_patient" 
    }
)

// Modificar
db.Diagnose.update(
	{"id": }, 
	{ $set: 
		{
			"name": , 
			"init_date": ,
			"area" ,
			"type"  
		}
	}
)

// Eliminar
db.Diagnose.remove(
	{"id": }
)

/* Tratamientos */
db.Treatment.insert(
    {
    	"id": ,
    	"name":
        "type": ,
        "dosis": ,
        "total": ,
        "id_patient": ,
        "secundary_effects": ,
        "days": 
    }
)

// Modificar
db.Treatment.update(
	{"id": }, 
	{ $set: 
		{
	    	"name":
	        "type": ,
	        "dosis": ,
	        "total": ,
	        "id_patient": ,
	        "secundary_effects": ,
	        "days":  
		}
	}
)

// Eliminar
db.Treatment.remove(
	{"id": }
)

// Cantidad de tratamientos de un tipo
db.Treatment.count( { "type": } )

// Monto promedio por tipo de tratamiento
db.Treatment.aggregate([
	{
		$group: 
			{_id:"$type", 
			montoPromedio : {$avg : "$total"}
			}
	}
])

// Cantidad de citas por paciente
db.Appointment.aggregate([
	{
		$match:
		{"id_patient": }
	},
	{
		$group:
		{_id:"$id_patient",
		cantidadCitas:{$sum:1}}
	}
])

// Cantidad de citas por rango de fechas
db.Appointment.aggregate([
	{
		$match:
		{"app_date": 
			{
        		$gte: ISODate("2011-04-29T00:00:00.000Z"),
        		$lt: ISODate("2011-06-01T00:00:00.000Z")
    		}
		}
	{
		$group:
		{_id:"$id_patient",
		cantidadCitas:{$sum:1}}
	}
])

// Cantidad de citas por especialidad
db.Appointment.aggregate([
	{
		$match:
		{"area": }
	{
		$group:
		{_id:"$id_patient",
		cantidadCitas:{$sum:1}}
	}
])

// Cantidad de citas por estado
db.Appointment.aggregate([
	{
		$match:
		{"status": }
	{
		$group:
		{_id:"$id_patient",
		cantidadCitas:{$sum:1}}
	}
])

// Tres pacientes con más citas registradas
db.Treatment.aggregate([
	{
		$group:
		{_id:"$id_patient",
		cantidadCitas:{$sum:1}}
	},
	{$limit:3}
])







