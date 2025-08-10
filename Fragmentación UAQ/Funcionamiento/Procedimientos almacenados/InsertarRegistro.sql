/*
------------------------
(1) SP_InsertarDireccion
------------------------
*/

CREATE OR ALTER PROCEDURE dbo.SP_InsertarDireccion
	@Pais NVARCHAR(100),
	@Estado NVARCHAR(100),
	@Municipio NVARCHAR(100),
	@Localidad_comunidad NVARCHAR(100),
	@Calle NVARCHAR(100),
	@No_exterior VARCHAR(10) = NULL,
	@No_interior VARCHAR(10) = NULL,
	@Colonia NVARCHAR(100) = NULL,
	@Tipo_asentamiento NVARCHAR(50) = NULL,
	@Tipo_vialidad NVARCHAR(50) = NULL,
	@Codigo_postal CHAR(5),
	@ID_Direccion INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Modulo NVARCHAR(50) = 'Direcciones';
	DECLARE @CamposObligatorios NVARCHAR(255) = '<Pais>, <Estado>, <Municipio>, <Calle>, <Codigo_postal>';
	DECLARE @CampoInvalido NVARCHAR(255);

	BEGIN TRY
		IF @Pais IS NULL OR TRIM(@Pais) = '' OR @Estado IS NULL OR TRIM(@Estado) = ''
		   OR @Municipio IS NULL OR TRIM(@Municipio) = '' OR @Calle IS NULL OR TRIM(@Calle) = ''
		   OR @Codigo_postal IS NULL OR TRIM(@Codigo_postal) = ''
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50100, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		SET @Localidad_comunidad = ISNULL(NULLIF(TRIM(@No_exterior), ''), '');
		SET @No_exterior = ISNULL(NULLIF(TRIM(@No_exterior), ''), 'S/N');
		SET	@No_interior = ISNULL(NULLIF(TRIM(@No_interior), ''), 'S/N');
		SET	@Colonia = ISNULL(NULLIF(TRIM(@Colonia), ''), 'N/D');
		SET	@Tipo_asentamiento = ISNULL(NULLIF(TRIM(@Tipo_asentamiento), ''), 'N/A');
		SET	@Tipo_vialidad = ISNULL(NULLIF(TRIM(@Tipo_vialidad), ''), 'N/A');

		SELECT @ID_Direccion = ID_Direccion
		FROM dbo.Direcciones
		WHERE Pais = @Pais
		  AND Estado = @Estado
		  AND Municipio = @Municipio
		  AND Localidad_comunidad = @Localidad_comunidad
		  AND Calle = @Calle
		  AND No_exterior = @No_exterior
		  AND No_interior = @No_interior
		  AND Colonia = @Colonia
		  AND Tipo_asentamiento = @Tipo_asentamiento
		  AND Tipo_vialidad = @Tipo_vialidad
		  AND Codigo_postal = @Codigo_postal;

		IF @ID_Direccion IS NULL
		BEGIN
			INSERT INTO dbo.Direcciones(Pais, Estado, Municipio, Localidad_comunidad, Calle, No_exterior, No_interior, Colonia, Tipo_asentamiento, Tipo_vialidad, Codigo_postal)
			VALUES (@Pais, @Estado, @Municipio, @Localidad_comunidad, @Calle, @No_exterior, @No_interior, @Colonia, @Tipo_asentamiento, @Tipo_vialidad, @Codigo_postal);

			SET @ID_Direccion = SCOPE_IDENTITY();
		END
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO

/*
---------------------
(2) SP_InsertarCampus
---------------------
*/

CREATE OR ALTER PROCEDURE dbo.SP_InsertarCampus
	@Nombre NVARCHAR(100),
	@Estatus BIT = NULL,
	@Pais NVARCHAR(100),
	@Estado NVARCHAR(100),
	@Municipio NVARCHAR(100),
	@Localidad_comunidad NVARCHAR(100),
	@Calle NVARCHAR(100),
	@No_exterior VARCHAR(10),
	@No_interior VARCHAR(10),
	@Colonia NVARCHAR(100),
	@Tipo_asentamiento NVARCHAR(50),
	@Tipo_vialidad NVARCHAR(50),
	@Codigo_postal CHAR(5),
	@ID_Campus INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Modulo NVARCHAR(50) = 'Campus';
	DECLARE @CamposObligatorios NVARCHAR(255) = '<Nombre>';
	DECLARE @CampoInvalido NVARCHAR(255);

	BEGIN TRY
		IF @Nombre IS NULL OR TRIM(@Nombre) = ''
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50100, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		DECLARE @ID_Direccion INT;

		EXEC dbo.SP_InsertarDireccion
			@Pais, @Estado, @Municipio, @Localidad_comunidad,
			@Calle, @No_exterior, @No_interior, @Colonia,
			@Tipo_asentamiento, @Tipo_vialidad, @Codigo_postal,
			@ID_Direccion OUTPUT;

		IF EXISTS (SELECT 1 FROM dbo.Campus WHERE Nombre = @Nombre OR ID_Direccion = @ID_Direccion)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50200, @Modulo = @Modulo;
		END

		SET @Estatus = ISNULL(@Estatus, 1);
			
		INSERT INTO dbo.Campus(Nombre, ID_Direccion, Estatus) VALUES
		(@Nombre, @ID_Direccion, @Estatus);

		SET @ID_Campus = SCOPE_IDENTITY();
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO

