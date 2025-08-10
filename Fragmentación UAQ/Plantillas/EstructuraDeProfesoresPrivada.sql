/*
===================================================================================================================================
						  PLANTILLA PARA LA FRAGMENTACIÓN VERTICAL DE PROFESORES (INFORMACIÓN PRIVADA)
===================================================================================================================================
*/


-- (1) Datos personales privados del profesor
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'ProfesoresPrivado' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	CREATE TABLE dbo.ProfesoresPrivado(
		ID_Profesor INT PRIMARY KEY,
		RFC CHAR(13) NOT NULL UNIQUE,
		CURP CHAR(18) NOT NULL UNIQUE,
		NSS CHAR(15) NOT NULL UNIQUE,
		Telefono VARCHAR(15) NOT NULL UNIQUE,
		ID_Direccion INT NOT NULL,
		CONSTRAINT FK_Profesor_InfoPrivada FOREIGN KEY(ID_Profesor) REFERENCES Profesores(ID_Profesor),
		CONSTRAINT FK_Profesor_Direccion FOREIGN KEY(ID_Direccion) REFERENCES Direcciones(ID_Direccion)
	);
END