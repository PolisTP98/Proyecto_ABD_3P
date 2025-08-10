/*
===================================================================================================================================
								    PLANTILLA PARA LA FRAGMENTACIÓN HORIZONTAL DE UN CAMPUS
===================================================================================================================================
*/

-- (1) Direcciones
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Direcciones' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	CREATE TABLE dbo.Direcciones(
		ID_Direccion INT IDENTITY(1, 1) PRIMARY KEY,
		Pais NVARCHAR(100) NOT NULL,
		Estado NVARCHAR(100) NOT NULL,
		Municipio NVARCHAR(100) NOT NULL,
		Localidad_comunidad NVARCHAR(100) NOT NULL DEFAULT '',
		Calle NVARCHAR(100) NOT NULL,
		No_exterior VARCHAR(10) NOT NULL DEFAULT 'S/N',
		No_interior VARCHAR(10) NOT NULL DEFAULT 'S/N',
		Colonia NVARCHAR(100) NOT NULL DEFAULT 'N/D',
		Tipo_asentamiento NVARCHAR(50) NOT NULL DEFAULT 'N/A',
		Tipo_vialidad NVARCHAR(50) NOT NULL DEFAULT 'N/A',
		Codigo_postal CHAR(5) NOT NULL
	);
END

-- (2) Nombre y ubicación de los campus de la Universidad
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Campus' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	CREATE TABLE dbo.Campus(
		ID_Campus INT IDENTITY(1, 1) PRIMARY KEY,
		Nombre NVARCHAR(100) NOT NULL UNIQUE,
		ID_Direccion INT NOT NULL,
		Estatus BIT NOT NULL DEFAULT 1,
		CONSTRAINT FK_Campus_Direccion FOREIGN KEY(ID_Direccion) REFERENCES Direcciones(ID_Direccion)
	);
END

-- (3) Aulas
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Aulas' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	CREATE TABLE dbo.Aulas(
		ID_Aula INT IDENTITY(1, 1) PRIMARY KEY,
		Nombre VARCHAR(50) NOT NULL,
		Estatus BIT NOT NULL DEFAULT 1
	);
END

-- (4) Especialidades
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Especialidades' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	CREATE TABLE dbo.Especialidades(
		ID_Especialidad INT IDENTITY(1, 1) PRIMARY KEY,
		ID_Campus INT NOT NULL,
		Nombre NVARCHAR(100) NOT NULL,
		Fecha_registro DATE NOT NULL DEFAULT GETDATE(),
		ID_Modalidad INT NOT NULL,
		Estatus BIT NOT NULL DEFAULT 1,
		CONSTRAINT FK_Especialidad_Campus FOREIGN KEY(ID_Campus) REFERENCES Campus(ID_Campus),
		CONSTRAINT FK_Especialidad_Modalidad FOREIGN KEY(ID_Modalidad) REFERENCES Modalidades(ID_Modalidad)
	);
END

-- (5) Carreras
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Carreras' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	CREATE TABLE dbo.Carreras(
		ID_Carrera INT IDENTITY(1, 1) PRIMARY KEY,
		ID_Campus INT NOT NULL,
		Clave CHAR(20) NOT NULL,
		Nombre NVARCHAR(100) NOT NULL,
		Fecha_registro DATE NOT NULL DEFAULT GETDATE(),
		Duracion_semestres TINYINT NOT NULL,
		Year_vigencia SMALLINT NOT NULL,
		ID_Nivel INT NOT NULL,
		Estatus BIT NOT NULL DEFAULT 1,
		CONSTRAINT FK_Carrera_Campus FOREIGN KEY(ID_Campus) REFERENCES Campus(ID_Campus),
		CONSTRAINT FK_Carrera_NivelEducativo FOREIGN KEY(ID_Nivel) REFERENCES NivelesEducativos(ID_Nivel)
	);
END

-- (6) Materias de las carreras
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Materias' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	CREATE TABLE dbo.Materias(
		ID_Materia INT IDENTITY(1, 1) PRIMARY KEY,
		Clave CHAR(20) NOT NULL,
		Nombre NVARCHAR(100) NOT NULL,
		Fecha_registro DATE NOT NULL DEFAULT GETDATE(),
		Creditos TINYINT NOT NULL,
		Estatus BIT NOT NULL DEFAULT 1
	);
END

-- (7) Asignar una o más aulas a un campus
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'AulasPorCampus' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	CREATE TABLE dbo.AulasPorCampus(
		ID_Campus INT NOT NULL,
		ID_Aula INT NOT NULL,
		Estatus BIT NOT NULL DEFAULT 1,
		CONSTRAINT PK_Campus_Aula PRIMARY KEY(ID_Campus, ID_Aula),
		FOREIGN KEY(ID_Campus) REFERENCES Campus(ID_Campus),
		FOREIGN KEY(ID_Aula) REFERENCES Aulas(ID_Aula)
	);
END

-- (8) Asignar una o más materias a una carrera
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'MateriasPorCarrera' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	CREATE TABLE dbo.MateriasPorCarrera(
		ID_Carrera INT NOT NULL,
		ID_Materia INT NOT NULL,
		Estatus BIT NOT NULL DEFAULT 1,
		CONSTRAINT PK_Carrera_Materia PRIMARY KEY(ID_Carrera, ID_Materia),
		FOREIGN KEY(ID_Carrera) REFERENCES Carreras(ID_Carrera),
		FOREIGN KEY(ID_Materia) REFERENCES Materias(ID_Materia)
	);
END