/*
-------------------
(3) SP_InsertarAula
-------------------
*/

CREATE OR ALTER PROCEDURE dbo.SP_InsertarAula
	@Nombre VARCHAR(50),
	@Estatus BIT = NULL,
	@ID_Aula INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Modulo NVARCHAR(50) = 'Aulas';
	DECLARE @CamposObligatorios NVARCHAR(255) = '<Nombre>';
	DECLARE @CampoInvalido NVARCHAR(255);

	BEGIN TRY
		IF @Nombre IS NULL OR TRIM(@Nombre) = ''
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50100, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF EXISTS (SELECT 1 FROM dbo.Aulas WHERE Nombre = @Nombre)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50200, @Modulo = @Modulo;
		END

		SET @Estatus = ISNULL(@Estatus, 1);

		INSERT INTO dbo.Aulas(Nombre, Estatus) VALUES
		(@Nombre, @Estatus);

		SET @ID_Aula = SCOPE_IDENTITY();
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO

/*
---------------------------
(4) SP_InsertarEspecialidad
---------------------------
*/

CREATE OR ALTER PROCEDURE dbo.SP_InsertarEspecialidad
	@ID_Campus INT,
	@Nombre NVARCHAR(100),
	@Fecha_registro DATE = NULL,
	@ID_Modalidad INT,
	@Estatus BIT = NULL,
	@ID_Especialidad INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Modulo NVARCHAR(50) = 'Especialidades';
	DECLARE @CamposObligatorios NVARCHAR(255) = '<ID_Campus>, <Nombre>, <ID_Modalidad>';
	DECLARE @CampoInvalido NVARCHAR(255);

	BEGIN TRY
		IF @ID_Campus IS NULL OR @Nombre IS NULL OR TRIM(@Nombre) = '' OR @ID_Modalidad IS NULL
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50100, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF NOT EXISTS (SELECT 1 FROM dbo.Campus WHERE ID_Campus = @ID_Campus)
		BEGIN
			SET @CampoInvalido = '<ID_Campus>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END
		ELSE IF NOT EXISTS (SELECT 1 FROM dbo.Modalidades WHERE ID_Modalidad = @ID_Modalidad)
		BEGIN
			SET @CampoInvalido = '<ID_Modalidad>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END

		IF EXISTS (SELECT 1 FROM dbo.Especialidades WHERE ID_Campus = @ID_Campus AND Nombre = @Nombre)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50200, @Modulo = @Modulo;
		END

		SET @Fecha_registro = ISNULL(@Fecha_registro, GETDATE());
		SET @Estatus = ISNULL(@Estatus, 1);

		INSERT INTO dbo.Especialidades(ID_Campus, Nombre, Fecha_registro, ID_Modalidad, Estatus) 
		VALUES (@ID_Campus, @Nombre, @Fecha_registro, @ID_Modalidad, @Estatus);

		SET @ID_Especialidad = SCOPE_IDENTITY();
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO

/*
-------------------------
(5) SP_InsertarCarrera
-------------------------
*/

