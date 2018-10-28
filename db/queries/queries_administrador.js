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




