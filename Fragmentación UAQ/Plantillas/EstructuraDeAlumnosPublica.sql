/*
===================================================================================================================================
						    PLANTILLA PARA LA FRAGMENTACIÓN VERTICAL DE ALUMNOS (INFORMACIÓN PÚBLICA)
===================================================================================================================================
*/


-- (1) Datos personales del alumno
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Alumnos' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	CREATE TABLE dbo.Alumnos(
		ID_Alumno INT IDENTITY(1, 1) PRIMARY KEY,
		Nombres NVARCHAR(100) NOT NULL,
		Apellido_paterno NVARCHAR(100) NOT NULL,
		Apellido_materno NVARCHAR(100) NOT NULL,
		Fecha_nacimiento DATE NOT NULL,
		Pais_origen NVARCHAR(100) NOT NULL,
		Correo_personal NVARCHAR(255) NOT NULL,
		ID_Sexo INT NOT NULL,
		CONSTRAINT FK_Alumno_Sexo FOREIGN KEY(ID_Sexo) REFERENCES Sexos(ID_Sexo)
	);
END