CREATE OR ALTER PROCEDURE dbo.SP_InsertarCarrera
	@ID_Campus INT,
	@Clave CHAR(20),
	@Nombre NVARCHAR(100),
	@Fecha_registro DATE = NULL,
	@Duracion_semestres TINYINT,
	@Year_vigencia SMALLINT,
	@ID_Nivel INT,
	@Estatus BIT = NULL,
	@ID_Carrera INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Year_actual SMALLINT = YEAR(GETDATE());
	DECLARE @Year_maximo SMALLINT = 2100;

	DECLARE @Modulo NVARCHAR(50) = 'Carreras';
	DECLARE @CamposObligatorios NVARCHAR(255) = '<ID_Campus>, <Clave>, <Nombre>, <Duracion_semestres>, <Year_vigencia>, <ID_Nivel>';
	DECLARE @CampoInvalido NVARCHAR(255);

	BEGIN TRY
		IF @ID_Campus IS NULL OR @Clave IS NULL OR TRIM(@Clave) = '' OR @Nombre IS NULL OR TRIM(@Nombre) = ''
		   OR @Duracion_semestres IS NULL OR @Year_vigencia IS NULL OR @ID_Nivel IS NULL
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50100, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF @Year_vigencia NOT BETWEEN @Year_actual AND @Year_maximo
		BEGIN
			SET @CampoInvalido = CONCAT('<Year_vigencia> El año de vigencia debe estar en el rango de ', @Year_actual, ' - ', @Year_maximo,  ' (', @Year_vigencia, ')');
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50600, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END

		IF NOT EXISTS (SELECT 1 FROM dbo.Campus WHERE ID_Campus = @ID_Campus)
		BEGIN
			SET @CampoInvalido = '<ID_Campus>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END
		ELSE IF NOT EXISTS (SELECT 1 FROM dbo.NivelesEducativos WHERE ID_Nivel = @ID_Nivel)
		BEGIN
			SET @CampoInvalido = '<ID_Nivel>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END

		IF EXISTS (SELECT 1 FROM dbo.Carreras WHERE Clave = @Clave)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50200, @Modulo = @Modulo;
		END
		
		SET @Fecha_registro = ISNULL(@Fecha_registro, GETDATE());
		SET @Estatus = ISNULL(@Estatus, 1);

		INSERT INTO dbo.Carreras(ID_Campus, Clave, Nombre, Fecha_registro, Duracion_semestres, Year_vigencia, ID_Nivel, Estatus) 
		VALUES (@ID_Campus, @Clave, @Nombre, @Fecha_registro, @Duracion_semestres, @Year_vigencia, @ID_Nivel, @Estatus);

		SET @ID_Carrera = SCOPE_IDENTITY();
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO

/*
----------------------
(6) SP_InsertarMateria
----------------------
*/

CREATE OR ALTER PROCEDURE dbo.SP_InsertarMateria
	@Clave CHAR(20),
	@Nombre NVARCHAR(100),
	@Fecha_registro DATE = NULL,
	@Creditos TINYINT,
	@Estatus BIT = NULL,
	@ID_Materia INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Modulo NVARCHAR(50) = 'Materias';
	DECLARE @CamposObligatorios NVARCHAR(255) = '<Clave>, <Nombre>, <Creditos>';
	DECLARE @CampoInvalido NVARCHAR(255);

	BEGIN TRY
		IF @Clave IS NULL OR TRIM(@Clave) = '' OR @Nombre IS NULL OR TRIM(@Nombre) = '' OR @Creditos IS NULL
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50100, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF @Creditos NOT BETWEEN 1 AND 12
		BEGIN
			SET @CampoInvalido = CONCAT('<Creditos> Los créditos debe estar en el rango de 1 - 12 (', @Creditos, ')');
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50600, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END

		IF EXISTS (SELECT 1 FROM dbo.Materias WHERE Clave = @Clave)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50200, @Modulo = @Modulo;
		END

		SET @Fecha_registro = ISNULL(@Fecha_registro, GETDATE());
		SET @Estatus = ISNULL(@Estatus, 1);

		INSERT INTO dbo.Materias(Clave, Nombre, Fecha_registro, Creditos, Estatus) VALUES
		(@Clave, @Nombre, @Fecha_registro, @Creditos, @Estatus);

		SET @ID_Materia = SCOPE_IDENTITY();
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO

/*
----------------------------
(7) SP_InsertarAulaPorCampus
----------------------------
*/

CREATE OR ALTER PROCEDURE dbo.SP_InsertarAulaPorCampus
	@ID_Campus INT,
	@ID_Aula INT,
	@Estatus BIT = NULL
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Modulo NVARCHAR(50) = 'AulasPorCampus';
	DECLARE @CamposObligatorios NVARCHAR(255) = '<ID_Campus>, <ID_Aula>';
	DECLARE @CampoInvalido NVARCHAR(255);

	BEGIN TRY
		IF @ID_Campus IS NULL OR @ID_Aula IS NULL
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50100, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF NOT EXISTS (SELECT 1 FROM dbo.Campus WHERE ID_Campus = @ID_Campus)
		BEGIN
			SET @CampoInvalido = '<ID_Campus>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END
		ELSE IF NOT EXISTS (SELECT 1 FROM dbo.Aulas WHERE ID_Aula = @ID_Aula)
		BEGIN
			SET @CampoInvalido = '<ID_Aula>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END

		IF EXISTS (SELECT 1 FROM dbo.AulasPorCampus WHERE ID_Campus = @ID_Campus AND ID_Aula = @ID_Aula)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50200, @Modulo = @Modulo;
		END

		SET @Estatus = ISNULL(@Estatus, 1);

		INSERT INTO dbo.AulasPorCampus(ID_Campus, ID_Aula, Estatus) VALUES
		(@ID_Campus, @ID_Aula, @Estatus);
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO

/*
--------------------------------
(8) SP_InsertarMateriaPorCarrera
--------------------------------
*/

