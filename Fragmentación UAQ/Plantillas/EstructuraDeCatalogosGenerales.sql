/*
===================================================================================================================================
											  PLANTILLA DE LOS CATÁLOGOS GENERALES
===================================================================================================================================
*/


-- (1) Sexos válidos de los alumnos/maestros
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Sexos' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	CREATE TABLE dbo.Sexos(
		ID_Sexo INT IDENTITY(1, 1) PRIMARY KEY,
		Nombre VARCHAR(50) NOT NULL
	);
END

-- (2) Estatus del alumno
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'EstatusDeAlumnos' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	CREATE TABLE dbo.EstatusDeAlumnos(
		ID_EstatusAlumno INT IDENTITY(1, 1) PRIMARY KEY,
		Nombre VARCHAR(50) NOT NULL
	);
END

-- (3) Estatus del profesor
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'EstatusDeProfesores' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	CREATE TABLE dbo.EstatusDeProfesores(
		ID_EstatusProfesor INT IDENTITY(1, 1) PRIMARY KEY,
		Nombre VARCHAR(50) NOT NULL
	);
END

-- (4) Modalidades de las especialidades
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Modalidades' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	CREATE TABLE dbo.Modalidades(
		ID_Modalidad INT IDENTITY(1, 1) PRIMARY KEY,
		Nombre VARCHAR(50) NOT NULL
	);
END

-- (5) Niveles educativos de las carreras
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'NivelesEducativos' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	CREATE TABLE dbo.NivelesEducativos(
		ID_Nivel INT IDENTITY(1, 1) PRIMARY KEY,
		Nombre VARCHAR(50) NOT NULL
	);
END