-- (9) Grupos de alumnos
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Grupos' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	CREATE TABLE dbo.Grupos(
		ID_Grupo INT IDENTITY(1, 1) PRIMARY KEY,
		ID_Carrera INT NOT NULL,
		Clave CHAR(20) NOT NULL,
		Nombre VARCHAR(50) NOT NULL,
		Semestre_actual TINYINT NOT NULL,
		Estatus BIT NOT NULL DEFAULT 1,
		CONSTRAINT FK_Grupo_Carrera FOREIGN KEY(ID_Carrera) REFERENCES Carreras(ID_Carrera)
	);
END

-- (10) Datos académicos del alumno
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'ExpedientesAcademicos' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	CREATE TABLE dbo.ExpedientesAcademicos(
		ID_Expediente INT IDENTITY(1, 1) PRIMARY KEY,
		Matricula CHAR(15) NOT NULL UNIQUE,
		ID_Alumno INT NOT NULL,
		ID_Grupo INT NOT NULL,
		Periodo VARCHAR(20) NOT NULL,
		Fecha_ingreso DATE NOT NULL DEFAULT GETDATE(),
		Fecha_egreso DATE,
		Fecha_baja_academica DATE,
		Promedio_general DECIMAL(4, 2) NOT NULL DEFAULT 0.00,
		Correo_institucional NVARCHAR(255) NOT NULL UNIQUE,
		Baja_temporal BIT NOT NULL DEFAULT 1, -- Si el estado es 1, puede darse de baja temporal
		ID_EstatusAlumno INT NOT NULL DEFAULT 1,
		ID_Campus INT NOT NULL,
		CONSTRAINT FK_Expediente_Alumno FOREIGN KEY(ID_Alumno) REFERENCES Alumnos(ID_Alumno),
		CONSTRAINT FK_Expediente_Grupo FOREIGN KEY(ID_Grupo) REFERENCES Grupos(ID_Grupo),
		CONSTRAINT FK_ExpedienteAcademico_Estatus FOREIGN KEY(ID_EstatusAlumno) REFERENCES EstatusDeAlumnos(ID_EstatusAlumno),
		CONSTRAINT FK_Expediente_Campus FOREIGN KEY(ID_Campus) REFERENCES Campus(ID_Campus)
	);
END

-- (11) Datos laborales del profesor
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'ExpedientesLaborales' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	CREATE TABLE dbo.ExpedientesLaborales(
		ID_Profesor INT PRIMARY KEY,
		Matricula CHAR(15) NOT NULL UNIQUE,
		Fecha_contratacion DATE NOT NULL DEFAULT GETDATE(),
		Fecha_fin_contrato DATE,
		Correo_institucional NVARCHAR(255) NOT NULL UNIQUE,
		Salario_quincenal DECIMAL(6, 2) NOT NULL,
		ID_EstatusProfesor INT NOT NULL DEFAULT 1,
		CONSTRAINT FK_Profesor_ExpedienteLaboral FOREIGN KEY(ID_Profesor) REFERENCES Profesores(ID_Profesor),
		CONSTRAINT FK_ExpedienteLaboral_Estatus FOREIGN KEY(ID_EstatusProfesor) REFERENCES EstatusDeProfesores(ID_EstatusProfesor),
	);
END

-- (12) Asignar una o más especialidades a un profesor
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'EspecialidadesPorProfesor' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	CREATE TABLE dbo.EspecialidadesPorProfesor(
		ID_Profesor INT NOT NULL,
		ID_Especialidad INT NOT NULL,
		Estatus BIT NOT NULL DEFAULT 1,
		CONSTRAINT PK_Profesor_Especialidad PRIMARY KEY(ID_Profesor, ID_Especialidad),
		FOREIGN KEY(ID_Profesor) REFERENCES Profesores(ID_Profesor),
		FOREIGN KEY(ID_Especialidad) REFERENCES Especialidades(ID_Especialidad)
	);
END

-- (13) Asignar uno o más grupos y materias a un profesor
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'GruposPorProfesor' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	CREATE TABLE dbo.GruposPorProfesor(
		ID_GrupoProfesor INT IDENTITY(1, 1) PRIMARY KEY,
		ID_Profesor INT NOT NULL,
		ID_Grupo INT NOT NULL,
		ID_Materia INT NOT NULL,
		Hora_inicio TIME(0) NOT NULL,
		Hora_fin TIME(0) NOT NULL,
		ID_Aula INT NOT NULL,
		Estatus BIT NOT NULL DEFAULT 1,
		CONSTRAINT FK_GrupoProfesor_Profesor FOREIGN KEY(ID_Profesor) REFERENCES Profesores(ID_Profesor),
		CONSTRAINT FK_GrupoProfesor_Grupo FOREIGN KEY(ID_Grupo) REFERENCES Grupos(ID_Grupo),
		CONSTRAINT FK_GrupoProfesor_Materia FOREIGN KEY(ID_Materia) REFERENCES Materias(ID_Materia),
		CONSTRAINT FK_GrupoProfesor_Aula FOREIGN KEY(ID_Aula) REFERENCES Aulas(ID_Aula)
	);
END

-- (14) Inscripciones de alumnos en la Universidad
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Inscripciones' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	CREATE TABLE dbo.Inscripciones(
		ID_Inscripcion INT IDENTITY(1, 1) PRIMARY KEY,
		ID_GrupoProfesor INT NOT NULL,
		ID_Expediente INT NOT NULL,
		Periodo VARCHAR(20) NOT NULL,
		Fecha_inscripcion DATE NOT NULL DEFAULT GETDATE(),
		CONSTRAINT FK_Inscripcion_GrupoProfesor FOREIGN KEY(ID_GrupoProfesor) REFERENCES GruposPorProfesor(ID_GrupoProfesor),
		CONSTRAINT FK_Inscripcion_ExpedienteAcademico FOREIGN KEY(ID_Expediente) REFERENCES ExpedientesAcademicos(ID_Expediente)
	);
END