CREATE OR ALTER PROCEDURE dbo.SP_InsertarMateriaPorCarrera
	@ID_Carrera INT,
	@ID_Materia INT,
	@Estatus BIT = NULL
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Modulo NVARCHAR(50) = 'MateriasPorCarrera';
	DECLARE @CamposObligatorios NVARCHAR(255) = '<ID_Carrera>, <ID_Materia>';
	DECLARE @CampoInvalido NVARCHAR(255);

	BEGIN TRY
		IF @ID_Carrera IS NULL OR @ID_Materia IS NULL
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50100, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF NOT EXISTS (SELECT 1 FROM dbo.Carreras WHERE ID_Carrera = @ID_Carrera)
		BEGIN
			SET @CampoInvalido = '<ID_Carrera>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END
		ELSE IF NOT EXISTS (SELECT 1 FROM dbo.Materias WHERE ID_Materia = @ID_Materia)
		BEGIN
			SET @CampoInvalido = '<ID_Materia>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END

		IF EXISTS (SELECT 1 FROM dbo.MateriasPorCarrera WHERE ID_Carrera = @ID_Carrera AND ID_Materia = @ID_Materia)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50200, @Modulo = @Modulo;
		END

		SET @Estatus = ISNULL(@Estatus, 1);

		INSERT INTO dbo.MateriasPorCarrera(ID_Carrera, ID_Materia, Estatus) VALUES
		(@ID_Carrera, @ID_Materia, @Estatus);
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO

/*
--------------------
(9) SP_InsertarGrupo
--------------------
*/

CREATE OR ALTER PROCEDURE dbo.SP_InsertarGrupo
	@ID_Carrera INT,
	@Clave CHAR(20),
	@Nombre VARCHAR(50),
	@Semestre_actual TINYINT,
	@Estatus BIT = NULL,
	@ID_Grupo INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Modulo NVARCHAR(50) = 'Grupos';
	DECLARE @CamposObligatorios NVARCHAR(255) = '<ID_Carrera>, <Clave>, <Nombre>, <Semestre_actual>';
	DECLARE @CampoInvalido NVARCHAR(255);

	BEGIN TRY
		IF @ID_Carrera IS NULL OR @Clave IS NULL OR TRIM(@Clave) = ''
		   OR @Nombre IS NULL OR TRIM(@Nombre) = '' OR @Semestre_actual IS NULL
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50100, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF @Semestre_actual <= 0
		BEGIN
			SET @CampoInvalido = CONCAT('<Semestre_actual> El semestre actual debe ser mayor o igual a 1 (', @Semestre_actual, ')');
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50600, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END

		IF NOT EXISTS (SELECT 1 FROM dbo.Carreras WHERE ID_Carrera = @ID_Carrera)
		BEGIN
			SET @CampoInvalido = '<ID_Carrera>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END

		IF EXISTS (SELECT 1 FROM dbo.Grupos WHERE Clave = @Clave)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50200, @Modulo = @Modulo;
		END

		SET @Estatus = ISNULL(@Estatus, 1);

		INSERT INTO dbo.Grupos(ID_Carrera, Clave, Nombre, Semestre_actual, Estatus) VALUES
		(@ID_Carrera, @Clave, @Nombre, @Semestre_actual, @Estatus);

		SET @ID_Grupo = SCOPE_IDENTITY();
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO

/*
----------------------
(10) SP_InsertarAlumno
----------------------
*/

