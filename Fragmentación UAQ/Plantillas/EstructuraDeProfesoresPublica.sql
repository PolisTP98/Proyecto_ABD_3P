/*
===================================================================================================================================
						  PLANTILLA PARA LA FRAGMENTACIÓN VERTICAL DE PROFESORES (INFORMACIÓN PÚBLICA)
===================================================================================================================================
*/


-- (1) Datos personales del profesor
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Profesores' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	CREATE TABLE dbo.Profesores(
		ID_Profesor INT IDENTITY(1, 1) PRIMARY KEY,
		Nombres NVARCHAR(100) NOT NULL,
		Apellido_paterno NVARCHAR(100) NOT NULL,
		Apellido_materno NVARCHAR(100) NOT NULL,
		Fecha_nacimiento DATE NOT NULL,
		Pais_origen NVARCHAR(100) NOT NULL,
		Correo_personal NVARCHAR(255) NOT NULL,
		ID_Sexo INT NOT NULL,
		ID_Campus INT NOT NULL,
		CONSTRAINT FK_Profesor_Sexo FOREIGN KEY(ID_Sexo) REFERENCES Sexos(ID_Sexo),
		CONSTRAINT FK_Profesor_Campus FOREIGN KEY(ID_Campus) REFERENCES Campus(ID_Campus)
	);
END