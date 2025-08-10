/*
===================================================================================================================================
							PLANTILLA PARA LA FRAGMENTACIÓN VERTICAL DE ALUMNOS (INFORMACIÓN PRIVADA)
===================================================================================================================================
*/


-- (1) Datos personales privados del alumno
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'AlumnosPrivado' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	CREATE TABLE dbo.AlumnosPrivado(
		ID_Alumno INT PRIMARY KEY,
		CURP CHAR(18) NOT NULL UNIQUE,
		NSS CHAR(15) NOT NULL UNIQUE,
		Telefono VARCHAR(15) NOT NULL UNIQUE,
		ID_Direccion INT NOT NULL,
		CONSTRAINT FK_Alumno_InfoPrivada FOREIGN KEY(ID_Alumno) REFERENCES Alumnos(ID_Alumno),
		CONSTRAINT FK_Alumno_Direccion FOREIGN KEY(ID_Direccion) REFERENCES Direcciones(ID_Direccion)
	);
END