CREATE OR ALTER PROCEDURE dbo.SP_InsertarAlumno
	@Nombres NVARCHAR(100),
	@Apellido_paterno NVARCHAR(100),
	@Apellido_materno NVARCHAR(100) = NULL,
	@Fecha_nacimiento DATE,
	@Pais_origen NVARCHAR(100),
	@Correo_personal NVARCHAR(255),
	@ID_Sexo INT,
	@CURP CHAR(18),
	@NSS CHAR(15),
	@Telefono VARCHAR(15),
	@Pais NVARCHAR(100),
	@Estado NVARCHAR(100),
	@Municipio NVARCHAR(100),
	@Localidad_comunidad NVARCHAR(100),
	@Calle NVARCHAR(100),
	@No_exterior VARCHAR(10),
	@No_interior VARCHAR(10),
	@Colonia NVARCHAR(100),
	@Tipo_asentamiento NVARCHAR(50),
	@Tipo_vialidad NVARCHAR(50),
	@Codigo_postal CHAR(5),
	@ID_Alumno INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Modulo NVARCHAR(50) = 'Alumnos';
	DECLARE @CamposObligatorios NVARCHAR(255) = '<Nombres>, <Apellido_paterno>, <Fecha_nacimiento>, <Pais_origen>, <Correo_personal>, <ID_Sexo>, <CURP>, <NSS>, <Telefono>';
	DECLARE @CampoInvalido NVARCHAR(255);

	BEGIN TRY
		IF @Nombres IS NULL OR TRIM(@Nombres) = '' OR @Apellido_paterno IS NULL OR TRIM(@Apellido_paterno) = ''
		   OR @Fecha_nacimiento IS NULL OR @Pais_origen IS NULL OR TRIM(@Pais_origen) = ''
		   OR @Correo_personal IS NULL OR TRIM(@Correo_personal) = '' OR @ID_Sexo IS NULL
		   OR @CURP IS NULL OR TRIM(@CURP) = '' OR @NSS IS NULL OR TRIM(@NSS) = ''
		   OR @Telefono IS NULL OR TRIM(@Telefono) = ''
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50100, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF EXISTS (SELECT 1 FROM dbo.AlumnosPrivado WHERE CURP = @CURP)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50200, @Modulo = @Modulo;
		END

		DECLARE @ID_Direccion INT;

		EXEC dbo.SP_InsertarDireccion
			@Pais, @Estado, @Municipio, @Localidad_comunidad,
			@Calle, @No_exterior, @No_interior, @Colonia,
			@Tipo_asentamiento, @Tipo_vialidad, @Codigo_postal,
			@ID_Direccion OUTPUT;

		SET @Apellido_materno = ISNULL(@Apellido_materno, '');

		INSERT INTO dbo.Alumnos(Nombres, Apellido_paterno, Apellido_materno, Fecha_nacimiento, Pais_origen, Correo_personal, ID_Sexo)
		VALUES (@Nombres, @Apellido_paterno, @Apellido_materno, @Fecha_nacimiento, @Pais_origen, @Correo_personal, @ID_Sexo);
	
		SET @ID_Alumno = SCOPE_IDENTITY();

		INSERT INTO dbo.AlumnosPrivado(ID_Alumno, CURP, NSS, Telefono, ID_Direccion) VALUES
		(@ID_Alumno, @CURP, @NSS, @Telefono, @ID_Direccion);
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO

/*
-----------------------------------
(11) SP_InsertarExpedienteAcademico
-----------------------------------
*/

CREATE OR ALTER PROCEDURE dbo.SP_InsertarExpedienteAcademico
	@Matricula CHAR(15),
	@ID_Alumno INT,
	@ID_Grupo INT,
	@Periodo VARCHAR(20),
	@Fecha_ingreso DATE = NULL,
	@Fecha_egreso DATE = NULL,
	@Fecha_baja_academica DATE = NULL,
	@Promedio_general DECIMAL(4, 2) = NULL,
	@Correo_institucional NVARCHAR(255),
	@Baja_temporal BIT = NULL,
	@ID_EstatusAlumno INT = NULL,
	@ID_Campus INT,
	@ID_Expediente INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Modulo NVARCHAR(50) = 'ExpedientesAcademicos';
	DECLARE @CamposObligatorios NVARCHAR(255) = '<Matricula>, <ID_Alumno>, <ID_Grupo>, <Periodo>, <Correo_institucional>, <ID_Campus>';
	DECLARE @CampoInvalido NVARCHAR(255);

	BEGIN TRY
		IF @Matricula IS NULL OR TRIM(@Matricula) = '' OR @ID_Alumno IS NULL OR @ID_Grupo IS NULL
		   OR @Periodo IS NULL OR TRIM(@Periodo) = '' OR @Correo_institucional IS NULL OR TRIM(@Correo_institucional) = ''
		   OR @ID_Campus IS NULL
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50100, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		SET @Fecha_ingreso = ISNULL(@Fecha_ingreso, GETDATE());

		IF @Fecha_egreso IS NOT NULL AND @Fecha_baja_academica IS NOT NULL
		BEGIN
			SET @CampoInvalido ='<Fecha_baja_academica> Un alumno no puede egresar y ser dado de baja a la vez';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50600, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END
		ELSE IF @Fecha_egreso IS NOT NULL AND @Fecha_egreso < @Fecha_ingreso
		BEGIN
			SET @CampoInvalido = CONCAT('<Fecha_egreso> La fecha de egreso debe ser mayor o igual que la fecha de ingreso (', @Fecha_egreso, ')');
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50600, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END
		ELSE IF @Fecha_baja_academica IS NOT NULL AND @Fecha_baja_academica < @Fecha_ingreso
		BEGIN
			SET @CampoInvalido = CONCAT('<Fecha_baja_academica> La fecha de la baja académica debe ser mayor o igual que la fecha de ingreso (', @Fecha_baja_academica, ')');
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50600, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END

		IF @Promedio_general IS NOT NULL AND @Promedio_general < 0
		BEGIN
			SET @CampoInvalido = CONCAT('<Promedio_general> El promedio general debe ser mayor o igual a 0 (', @Promedio_general, ')');
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50600, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END

		SET @ID_EstatusAlumno = ISNULL(@ID_EstatusAlumno, 1);

		IF NOT EXISTS (SELECT 1 FROM dbo.Alumnos WHERE ID_Alumno = @ID_Alumno)
		BEGIN
			SET @CampoInvalido = '<ID_Alumno>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END
		ELSE IF NOT EXISTS (SELECT 1 FROM dbo.Grupos WHERE ID_Grupo = @ID_Grupo)
		BEGIN
			SET @CampoInvalido = '<ID_Grupo>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END
		ELSE IF NOT EXISTS (SELECT 1 FROM dbo.Campus WHERE ID_Campus = @ID_Campus)
		BEGIN
			SET @CampoInvalido = '<ID_Campus>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END
		ELSE IF NOT EXISTS (SELECT 1 FROM dbo.EstatusDeAlumnos WHERE ID_EstatusAlumno = @ID_EstatusAlumno)
		BEGIN
			SET @CampoInvalido = '<ID_EstatusAlumno>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END

		IF EXISTS (SELECT 1 FROM dbo.ExpedientesAcademicos WHERE Matricula = @Matricula)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50200, @Modulo = @Modulo;
		END

		SET @Promedio_general = ISNULL(@Promedio_general, 0.00);
		SET @Baja_temporal = ISNULL(@Baja_temporal, 1);

		INSERT INTO dbo.ExpedientesAcademicos (Matricula, ID_Alumno, ID_Grupo, Periodo, Fecha_ingreso, Fecha_egreso, Fecha_baja_academica, Promedio_general, Correo_institucional, Baja_temporal, ID_EstatusAlumno, ID_Campus)
		VALUES (@Matricula, @ID_Alumno, @ID_Grupo, @Periodo, @Fecha_ingreso, @Fecha_egreso, @Fecha_baja_academica, @Promedio_general, @Correo_institucional, @Baja_temporal, @ID_EstatusAlumno, @ID_Campus);

		SET @ID_Expediente = SCOPE_IDENTITY();
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO

/*
------------------------
(12) SP_InsertarProfesor
------------------------
*/

CREATE OR ALTER PROCEDURE dbo.SP_InsertarProfesor
	@Nombres NVARCHAR(100),
	@Apellido_paterno NVARCHAR(100),
	@Apellido_materno NVARCHAR(100) = NULL,
	@Fecha_nacimiento DATE,
	@Pais_origen NVARCHAR(100),
	@Correo_personal NVARCHAR(255),
	@ID_Sexo INT,
	@ID_Campus INT,
	@RFC CHAR(13),
	@CURP CHAR(18),
	@NSS CHAR(15),
	@Telefono VARCHAR(15),
	@Pais NVARCHAR(100),
	@Estado NVARCHAR(100),
	@Municipio NVARCHAR(100),
	@Localidad_comunidad NVARCHAR(100),
	@Calle NVARCHAR(100),
	@No_exterior VARCHAR(10),
	@No_interior VARCHAR(10),
	@Colonia NVARCHAR(100),
	@Tipo_asentamiento NVARCHAR(50),
	@Tipo_vialidad NVARCHAR(50),
	@Codigo_postal CHAR(5),
	@Matricula CHAR(15),
	@Fecha_contratacion DATE = NULL,
	@Fecha_fin_contrato DATE = NULL,
	@Correo_institucional NVARCHAR(255),
	@Salario_quincenal DECIMAL(6, 2),
	@ID_EstatusProfesor INT = NULL,
	@ID_Profesor INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Modulo NVARCHAR(50) = 'Profesores';
	DECLARE @CamposObligatorios NVARCHAR(255) = '<Nombres>, <Apellido_paterno>, <Fecha_nacimiento>, <Pais_origen>, <Correo_personal>, <ID_Sexo>, <ID_Campus>, <RFC>, <CURP>, <NSS>, <Telefono>, <Matricula>, <Correo_institucional>, <Salario_quincenal>';
	DECLARE @CampoInvalido NVARCHAR(255);

	BEGIN TRY
		IF @Nombres IS NULL OR TRIM(@Nombres) = '' OR @Apellido_paterno IS NULL OR TRIM(@Apellido_paterno) = ''
		   OR @Fecha_nacimiento IS NULL OR @Pais_origen IS NULL OR TRIM(@Pais_origen) = ''
		   OR @Correo_personal IS NULL OR TRIM(@Correo_personal) = '' OR @ID_Sexo IS NULL OR @ID_Campus IS NULL
		   OR @RFC IS NULL OR TRIM(@RFC) = '' OR @CURP IS NULL OR TRIM(@CURP) = '' 
		   OR @NSS IS NULL OR TRIM(@NSS) = '' OR @Telefono IS NULL OR TRIM(@Telefono) = ''
		   OR @Matricula IS NULL OR TRIM(@Matricula) = '' OR @Correo_institucional IS NULL OR TRIM(@Correo_institucional) = ''
		   OR @Salario_quincenal IS NULL
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50100, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		SET @Fecha_contratacion = ISNULL(@Fecha_contratacion, GETDATE());

		IF @Fecha_fin_contrato IS NOT NULL AND @Fecha_fin_contrato < @Fecha_contratacion
		BEGIN
			SET @CampoInvalido = CONCAT('<Fecha_fin_contrato> La fecha de fin del contrato debe ser mayor o igual que la fecha de contratación (', @Fecha_fin_contrato, ')');
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50600, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END

		IF @Salario_quincenal IS NOT NULL AND @Salario_quincenal < 0
		BEGIN
			SET @CampoInvalido = CONCAT('<Salario_quincenal> El salario quincenal debe ser mayor o igual a 0 (', @Salario_quincenal, ')');
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50600, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END

		SET @ID_EstatusProfesor = ISNULL(@ID_EstatusProfesor, 1);

		IF NOT EXISTS (SELECT 1 FROM dbo.EstatusDeProfesores WHERE ID_EstatusProfesor = @ID_EstatusProfesor)
		BEGIN
			SET @CampoInvalido = '<ID_EstatusProfesor>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END

		IF EXISTS (SELECT 1 FROM dbo.ProfesoresPrivado WHERE CURP = @CURP)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50200, @Modulo = @Modulo;
		END

		DECLARE @ID_Direccion INT;

		EXEC dbo.SP_InsertarDireccion
			@Pais, @Estado, @Municipio, @Localidad_comunidad,
			@Calle, @No_exterior, @No_interior, @Colonia,
			@Tipo_asentamiento, @Tipo_vialidad, @Codigo_postal,
			@ID_Direccion OUTPUT;

		SET @Apellido_materno = ISNULL(@Apellido_materno, '');
		
		INSERT INTO dbo.Profesores(Nombres, Apellido_paterno, Apellido_materno, Fecha_nacimiento, Pais_origen, Correo_personal, ID_Sexo, ID_Campus)
		VALUES (@Nombres, @Apellido_paterno, @Apellido_materno, @Fecha_nacimiento, @Pais_origen, @Correo_personal, @ID_Sexo, @ID_Campus);
	
		SET @ID_Profesor = SCOPE_IDENTITY();

		INSERT INTO dbo.ProfesoresPrivado(ID_Profesor, RFC, CURP, NSS, Telefono, ID_Direccion) VALUES
		(@ID_Profesor, @RFC, @CURP, @NSS, @Telefono, @ID_Direccion);

		INSERT INTO dbo.ExpedientesLaborales(ID_Profesor, Matricula, Fecha_contratacion, Fecha_fin_contrato, Correo_institucional, Salario_quincenal, ID_EstatusProfesor) VALUES
		(@ID_Profesor, @Matricula, @Fecha_contratacion, @Fecha_fin_contrato, @Correo_institucional, @Salario_quincenal, @ID_EstatusProfesor);
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO

/*
---------------------------------------
(13) SP_InsertarEspecialidadPorProfesor
---------------------------------------
*/

CREATE OR ALTER PROCEDURE dbo.SP_InsertarEspecialidadPorProfesor
	@ID_Profesor INT,
	@ID_Especialidad INT,
	@Estatus BIT = NULL
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Modulo NVARCHAR(50) = 'EspecialidadesPorProfesor';
	DECLARE @CamposObligatorios NVARCHAR(255) = '<ID_Profesor>, <ID_Especialidad>';
	DECLARE @CampoInvalido NVARCHAR(255);

	BEGIN TRY
		IF @ID_Profesor IS NULL OR @ID_Especialidad IS NULL
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50100, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF NOT EXISTS (SELECT 1 FROM dbo.Profesores WHERE ID_Profesor = @ID_Profesor)
		BEGIN
			SET @CampoInvalido = '<ID_Profesor>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END
		ELSE IF NOT EXISTS (SELECT 1 FROM dbo.Especialidades WHERE ID_Especialidad = @ID_Especialidad)
		BEGIN
			SET @CampoInvalido = '<ID_Especialidad>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END

		IF EXISTS (SELECT 1 FROM dbo.EspecialidadesPorProfesor WHERE ID_Profesor = @ID_Profesor AND ID_Especialidad = @ID_Especialidad)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50200, @Modulo = @Modulo;
		END

		SET @Estatus = ISNULL(@Estatus, 1);

		INSERT INTO dbo.EspecialidadesPorProfesor(ID_Profesor, ID_Especialidad, Estatus) VALUES
		(@ID_Profesor, @ID_Especialidad, @Estatus);
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO

/*
--------------------------------
(14) SP_InsertarGrupoPorProfesor
--------------------------------
*/

CREATE OR ALTER PROCEDURE dbo.SP_InsertarGrupoPorProfesor
	@ID_Profesor INT,
	@ID_Grupo INT,
	@ID_Materia INT,
	@Hora_inicio TIME(0),
	@Hora_fin TIME(0),
	@ID_Aula INT,
	@Estatus BIT = NULL,
	@ID_GrupoProfesor INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Modulo NVARCHAR(50) = 'GruposPorProfesor';
	DECLARE @CamposObligatorios NVARCHAR(255) = '<ID_Profesor>, <ID_Grupo>, <ID_Materia>, <Hora_inicio>, <Hora_fin>, <ID_Aula>';
	DECLARE @CampoInvalido NVARCHAR(255);

	BEGIN TRY
		IF @ID_Profesor IS NULL OR @ID_Grupo IS NULL OR @ID_Materia IS NULL
		   OR @Hora_inicio IS NULL OR @Hora_fin IS NULL OR @ID_Aula IS NULL
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50100, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF @Hora_fin < @Hora_inicio
		BEGIN
			SET @CampoInvalido = CONCAT('<Hora_fin> La hora de fin debe ser mayor que la hora de inicio (', @Hora_fin, ')');
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50600, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END

		IF NOT EXISTS (SELECT 1 FROM dbo.Profesores WHERE ID_Profesor = @ID_Profesor)
		BEGIN
			SET @CampoInvalido = '<ID_Profesor>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END
		ELSE IF NOT EXISTS (SELECT 1 FROM dbo.Grupos WHERE ID_Grupo = @ID_Grupo)
		BEGIN
			SET @CampoInvalido = '<ID_Grupo>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END
		ELSE IF NOT EXISTS (SELECT 1 FROM dbo.Materias WHERE ID_Materia = @ID_Materia)
		BEGIN
			SET @CampoInvalido = '<ID_Materia>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END
		ELSE IF NOT EXISTS (SELECT 1 FROM dbo.Aulas WHERE ID_Aula = @ID_Aula)
		BEGIN
			SET @CampoInvalido = '<ID_Aula>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END

		IF EXISTS (SELECT 1 FROM dbo.GruposPorProfesor WHERE ID_Profesor = @ID_Profesor AND ID_Grupo = @ID_Grupo AND ID_Materia = @ID_Materia)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50200, @Modulo = @Modulo;
		END

		SET @Estatus = ISNULL(@Estatus, 1);

		INSERT INTO dbo.GruposPorProfesor(ID_Profesor, ID_Grupo, ID_Materia, Hora_inicio, Hora_fin, ID_Aula, Estatus) VALUES
		(@ID_Profesor, @ID_Grupo, @ID_Materia, @Hora_inicio, @Hora_fin, @ID_Aula, @Estatus);

		SET @ID_GrupoProfesor = SCOPE_IDENTITY();
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO

/*
---------------------------
(15) SP_InsertarInscripcion
---------------------------
*/

CREATE OR ALTER PROCEDURE dbo.SP_InsertarInscripcion
	@ID_GrupoProfesor INT,
	@ID_Expediente INT,
	@Fecha_inscripcion DATE = NULL,
	@ID_Inscripcion INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Modulo NVARCHAR(50) = 'Inscripciones';
	DECLARE @CamposObligatorios NVARCHAR(255) = '<ID_GrupoProfesor>, <ID_Expediente>';
	DECLARE @CampoInvalido NVARCHAR(255);

	BEGIN TRY
		IF @ID_GrupoProfesor IS NULL OR @ID_Expediente IS NULL
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50100, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF NOT EXISTS (SELECT 1 FROM dbo.GruposPorProfesor WHERE ID_GrupoProfesor = @ID_GrupoProfesor)
		BEGIN
			SET @CampoInvalido = '<ID_GrupoProfesor>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END
		ELSE IF NOT EXISTS (SELECT 1 FROM dbo.ExpedientesAcademicos WHERE ID_Expediente = @ID_Expediente)
		BEGIN
			SET @CampoInvalido = '<ID_Expediente>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END

		IF EXISTS (SELECT 1 FROM dbo.Inscripciones WHERE ID_GrupoProfesor = @ID_GrupoProfesor AND ID_Expediente = @ID_Expediente)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50200, @Modulo = @Modulo;
		END

		SET @Fecha_inscripcion = ISNULL(@Fecha_inscripcion, GETDATE());

		INSERT INTO dbo.Inscripciones(ID_GrupoProfesor, ID_Expediente, Fecha_inscripcion) VALUES
		(@ID_GrupoProfesor, @ID_Expediente, @Fecha_inscripcion);

		SET @ID_Inscripcion = SCOPE_IDENTITY();
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO