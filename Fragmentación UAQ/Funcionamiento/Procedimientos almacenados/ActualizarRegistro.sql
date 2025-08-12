/*
--------------------------
(1) SP_ActualizarDireccion
--------------------------
*/

GO
CREATE OR ALTER PROCEDURE dbo.SP_ActualizarDireccion
	@ID_Direccion INT,
    @Pais NVARCHAR(100) = NULL,
    @Estado NVARCHAR(100) = NULL,
    @Municipio NVARCHAR(100) = NULL,
    @Localidad_comunidad NVARCHAR(100) = NULL,
    @Calle NVARCHAR(100) = NULL,
    @No_exterior VARCHAR(10) = NULL,
    @No_interior VARCHAR(10) = NULL,
    @Colonia NVARCHAR(100) = NULL,
    @Tipo_asentamiento NVARCHAR(50) = NULL,
    @Tipo_vialidad NVARCHAR(50) = NULL,
    @Codigo_postal CHAR(5) = NULL,
	@Cambiar_ID BIT = 0 OUTPUT,
	@ID_Nuevo INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Modulo VARCHAR(50) = 'Direcciones';
	DECLARE @CamposObligatorios VARCHAR(255) = '<ID_Direccion>';
	DECLARE @CampoInvalido VARCHAR(255);

	BEGIN TRY
		IF @ID_Direccion IS NULL
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50100, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF NOT EXISTS (SELECT 1 FROM dbo.Direcciones WHERE ID_Direccion = @ID_Direccion)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		DECLARE 
			@Pais_actual NVARCHAR(100),
			@Estado_actual NVARCHAR(100),
			@Municipio_actual NVARCHAR(100),
			@Localidad_comunidad_actual NVARCHAR(100),
			@Calle_actual NVARCHAR(100),
			@No_exterior_actual VARCHAR(10),
			@No_interior_actual VARCHAR(10),
			@Colonia_actual NVARCHAR(100),
			@Tipo_asentamiento_actual NVARCHAR(50),
			@Tipo_vialidad_actual NVARCHAR(50),
			@Codigo_postal_actual CHAR(5);

		SELECT 
			@Pais_actual = Pais,
			@Estado_actual = Estado,
			@Municipio_actual = Municipio,
			@Localidad_comunidad_actual = Localidad_comunidad,
			@Calle_actual = Calle,
			@No_exterior_actual = No_exterior,
			@No_interior_actual = No_interior,
			@Colonia_actual = Colonia,
			@Tipo_asentamiento_actual = Tipo_asentamiento,
			@Tipo_vialidad_actual = Tipo_vialidad,
			@Codigo_postal_actual = Codigo_postal
		FROM dbo.Direcciones
		WHERE ID_Direccion = @ID_Direccion;

		SET @Pais = ISNULL(NULLIF(TRIM(@Pais), ''), @Pais_actual);
		SET @Estado = ISNULL(NULLIF(TRIM(@Estado), ''), @Estado_actual);
		SET @Municipio = ISNULL(NULLIF(TRIM(@Municipio), ''), @Municipio_actual);
		SET @Localidad_comunidad = ISNULL(NULLIF(TRIM(@Localidad_comunidad), ''), @Localidad_comunidad_actual);
		SET @Calle = ISNULL(NULLIF(TRIM(@Calle), ''), @Calle_actual);
		SET @No_exterior = ISNULL(NULLIF(TRIM(@No_exterior), ''), @No_exterior_actual);
		SET @No_interior = ISNULL(NULLIF(TRIM(@No_interior), ''), @No_interior_actual);
		SET @Colonia = ISNULL(NULLIF(TRIM(@Colonia), ''), @Colonia_actual);
		SET @Tipo_asentamiento = ISNULL(NULLIF(TRIM(@Tipo_asentamiento), ''), @Tipo_asentamiento_actual);
		SET @Tipo_vialidad = ISNULL(NULLIF(TRIM(@Tipo_vialidad), ''), @Tipo_vialidad_actual);
		SET @Codigo_postal = ISNULL(NULLIF(TRIM(@Codigo_postal), ''), @Codigo_postal_actual);

		SELECT @ID_Nuevo = ID_Direccion
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

		IF @ID_Nuevo IS NULL
		BEGIN
			UPDATE dbo.Direcciones
			SET Pais = @Pais,
				Estado = @Estado,
				Municipio = @Municipio,
				Localidad_comunidad = @Localidad_comunidad,
				Calle = @Calle,
				No_exterior = @No_exterior,
				No_interior = @No_interior,
				Colonia = @Colonia,
				Tipo_asentamiento = @Tipo_asentamiento,
				Tipo_vialidad = @Tipo_vialidad,
				Codigo_postal = @Codigo_postal
			WHERE ID_Direccion = @ID_Direccion;
		END
		ELSE IF @ID_Nuevo <> @ID_Direccion
		BEGIN
		  SET @Cambiar_ID = 1;
		END
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO

/*
-----------------------
(2) SP_ActualizarCampus
-----------------------
*/

GO
CREATE OR ALTER PROCEDURE dbo.SP_ActualizarCampus
	@ID_Campus INT,
    @Nombre NVARCHAR(100) = NULL,
    @Estatus BIT = NULL,
    @Pais NVARCHAR(100) = NULL,
    @Estado NVARCHAR(100) = NULL,
    @Municipio NVARCHAR(100) = NULL,
    @Localidad_comunidad NVARCHAR(100) = NULL,
    @Calle NVARCHAR(100) = NULL,
    @No_exterior VARCHAR(10) = NULL,
    @No_interior VARCHAR(10) = NULL,
    @Colonia NVARCHAR(100) = NULL,
    @Tipo_asentamiento NVARCHAR(50) = NULL,
    @Tipo_vialidad NVARCHAR(50) = NULL,
    @Codigo_postal CHAR(5) = NULL
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Modulo VARCHAR(50) = 'Campus';
	DECLARE @CamposObligatorios VARCHAR(255) = '<ID_Campus>';

	BEGIN TRY
		IF @ID_Campus IS NULL
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50100, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF NOT EXISTS (SELECT 1 FROM dbo.Campus WHERE ID_Campus = @ID_Campus)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		DECLARE
			@ID_Direccion INT,
			@Nombre_actual NVARCHAR(100),
			@Estatus_actual BIT;

		SELECT
			@ID_Direccion = ID_Direccion,
			@Nombre_actual = Nombre,
			@Estatus_actual = Estatus
		FROM dbo.Campus
		WHERE ID_Campus = @ID_Campus;

		SET @Nombre = ISNULL(NULLIF(TRIM(@Nombre), ''), @Nombre_actual);
		SET @Estatus = ISNULL(@Estatus, @Estatus_actual);

		IF EXISTS (SELECT 1 FROM dbo.Campus WHERE (Nombre = @Nombre OR ID_Direccion = @ID_Direccion) AND ID_Campus <> @ID_Campus)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50300, @Modulo = @Modulo;
		END

		IF NOT(@Pais IS NULL OR TRIM(@Pais) = '' OR @Estado IS NULL OR TRIM(@Estado) = ''
		   OR @Municipio IS NULL OR TRIM(@Municipio) = '' OR @Calle IS NULL OR TRIM(@Calle) = ''
		   OR @Codigo_postal IS NULL OR TRIM(@Codigo_postal) = '')
		BEGIN
			DECLARE @Cambiar_ID BIT;
			DECLARE @ID_Nuevo INT;

			EXEC dbo.SP_ActualizarDireccion
				@ID_Direccion, @Pais, @Estado, @Municipio,
				@Localidad_comunidad, @Calle, @No_exterior, 
				@No_interior, @Colonia, @Tipo_asentamiento, 
				@Tipo_vialidad, @Codigo_postal, @Cambiar_ID OUTPUT,
				@ID_Nuevo OUTPUT;

			IF @Cambiar_ID = 1
			BEGIN
				SET @ID_Direccion = @ID_Nuevo;
			END
		END

		UPDATE dbo.Campus
		SET
			Nombre = @Nombre,
			ID_Direccion = @ID_Direccion,
			Estatus = @Estatus
		WHERE ID_Campus = @ID_Campus;
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO

/*
---------------------
(3) SP_ActualizarAula
---------------------
*/

GO
CREATE OR ALTER PROCEDURE dbo.SP_ActualizarAula
	@ID_Aula INT,
	@Nombre VARCHAR(50) = NULL,
	@Estatus BIT = NULL
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Modulo VARCHAR(50) = 'Aulas';
	DECLARE @CamposObligatorios VARCHAR(255) = '<ID_Aula>';
	DECLARE @CampoInvalido VARCHAR(255);

	BEGIN TRY
		IF @ID_Aula IS NULL
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50100, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF NOT EXISTS (SELECT 1 FROM dbo.Aulas WHERE ID_Aula = @ID_Aula)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		DECLARE
			@Nombre_actual NVARCHAR(100),
			@Estatus_actual BIT;

		SELECT
			@Nombre_actual = Nombre,
			@Estatus_actual = Estatus
		FROM dbo.Aulas
		WHERE ID_Aula = @ID_Aula;

		SET @Nombre = ISNULL(NULLIF(TRIM(@Nombre), ''), @Nombre_actual);
		SET @Estatus = ISNULL(@Estatus, @Estatus_actual);

		IF EXISTS (SELECT 1 FROM dbo.Aulas WHERE Nombre = @Nombre AND ID_Aula <> @ID_Aula)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50300, @Modulo = @Modulo;
		END

		UPDATE dbo.Aulas
		SET
			Nombre = @Nombre,
			Estatus = @Estatus
		WHERE ID_Aula = @ID_Aula;
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO

/*
-----------------------------
(4) SP_ActualizarEspecialidad
-----------------------------
*/

GO
CREATE OR ALTER PROCEDURE dbo.SP_ActualizarEspecialidad
	@ID_Especialidad INT,
	@ID_Campus INT = NULL,
	@Nombre NVARCHAR(100) = NULL,
	@Fecha_registro DATE = NULL,
	@ID_Modalidad INT = NULL,
	@Estatus BIT = NULL
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Modulo VARCHAR(50) = 'Especialidades';
	DECLARE @CamposObligatorios VARCHAR(255) = '<ID_Especialidad>';
	DECLARE @CampoInvalido VARCHAR(255);

	BEGIN TRY
		IF @ID_Especialidad IS NULL
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50100, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF NOT EXISTS (SELECT 1 FROM dbo.Especialidades WHERE ID_Especialidad = @ID_Especialidad)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END
		
		IF @ID_Campus IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dbo.Campus WHERE ID_Campus = @ID_Campus)
		BEGIN
			SET @CampoInvalido = '<ID_Campus>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END
		ELSE IF @ID_Modalidad IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dbo.Modalidades WHERE ID_Modalidad = @ID_Modalidad)
		BEGIN
			SET @CampoInvalido = '<ID_Modalidad>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END

		DECLARE
			@ID_Campus_actual INT,
			@Nombre_actual NVARCHAR(100),
			@Fecha_registro_actual DATE,
			@ID_Modalidad_actual INT,
			@Estatus_actual BIT;

		SELECT
			@ID_Campus_actual = ID_Campus,
			@Nombre_actual = Nombre,
			@Fecha_registro_actual = Fecha_registro,
			@ID_Modalidad_actual = ID_Modalidad,
			@Estatus_actual = Estatus
		FROM dbo.Especialidades
		WHERE ID_Especialidad = @ID_Especialidad;

		SET @ID_Campus = ISNULL(@ID_Campus, @ID_Campus_actual);
		SET @Nombre = ISNULL(NULLIF(TRIM(@Nombre), ''), @Nombre_actual);
		SET @Fecha_registro = ISNULL(@Fecha_registro, @Fecha_registro_actual);
		SET @ID_Modalidad = ISNULL(@ID_Modalidad, @ID_Modalidad_actual);
		SET @Estatus = ISNULL(@Estatus, @Estatus_actual);

		IF EXISTS (SELECT 1 FROM dbo.Especialidades WHERE (ID_Campus = @ID_Campus AND Nombre = @Nombre) AND ID_Especialidad <> @ID_Especialidad)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50300, @Modulo = @Modulo;
		END

		UPDATE dbo.Especialidades
		SET
			ID_Campus = @ID_Campus,
			Nombre = @Nombre,
			Fecha_registro = @Fecha_registro,
			ID_Modalidad = @ID_Modalidad,
			Estatus = @Estatus
		WHERE ID_Especialidad = @ID_Especialidad;
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO

/*
------------------------
(5) SP_ActualizarCarrera
------------------------
*/

GO
CREATE OR ALTER PROCEDURE dbo.SP_ActualizarCarrera
	@ID_Carrera INT,
	@ID_Campus INT = NULL,
	@Clave CHAR(20) = NULL,
	@Nombre NVARCHAR(100) = NULL,
	@Fecha_registro DATE = NULL,
	@Duracion_semestres TINYINT = NULL,
	@Year_vigencia SMALLINT = NULL,
	@ID_Nivel INT = NULL,
	@Estatus BIT = NULL
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Year_actual SMALLINT = YEAR(GETDATE());
	DECLARE @Year_maximo SMALLINT = 2100;

	DECLARE @Modulo VARCHAR(50) = 'Carreras';
	DECLARE @CamposObligatorios VARCHAR(255) = '<ID_Carrera>';
	DECLARE @CampoInvalido VARCHAR(255);

	BEGIN TRY
		IF @ID_Carrera IS NULL
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50100, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF NOT EXISTS (SELECT 1 FROM dbo.Carreras WHERE ID_Carrera = @ID_Carrera)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF @Duracion_semestres IS NOT NULL AND @Duracion_semestres <= 0
		BEGIN
			SET @CampoInvalido = CONCAT('<Duracion_semestres> La duración en semestres debe ser mayor o igual a 1 (', @Duracion_semestres, ')');
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50600, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END
		ELSE IF @Year_vigencia IS NOT NULL AND @Year_vigencia NOT BETWEEN @Year_actual AND @Year_maximo
		BEGIN
			SET @CampoInvalido = CONCAT('<Year_vigencia> El año de vigencia debe estar en el rango de ', @Year_actual, ' - ', @Year_maximo,  ' (', @Year_vigencia, ')');
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50600, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END

		IF @ID_Campus IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dbo.Campus WHERE ID_Campus = @ID_Campus)
		BEGIN
			SET @CampoInvalido = '<ID_Campus>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END
		ELSE IF @ID_Nivel IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dbo.NivelesEducativos WHERE ID_Nivel = @ID_Nivel)
		BEGIN
			SET @CampoInvalido = '<ID_Nivel>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END

		DECLARE
			@ID_Campus_actual INT,
			@Clave_actual CHAR(20),
			@Nombre_actual NVARCHAR(100),
			@Fecha_registro_actual DATE,
			@Duracion_semestres_actual TINYINT,
			@Year_vigencia_actual SMALLINT,
			@ID_Nivel_actual INT,
			@Estatus_actual BIT;

		SELECT
			@ID_Campus_actual = ID_Campus,
			@Clave_actual = Clave,
			@Nombre_actual = Nombre,
			@Fecha_registro_actual = Fecha_registro,
			@Duracion_semestres_actual = Duracion_semestres,
			@Year_vigencia_actual = Year_vigencia,
			@ID_Nivel_actual = ID_Nivel,
			@Estatus_actual = Estatus
		FROM dbo.Carreras
		WHERE ID_Carrera = @ID_Carrera;

		SET @ID_Campus = ISNULL(@ID_Campus, @ID_Campus_actual);
		SET @Clave = ISNULL(NULLIF(TRIM(@Clave), ''), @Clave_actual);
		SET @Nombre = ISNULL(NULLIF(TRIM(@Nombre), ''), @Nombre_actual);
		SET @Fecha_registro = ISNULL(@Fecha_registro, @Fecha_registro_actual);
		SET @Duracion_semestres = ISNULL(@Duracion_semestres, @Duracion_semestres_actual);
		SET @Year_vigencia = ISNULL(@Year_vigencia, @Year_vigencia_actual);
		SET @ID_Nivel = ISNULL(@ID_Nivel, @ID_Nivel_actual);
		SET @Estatus = ISNULL(@Estatus, @Estatus_actual);

		IF EXISTS (SELECT 1 FROM dbo.Carreras WHERE Clave = @Clave AND ID_Carrera <> @ID_Carrera)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50300, @Modulo = @Modulo;
		END

		UPDATE dbo.Carreras
		SET
			ID_Campus = @ID_Campus,
			Clave = @Clave,
			Nombre = @Nombre,
			Fecha_registro = @Fecha_registro,
			Duracion_semestres = @Duracion_semestres,
			Year_vigencia = @Year_vigencia,
			ID_Nivel = @ID_Nivel,
			Estatus = @Estatus
		WHERE ID_Carrera = @ID_Carrera;
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO

/*
------------------------
(6) SP_ActualizarMateria
------------------------
*/

GO
CREATE OR ALTER PROCEDURE dbo.SP_ActualizarMateria
	@ID_Materia INT,
	@Clave CHAR(20) = NULL,
	@Nombre NVARCHAR(100) = NULL,
	@Fecha_registro DATE = NULL,
	@Creditos TINYINT = NULL,
	@Estatus BIT = NULL
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Modulo VARCHAR(50) = 'Materias';
	DECLARE @CamposObligatorios VARCHAR(255) = '<ID_Materia>';
	DECLARE @CampoInvalido VARCHAR(255);

	BEGIN TRY
		IF @ID_Materia IS NULL
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50100, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF NOT EXISTS (SELECT 1 FROM dbo.Materias WHERE ID_Materia = @ID_Materia)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF @Creditos IS NOT NULL AND @Creditos NOT BETWEEN 1 AND 12
		BEGIN
			SET @CampoInvalido = CONCAT('<Creditos> Los créditos debe estar en el rango de 1 - 12 (', @Creditos, ')');
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50600, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END

		DECLARE
			@Clave_actual CHAR(20),
			@Nombre_actual NVARCHAR(100),
			@Fecha_registro_actual DATE,
			@Creditos_actual TINYINT,
			@Estatus_actual BIT;

		SELECT
			@Clave_actual = Clave,
			@Nombre_actual = Nombre,
			@Fecha_registro_actual = Fecha_registro,
			@Creditos_actual = Creditos,
			@Estatus_actual = Estatus
		FROM dbo.Materias
		WHERE ID_Materia = @ID_Materia;

		SET @Clave = ISNULL(NULLIF(TRIM(@Clave), ''), @Clave_actual);
		SET @Nombre = ISNULL(NULLIF(TRIM(@Nombre), ''), @Nombre_actual);
		SET @Fecha_registro = ISNULL(@Fecha_registro, @Fecha_registro_actual);
		SET @Creditos = ISNULL(@Creditos, @Creditos_actual);
		SET @Estatus = ISNULL(@Estatus, @Estatus_actual);

		IF EXISTS (SELECT 1 FROM dbo.Materias WHERE Clave = @Clave AND ID_Materia <> @ID_Materia) 
		BEGIN 
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50300, @Modulo = @Modulo; 
		END

		UPDATE dbo.Materias
		SET
			Clave = @Clave,
			Nombre = @Nombre,
			Fecha_registro = @Fecha_registro,
			Creditos = @Creditos,
			Estatus = @Estatus
		WHERE ID_Materia = @ID_Materia;
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO

/*
------------------------------
(7) SP_ActualizarAulaPorCampus
------------------------------
*/

GO
CREATE OR ALTER PROCEDURE dbo.SP_ActualizarAulaPorCampus
	@ID_Campus INT,
	@ID_Aula INT,
	@Estatus BIT = NULL
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Modulo VARCHAR(50) = 'AulasPorCampus';
	DECLARE @CamposObligatorios VARCHAR(255) = '<ID_Campus>, <ID_Aula>';

	BEGIN TRY
		IF @ID_Campus IS NULL OR @ID_Aula IS NULL
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50100, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF NOT EXISTS (SELECT 1 FROM dbo.Campus WHERE ID_Campus = @ID_Campus) OR NOT EXISTS (SELECT 1 FROM dbo.Aulas WHERE ID_Aula = @ID_Aula)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		SET @Estatus = ISNULL(@Estatus, (SELECT Estatus FROM dbo.AulasPorCampus WHERE ID_Campus = @ID_Campus AND ID_Aula = @ID_Aula));

		IF EXISTS (SELECT 1 FROM dbo.AulasPorCampus WHERE (ID_Campus = @ID_Campus AND ID_Aula = @ID_Aula) AND ID_Campus <> @ID_Campus AND ID_Aula <> @ID_Aula) 
		BEGIN 
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50300, @Modulo = @Modulo; 
		END

		UPDATE dbo.AulasPorCampus
		SET
			ID_Campus = @ID_Campus,
			ID_Aula = @ID_Aula,
			Estatus = @Estatus
		WHERE ID_Campus = @ID_Campus AND ID_Aula = @ID_Aula;
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO

/*
----------------------------------
(8) SP_ActualizarMateriaPorCarrera
----------------------------------
*/

GO
CREATE OR ALTER PROCEDURE dbo.SP_ActualizarMateriaPorCarrera
	@ID_Carrera INT,
	@ID_Materia INT,
	@Estatus BIT = NULL
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Modulo VARCHAR(50) = 'MateriasPorCarrera';
	DECLARE @CamposObligatorios VARCHAR(255) = '<ID_Carrera>, <ID_Materia>';

	BEGIN TRY
		IF @ID_Carrera IS NULL OR @ID_Materia IS NULL
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50100, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF NOT EXISTS (SELECT 1 FROM dbo.Carreras WHERE ID_Carrera = @ID_Carrera) OR NOT EXISTS (SELECT 1 FROM dbo.Materias WHERE ID_Materia = @ID_Materia)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		SET @Estatus = ISNULL(@Estatus, (SELECT Estatus FROM dbo.MateriasPorCarrera WHERE ID_Carrera = @ID_Carrera AND ID_Materia = @ID_Materia));

		IF EXISTS (SELECT 1 FROM dbo.MateriasPorCarrera WHERE (ID_Carrera = @ID_Carrera AND ID_Materia = @ID_Materia) AND ID_Carrera <> @ID_Carrera AND ID_Materia <> @ID_Materia) 
		BEGIN 
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50300, @Modulo = @Modulo; 
		END

		UPDATE dbo.MateriasPorCarrera
		SET
			ID_Carrera = @ID_Carrera,
			ID_Materia = @ID_Materia,
			Estatus = @Estatus
		WHERE ID_Carrera = @ID_Carrera AND ID_Materia = @ID_Materia;
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO

/*
----------------------
(9) SP_ActualizarGrupo
----------------------
*/

GO
CREATE OR ALTER PROCEDURE dbo.SP_ActualizarGrupo
	@ID_Grupo INT,
	@ID_Carrera INT = NULL,
	@Clave CHAR(20) = NULL,
	@Nombre VARCHAR(50) = NULL,
	@Semestre_actual TINYINT = NULL,
	@Estatus BIT = NULL
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Modulo VARCHAR(50) = 'Grupos';
	DECLARE @CamposObligatorios VARCHAR(255) = '<ID_Grupo>';
	DECLARE @CampoInvalido VARCHAR(255);

	BEGIN TRY
		IF @ID_Grupo IS NULL
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50100, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF NOT EXISTS (SELECT 1 FROM dbo.Grupos WHERE ID_Grupo = @ID_Grupo)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF @Semestre_actual IS NOT NULL AND @Semestre_actual <= 0
		BEGIN
			SET @CampoInvalido = CONCAT('<Semestre_actual> El semestre actual debe ser mayor o igual a 1 (', @Semestre_actual, ')');
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50600, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END

		IF @ID_Carrera IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dbo.Carreras WHERE ID_Carrera = @ID_Carrera)
		BEGIN
			SET @CampoInvalido = '<ID_Carrera>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END

		DECLARE
			@ID_Carrera_actual INT,
			@Clave_actual CHAR(20),
			@Nombre_actual VARCHAR(50),
			@Semestre_actual_actual TINYINT,
			@Estatus_actual BIT;

		SELECT
			@ID_Carrera_actual = ID_Carrera,
			@Clave_actual = Clave,
			@Nombre_actual = Nombre,
			@Semestre_actual_actual = Semestre_actual,
			@Estatus_actual = Estatus
		FROM dbo.Grupos
		WHERE ID_Grupo = @ID_Grupo;

		SET @ID_Carrera = ISNULL(@ID_Carrera, @ID_Carrera_actual);
		SET @Clave = ISNULL(NULLIF(TRIM(@Clave), ''), @Clave_actual);
		SET @Nombre = ISNULL(NULLIF(TRIM(@Nombre), ''), @Nombre_actual);
		SET @Semestre_actual = ISNULL(@Semestre_actual, @Semestre_actual_actual);
		SET @Estatus = ISNULL(@Estatus, @Estatus_actual);

		IF EXISTS (SELECT 1 FROM dbo.Grupos WHERE (Clave = @Clave AND ID_Carrera = @ID_Carrera) AND ID_Grupo <> @ID_Grupo)
		BEGIN 
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50300, @Modulo = @Modulo; 
		END

		UPDATE dbo.Grupos
		SET
			ID_Carrera = @ID_Carrera,
			Clave = @Clave,
			Nombre = @Nombre,
			Semestre_actual = @Semestre_actual,
			Estatus = @Estatus
		WHERE ID_Grupo = @ID_Grupo;
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO

/*
------------------------
(10) SP_ActualizarAlumno
------------------------
*/

GO
CREATE OR ALTER PROCEDURE dbo.SP_ActualizarAlumno
	@ID_Alumno INT,
	@Nombres NVARCHAR(100) = NULL,
	@Apellido_paterno NVARCHAR(100) = NULL,
	@Apellido_materno NVARCHAR(100) = NULL,
	@Fecha_nacimiento DATE = NULL,
	@Pais_origen NVARCHAR(100) = NULL,
	@Correo_personal NVARCHAR(255) = NULL,
	@ID_Sexo INT = NULL,
	@CURP CHAR(18) = NULL,
	@NSS CHAR(15) = NULL,
	@Telefono VARCHAR(15) = NULL,
	@Pais NVARCHAR(100) = NULL,
	@Estado NVARCHAR(100) = NULL,
	@Municipio NVARCHAR(100) = NULL,
	@Localidad_comunidad NVARCHAR(100) = NULL,
	@Calle NVARCHAR(100) = NULL,
	@No_exterior VARCHAR(10) = NULL,
	@No_interior VARCHAR(10) = NULL,
	@Colonia NVARCHAR(100) = NULL,
	@Tipo_asentamiento NVARCHAR(50) = NULL,
	@Tipo_vialidad NVARCHAR(50) = NULL,
	@Codigo_postal CHAR(5) = NULL
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Modulo VARCHAR(50) = 'Alumnos';
	DECLARE @CamposObligatorios VARCHAR(255) = '<ID_Alumno>';
	DECLARE @CampoInvalido VARCHAR(255);

	BEGIN TRY
		IF @ID_Alumno IS NULL
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50100, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF NOT EXISTS (SELECT 1 FROM dbo.Alumnos WHERE ID_Alumno = @ID_Alumno)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF @ID_Sexo IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dbo.Sexos WHERE ID_Sexo = @ID_Sexo)
		BEGIN
			SET @CampoInvalido = '<ID_Sexo>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END

		DECLARE
			@Nombres_actual NVARCHAR(100),
			@Apellido_paterno_actual NVARCHAR(100),
			@Apellido_materno_actual NVARCHAR(100),
			@Fecha_nacimiento_actual DATE,
			@Pais_origen_actual NVARCHAR(100),
			@Correo_personal_actual NVARCHAR(255),
			@ID_Sexo_actual INT;

		SELECT
			@Nombres_actual = Nombres,
			@Apellido_paterno_actual = Apellido_paterno,
			@Apellido_materno_actual = Apellido_materno,
			@Fecha_nacimiento_actual = Fecha_nacimiento,
			@Pais_origen_actual = Pais_origen,
			@Correo_personal_actual = Correo_personal,
			@ID_Sexo_actual = ID_Sexo
		FROM dbo.Alumnos
		WHERE ID_Alumno = @ID_Alumno;

		DECLARE
			@ID_Direccion INT,
			@CURP_actual CHAR(18),
			@NSS_actual CHAR(15),
			@Telefono_actual VARCHAR(15);

		SELECT
			@ID_Direccion = ID_Direccion,
			@CURP_actual = CURP,
			@NSS_actual = NSS,
			@Telefono_actual = Telefono
		FROM dbo.AlumnosPrivado
		WHERE ID_Alumno = @ID_Alumno;

		SET @Nombres = ISNULL(NULLIF(TRIM(@Nombres), ''), @Nombres_actual);
		SET @Apellido_paterno = ISNULL(NULLIF(TRIM(@Apellido_paterno), ''), @Apellido_paterno_actual);
		SET @Apellido_materno = ISNULL(NULLIF(TRIM(@Apellido_materno), ''), @Apellido_materno_actual);
		SET @Fecha_nacimiento = ISNULL(@Fecha_nacimiento, @Fecha_nacimiento_actual);
		SET @Pais_origen = ISNULL(NULLIF(TRIM(@Pais_origen), ''), @Pais_origen_actual);
		SET @Correo_personal = ISNULL(NULLIF(TRIM(@Correo_personal), ''), @Correo_personal_actual);
		SET @ID_Sexo = ISNULL(@ID_Sexo, @ID_Sexo_actual);
		SET @CURP = ISNULL(NULLIF(TRIM(@CURP), ''), @CURP_actual);
		SET @NSS = ISNULL(NULLIF(TRIM(@NSS), ''), @NSS_actual);
		SET @Telefono = ISNULL(NULLIF(TRIM(@Telefono), ''), @Telefono_actual);

		IF EXISTS (SELECT 1 FROM dbo.AlumnosPrivado WHERE CURP = @CURP AND ID_Alumno <> @ID_Alumno) 
		BEGIN 
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50300, @Modulo = @Modulo; 
		END

		IF NOT(@Pais IS NULL OR TRIM(@Pais) = '' OR @Estado IS NULL OR TRIM(@Estado) = ''
		   OR @Municipio IS NULL OR TRIM(@Municipio) = '' OR @Calle IS NULL OR TRIM(@Calle) = ''
		   OR @Codigo_postal IS NULL OR TRIM(@Codigo_postal) = '')
		BEGIN
			DECLARE @Cambiar_ID BIT;
			DECLARE @ID_Nuevo INT;

			EXEC dbo.SP_ActualizarDireccion
				@ID_Direccion, @Pais, @Estado, @Municipio,
				@Localidad_comunidad, @Calle, @No_exterior, 
				@No_interior, @Colonia, @Tipo_asentamiento, 
				@Tipo_vialidad, @Codigo_postal, @Cambiar_ID OUTPUT,
				@ID_Nuevo OUTPUT;

			IF @Cambiar_ID = 1
			BEGIN
				SET @ID_Direccion = @ID_Nuevo;
			END
		END

		UPDATE dbo.Alumnos
		SET
			Nombres = @Nombres,
			Apellido_paterno = @Apellido_paterno,
			Apellido_materno = @Apellido_materno,
			Fecha_nacimiento = @Fecha_nacimiento,
			Pais_origen = @Pais_origen,
			Correo_personal = @Correo_personal,
			ID_Sexo = @ID_Sexo
		WHERE ID_Alumno = @ID_Alumno;

		UPDATE dbo.AlumnosPrivado
		SET
			CURP = @CURP,
			NSS = @NSS,
			Telefono = @Telefono,
			ID_Direccion = @ID_Direccion
		WHERE ID_Alumno = @ID_Alumno;
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO

/*
-------------------------------------
(11) SP_ActualizarExpedienteAcademico
-------------------------------------
*/

GO
CREATE OR ALTER PROCEDURE dbo.SP_ActualizarExpedienteAcademico
	@ID_Expediente INT,
	@Matricula CHAR(15) = NULL,
	@ID_Alumno INT = NULL,
	@ID_Grupo INT = NULL,
	@Periodo VARCHAR(20) = NULL,
	@Fecha_ingreso DATE = NULL,
	@Fecha_egreso DATE = NULL,
	@Fecha_baja_academica DATE = NULL,
	@Promedio_general DECIMAL(4, 2) = NULL,
	@Correo_institucional NVARCHAR(255) = NULL,
	@Baja_temporal BIT = NULL,
	@ID_EstatusAlumno INT = NULL,
	@ID_Campus INT = NULL
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Modulo VARCHAR(50) = 'ExpedientesAcademicos';
	DECLARE @CamposObligatorios VARCHAR(255) = '<ID_Expediente>';
	DECLARE @CampoInvalido VARCHAR(255);

	BEGIN TRY
		IF @ID_Expediente IS NULL
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50100, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF NOT EXISTS (SELECT 1 FROM dbo.ExpedientesAcademicos WHERE ID_Expediente = @ID_Expediente)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

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
		ELSE IF @Promedio_general IS NOT NULL AND @Promedio_general < 0
		BEGIN
			SET @CampoInvalido = CONCAT('<Promedio_general> El promedio general debe ser mayor o igual a 0 (', @Promedio_general, ')');
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50600, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END

		IF @ID_Alumno IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dbo.Alumnos WHERE ID_Alumno = @ID_Alumno)
		BEGIN
			SET @CampoInvalido = '<ID_Alumno>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END
		ELSE IF @ID_Grupo IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dbo.Grupos WHERE ID_Grupo = @ID_Grupo)
		BEGIN
			SET @CampoInvalido = '<ID_Grupo>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END
		ELSE IF @ID_EstatusAlumno IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dbo.EstatusDeAlumnos WHERE ID_EstatusAlumno = @ID_EstatusAlumno)
		BEGIN
			SET @CampoInvalido = '<ID_EstatusAlumno>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END
		ELSE IF @ID_Campus IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dbo.Campus WHERE ID_Campus = @ID_Campus)
		BEGIN
			SET @CampoInvalido = '<ID_Campus>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END

		DECLARE
			@Matricula_actual CHAR(15),
			@ID_Alumno_actual INT,
			@ID_Grupo_actual INT,
			@Periodo_actual VARCHAR(20),
			@Fecha_ingreso_actual DATE,
			@Fecha_egreso_actual DATE,
			@Fecha_baja_academica_actual DATE,
			@Promedio_general_actual DECIMAL(4, 2),
			@Correo_institucional_actual NVARCHAR(255),
			@Baja_temporal_actual BIT,
			@ID_EstatusAlumno_actual INT,
			@ID_Campus_actual INT;

		SELECT
			@Matricula_actual = Matricula,
			@ID_Alumno_actual = ID_Alumno,
			@ID_Grupo_actual = ID_Grupo,
			@Periodo_actual = Periodo,
			@Fecha_ingreso_actual = Fecha_ingreso,
			@Fecha_egreso_actual = Fecha_egreso,
			@Fecha_baja_academica_actual = Fecha_baja_academica,
			@Promedio_general_actual = Promedio_general,
			@Correo_institucional_actual = Correo_institucional,
			@Baja_temporal_actual = Baja_temporal,
			@ID_EstatusAlumno_actual = ID_EstatusAlumno,
			@ID_Campus_actual = ID_Campus
		FROM dbo.ExpedientesAcademicos
		WHERE ID_Expediente = @ID_Expediente;

		SET @Matricula = ISNULL(NULLIF(TRIM(@Matricula), ''), @Matricula_actual);
		SET @ID_Alumno = ISNULL(@ID_Alumno, @ID_Alumno_actual);
		SET @ID_Grupo = ISNULL(@ID_Grupo,	@ID_Grupo_actual);
		SET @Periodo = ISNULL(NULLIF(TRIM(@Periodo), ''), @Periodo_actual);
		SET @Fecha_ingreso = ISNULL(@Fecha_ingreso, @Fecha_ingreso_actual);
		SET @Fecha_egreso = ISNULL(@Fecha_egreso, @Fecha_egreso_actual);
		SET @Fecha_baja_academica = ISNULL(@Fecha_baja_academica, @Fecha_baja_academica_actual);
		SET @Promedio_general = ISNULL(@Promedio_general, @Promedio_general_actual);
		SET @Correo_institucional = ISNULL(NULLIF(TRIM(@Correo_institucional), ''), @Correo_institucional_actual);
		SET @Baja_temporal = ISNULL(@Baja_temporal, @Baja_temporal_actual);
		SET @ID_EstatusAlumno = ISNULL(@ID_EstatusAlumno, @ID_EstatusAlumno_actual);
		SET @ID_Campus = ISNULL(@ID_Campus, @ID_Campus_actual);

		IF EXISTS (SELECT 1 FROM dbo.ExpedientesAcademicos WHERE Matricula = @Matricula AND ID_Expediente <> @ID_Expediente)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50300, @Modulo = @Modulo;
		END

		IF @ID_EstatusAlumno = 6
		BEGIN
			SET @Baja_temporal = 0;
		END
		ELSE IF @ID_EstatusAlumno = 7 AND @Fecha_baja_academica IS NULL
		BEGIN
			SET @Fecha_baja_academica = GETDATE()
		END

		UPDATE dbo.ExpedientesAcademicos
		SET
			Matricula = @Matricula,
			ID_Alumno = @ID_Alumno,
			ID_Grupo = @ID_Grupo,
			Periodo = @Periodo,
			Fecha_ingreso = @Fecha_ingreso,
			Fecha_egreso = @Fecha_egreso,
			Fecha_baja_academica = @Fecha_baja_academica,
			Promedio_general = @Promedio_general,
			Correo_institucional = @Correo_institucional,
			Baja_temporal = @Baja_temporal,
			ID_EstatusAlumno = @ID_EstatusAlumno,
			ID_Campus = @ID_Campus
		WHERE ID_Expediente = @ID_Expediente;
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO

/*
--------------------------
(12) SP_ActualizarProfesor
--------------------------
*/

GO
CREATE OR ALTER PROCEDURE dbo.SP_ActualizarProfesor
	@ID_Profesor INT,
	@Nombres NVARCHAR(100) = NULL,
	@Apellido_paterno NVARCHAR(100) = NULL,
	@Apellido_materno NVARCHAR(100) = NULL,
	@Fecha_nacimiento DATE = NULL,
	@Pais_origen NVARCHAR(100) = NULL,
	@Correo_personal NVARCHAR(255) = NULL,
	@ID_Sexo INT = NULL,
	@ID_Campus INT = NULL,
	@RFC CHAR(13) = NULL,
	@CURP CHAR(18) = NULL,
	@NSS CHAR(15) = NULL,
	@Telefono VARCHAR(15) = NULL,
	@Pais NVARCHAR(100) = NULL,
	@Estado NVARCHAR(100) = NULL,
	@Municipio NVARCHAR(100) = NULL,
	@Localidad_comunidad NVARCHAR(100) = NULL,
	@Calle NVARCHAR(100) = NULL,
	@No_exterior VARCHAR(10) = NULL,
	@No_interior VARCHAR(10) = NULL,
	@Colonia NVARCHAR(100) = NULL,
	@Tipo_asentamiento NVARCHAR(50) = NULL,
	@Tipo_vialidad NVARCHAR(50) = NULL,
	@Codigo_postal CHAR(5) = NULL,
	@Matricula CHAR(15) = NULL,
	@Fecha_contratacion DATE = NULL,
	@Fecha_fin_contrato DATE = NULL,
	@Correo_institucional NVARCHAR(255) = NULL,
	@Salario_quincenal DECIMAL(6, 2) = NULL,
	@ID_EstatusProfesor INT = NULL
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Modulo VARCHAR(50) = 'Profesores';
	DECLARE @CamposObligatorios VARCHAR(255) = '<ID_Profesor>';
	DECLARE @CampoInvalido VARCHAR(255);

	BEGIN TRY
		IF @ID_Profesor IS NULL
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50100, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF NOT EXISTS (SELECT 1 FROM dbo.Profesores WHERE ID_Profesor = @ID_Profesor)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF @Fecha_fin_contrato IS NOT NULL AND @Fecha_fin_contrato < @Fecha_contratacion
		BEGIN
			SET @CampoInvalido = CONCAT('<Fecha_fin_contrato> La fecha de fin del contrato debe ser mayor o igual que la fecha de contratación (', @Fecha_fin_contrato, ')');
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50600, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END
		ELSE IF @Salario_quincenal IS NOT NULL AND @Salario_quincenal < 0
		BEGIN
			SET @CampoInvalido = CONCAT('<Salario_quincenal> El salario quincenal debe ser mayor o igual a 0 (', @Salario_quincenal, ')');
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50600, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END

		IF @ID_Sexo IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dbo.Sexos WHERE ID_Sexo = @ID_Sexo)
		BEGIN
			SET @CampoInvalido = '<ID_Sexo>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END
		ELSE IF @ID_Campus IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dbo.Campus WHERE ID_Campus = @ID_Campus)
		BEGIN
			SET @CampoInvalido = '<ID_Campus>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END
		ELSE IF @ID_EstatusProfesor IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dbo.EstatusDeProfesores WHERE ID_EstatusProfesor = @ID_EstatusProfesor)
		BEGIN
			SET @CampoInvalido = '<ID_EstatusProfesor>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END

		DECLARE
			@Nombres_actual NVARCHAR(100),
			@Apellido_paterno_actual NVARCHAR(100),
			@Apellido_materno_actual NVARCHAR(100),
			@Fecha_nacimiento_actual DATE,
			@Pais_origen_actual NVARCHAR(100),
			@Correo_personal_actual NVARCHAR(255),
			@ID_Sexo_actual INT,
			@ID_Campus_actual INT;

		SELECT
			@Nombres_actual = Nombres,
			@Apellido_paterno_actual = Apellido_paterno,
			@Apellido_materno_actual = Apellido_materno,
			@Fecha_nacimiento_actual = Fecha_nacimiento,
			@Pais_origen_actual = Pais_origen,
			@Correo_personal_actual = Correo_personal,
			@ID_Sexo_actual = ID_Sexo,
			@ID_Campus_actual = ID_Campus
		FROM dbo.Profesores
		WHERE ID_Profesor = @ID_Profesor;

		DECLARE
			@ID_Direccion INT,
			@RFC_actual CHAR(13),
			@CURP_actual CHAR(18),
			@NSS_actual CHAR(15),
			@Telefono_actual VARCHAR(15);

		SELECT
			@ID_Direccion = ID_Direccion,
			@RFC_actual = RFC,
			@CURP_actual = CURP,
			@NSS_actual = NSS,
			@Telefono_actual = Telefono
		FROM dbo.ProfesoresPrivado
		WHERE ID_Profesor = @ID_Profesor;

		DECLARE
			@Matricula_actual CHAR(15),
			@Fecha_contratacion_actual DATE,
			@Fecha_fin_contrato_actual DATE,
			@Correo_institucional_actual NVARCHAR(255),
			@Salario_quincenal_actual DECIMAL(6, 2),
			@ID_EstatusProfesor_actual INT;

		SELECT
			@Matricula_actual = Matricula,
			@Fecha_contratacion_actual = Fecha_contratacion,
			@Fecha_fin_contrato_actual = Fecha_fin_contrato,
			@Correo_institucional_actual = Correo_institucional,
			@Salario_quincenal_actual = Salario_quincenal,
			@ID_EstatusProfesor_actual = ID_EstatusProfesor
		FROM dbo.ExpedientesLaborales
		WHERE ID_Profesor = @ID_Profesor;

		SET @Nombres = ISNULL(NULLIF(TRIM(@Nombres), ''), @Nombres_actual);
		SET @Apellido_paterno = ISNULL(NULLIF(TRIM(@Apellido_paterno), ''), @Apellido_paterno_actual);
		SET @Apellido_materno = ISNULL(NULLIF(TRIM(@Apellido_materno), ''), @Apellido_materno_actual);
		SET @Fecha_nacimiento = ISNULL(@Fecha_nacimiento, @Fecha_nacimiento_actual);
		SET @Pais_origen = ISNULL(NULLIF(TRIM(@Pais_origen), ''), @Pais_origen_actual);
		SET @Correo_personal = ISNULL(NULLIF(TRIM(@Correo_personal), ''), @Correo_personal_actual);
		SET @ID_Sexo = ISNULL(@ID_Sexo, @ID_Sexo_actual);
		SET @ID_Campus = ISNULL(@ID_Campus, @ID_Campus_actual);
		SET @RFC = ISNULL(NULLIF(TRIM(@RFC), ''), @RFC_actual);
		SET @CURP = ISNULL(NULLIF(TRIM(@CURP), ''), @CURP_actual);
		SET @NSS = ISNULL(NULLIF(TRIM(@NSS), ''), @NSS_actual);
		SET @Telefono = ISNULL(NULLIF(TRIM(@Telefono), ''), @Telefono_actual);
		SET @Matricula = ISNULL(NULLIF(TRIM(@Matricula), ''), @Matricula_actual);
		SET @Fecha_contratacion = ISNULL(@Fecha_contratacion, @Fecha_contratacion_actual);
		SET @Fecha_fin_contrato = ISNULL(@Fecha_fin_contrato, @Fecha_fin_contrato_actual);
		SET @Correo_institucional = ISNULL(NULLIF(TRIM(@Correo_institucional), ''), @Correo_institucional_actual);
		SET @Salario_quincenal = ISNULL(@Salario_quincenal, @Salario_quincenal_actual);
		SET @ID_EstatusProfesor = ISNULL(@ID_EstatusProfesor, @ID_EstatusProfesor_actual);

		IF EXISTS (SELECT 1 FROM dbo.ProfesoresPrivado WHERE CURP = @CURP AND ID_Profesor <> @ID_Profesor) 
		BEGIN 
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50300, @Modulo = @Modulo; 
		END

		IF NOT(@Pais IS NULL OR TRIM(@Pais) = '' OR @Estado IS NULL OR TRIM(@Estado) = ''
		   OR @Municipio IS NULL OR TRIM(@Municipio) = '' OR @Calle IS NULL OR TRIM(@Calle) = ''
		   OR @Codigo_postal IS NULL OR TRIM(@Codigo_postal) = '')
		BEGIN
			DECLARE @Cambiar_ID BIT;
			DECLARE @ID_Nuevo INT;

			EXEC dbo.SP_ActualizarDireccion
				@ID_Direccion, @Pais, @Estado, @Municipio,
				@Localidad_comunidad, @Calle, @No_exterior, 
				@No_interior, @Colonia, @Tipo_asentamiento, 
				@Tipo_vialidad, @Codigo_postal, @Cambiar_ID OUTPUT,
				@ID_Nuevo OUTPUT;

			IF @Cambiar_ID = 1
			BEGIN
				SET @ID_Direccion = @ID_Nuevo;
			END
		END

		UPDATE dbo.Profesores
		SET
			Nombres = @Nombres,
			Apellido_paterno = @Apellido_paterno,
			Apellido_materno = @Apellido_materno,
			Fecha_nacimiento = @Fecha_nacimiento,
			Pais_origen = @Pais_origen,
			Correo_personal = @Correo_personal,
			ID_Sexo = @ID_Sexo,
			ID_Campus = @ID_Campus
		WHERE ID_Profesor = @ID_Profesor;

		UPDATE dbo.ProfesoresPrivado
		SET
			RFC = @RFC,
			CURP = @CURP,
			NSS = @NSS,
			Telefono = @Telefono,
			ID_Direccion = @ID_Direccion
		WHERE ID_Profesor = @ID_Profesor;

		UPDATE dbo.ExpedientesLaborales
		SET
			Matricula = @Matricula,
			Fecha_contratacion = @Fecha_contratacion,
			Fecha_fin_contrato = @Fecha_fin_contrato,
			Correo_institucional = @Correo_institucional,
			Salario_quincenal = @Salario_quincenal,
			ID_EstatusProfesor = @ID_EstatusProfesor
		WHERE ID_Profesor = @ID_Profesor;
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO

/*
-----------------------------------------
(13) SP_ActualizarEspecialidadPorProfesor
-----------------------------------------
*/

GO
CREATE OR ALTER PROCEDURE dbo.SP_ActualizarEspecialidadPorProfesor
	@ID_Profesor INT,
	@ID_Especialidad INT,
	@Estatus BIT = NULL
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Modulo VARCHAR(50) = 'EspecialidadesPorProfesor';
	DECLARE @CamposObligatorios VARCHAR(255) = '<ID_Profesor>, <ID_Especialidad>';

	BEGIN TRY
		IF @ID_Profesor IS NULL OR @ID_Especialidad IS NULL
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50100, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF NOT EXISTS (SELECT 1 FROM dbo.Profesores WHERE ID_Profesor = @ID_Profesor) OR NOT EXISTS (SELECT 1 FROM dbo.Especialidades WHERE ID_Especialidad = @ID_Especialidad)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF EXISTS (SELECT 1 FROM dbo.EspecialidadesPorProfesor WHERE (ID_Profesor = @ID_Profesor AND ID_Especialidad = @ID_Especialidad) AND ID_Profesor <> @ID_Profesor AND ID_Especialidad <> @ID_Especialidad) 
		BEGIN 
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50300, @Modulo = @Modulo; 
		END

		SET @Estatus = ISNULL(@Estatus, (SELECT Estatus FROM dbo.EspecialidadesPorProfesor WHERE ID_Profesor = @ID_Profesor AND ID_Especialidad = @ID_Especialidad));

		UPDATE dbo.EspecialidadesPorProfesor
		SET
			ID_Profesor = @ID_Profesor,
			ID_Especialidad = @ID_Especialidad,
			Estatus = @Estatus
		WHERE ID_Profesor = @ID_Profesor AND ID_Especialidad = @ID_Especialidad;
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO

/*
----------------------------------
(14) SP_ActualizarGrupoPorProfesor
----------------------------------
*/

GO
CREATE OR ALTER PROCEDURE dbo.SP_ActualizarGrupoPorProfesor
	@ID_GrupoProfesor INT,
	@ID_Profesor INT = NULL,
	@ID_Grupo INT = NULL,
	@ID_Materia INT = NULL,
	@Hora_inicio TIME(0) = NULL,
	@Hora_fin TIME(0) = NULL,
	@ID_Aula INT = NULL,
	@Estatus BIT = NULL
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Modulo VARCHAR(50) = 'GruposPorProfesor';
	DECLARE @CamposObligatorios VARCHAR(255) = '<ID_GrupoProfesor>';
	DECLARE @CampoInvalido VARCHAR(255);

	BEGIN TRY
		IF @ID_GrupoProfesor IS NULL
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50100, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF NOT EXISTS (SELECT 1 FROM dbo.GruposPorProfesor WHERE ID_GrupoProfesor = @ID_GrupoProfesor)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF @Hora_fin IS NOT NULL AND @Hora_inicio IS NOT NULL AND @Hora_fin < @Hora_inicio
		BEGIN
			SET @CampoInvalido = CONCAT('<Hora_fin> La hora de fin debe ser mayor que la hora de inicio (', @Hora_fin, ')');
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50600, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END

		IF @ID_Profesor IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dbo.Profesores WHERE ID_Profesor = @ID_Profesor)
		BEGIN
			SET @CampoInvalido = '<ID_Profesor>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END
		ELSE IF @ID_Grupo IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dbo.Grupos WHERE ID_Grupo = @ID_Grupo)
		BEGIN
			SET @CampoInvalido = '<ID_Grupo>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END
		ELSE IF @ID_Materia IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dbo.Materias WHERE ID_Materia = @ID_Materia)
		BEGIN
			SET @CampoInvalido = '<ID_Materia>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END
		ELSE IF @ID_Aula IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dbo.Aulas WHERE ID_Aula = @ID_Aula)
		BEGIN
			SET @CampoInvalido = '<ID_Aula>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END

		DECLARE
			@ID_Profesor_actual INT,
			@ID_Grupo_actual INT,
			@ID_Materia_actual INT,
			@Hora_inicio_actual TIME(0),
			@Hora_fin_actual TIME(0),
			@ID_Aula_actual INT,
			@Estatus_actual BIT;

		SELECT
			@ID_Profesor_actual = ID_Profesor,
			@ID_Grupo_actual = ID_Grupo,
			@ID_Materia_actual = ID_Materia,
			@Hora_inicio_actual = Hora_inicio,
			@Hora_fin_actual = Hora_fin,
			@ID_Aula_actual = ID_Aula,
			@Estatus_actual = Estatus
		FROM dbo.GruposPorProfesor
		WHERE ID_GrupoProfesor = @ID_GrupoProfesor;

		SET @ID_Profesor = ISNULL(@ID_Profesor, @ID_Profesor_actual);
		SET @ID_Grupo = ISNULL(@ID_Grupo, @ID_Grupo_actual);
		SET @ID_Materia = ISNULL(@ID_Materia, @ID_Materia_actual);
		SET @Hora_inicio = ISNULL(@Hora_inicio, @Hora_inicio_actual);
		SET @Hora_fin = ISNULL(@Hora_fin, @Hora_fin_actual);
		SET @ID_Aula = ISNULL(@ID_Aula, @ID_Aula_actual);
		SET @Estatus = ISNULL(@Estatus, @Estatus_actual);

		IF EXISTS (SELECT 1 FROM dbo.GruposPorProfesor WHERE (ID_Profesor = @ID_Profesor AND ID_Grupo = @ID_Grupo AND ID_Materia = @ID_Materia) AND ID_GrupoProfesor <> @ID_GrupoProfesor)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50300, @Modulo = @Modulo;
		END

		UPDATE dbo.GruposPorProfesor
		SET
			ID_Profesor = @ID_Profesor,
			ID_Grupo = @ID_Grupo,
			ID_Materia = @ID_Materia,
			Hora_inicio = @Hora_inicio,
			Hora_fin = @Hora_fin,
			ID_Aula = @ID_Aula,
			Estatus = @Estatus
		WHERE ID_GrupoProfesor = @ID_GrupoProfesor;
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO

/*
-----------------------------
(15) SP_ActualizarInscripcion
-----------------------------
*/

GO
CREATE OR ALTER PROCEDURE dbo.SP_ActualizarInscripcion
	@ID_Inscripcion INT,
	@ID_GrupoProfesor INT = NULL,
	@ID_Expediente INT = NULL,
	@Fecha_inscripcion DATE = NULL
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Modulo VARCHAR(50) = 'Inscripciones';
	DECLARE @CamposObligatorios VARCHAR(255) = '<ID_Inscripcion>';
	DECLARE @CampoInvalido VARCHAR(255);

	BEGIN TRY
		IF @ID_Inscripcion IS NULL
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50100, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF NOT EXISTS (SELECT 1 FROM dbo.Inscripciones WHERE ID_Inscripcion = @ID_Inscripcion)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF @ID_GrupoProfesor IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dbo.GruposPorProfesor WHERE ID_GrupoProfesor = @ID_GrupoProfesor)
		BEGIN
			SET @CampoInvalido = '<ID_GrupoProfesor>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END
		ELSE IF @ID_Expediente IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dbo.ExpedientesAcademicos WHERE ID_Expediente = @ID_Expediente)
		BEGIN
			SET @CampoInvalido = '<ID_Expediente>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END

		DECLARE
			@ID_GrupoProfesor_actual INT,
			@ID_Expediente_actual INT,
			@Fecha_inscripcion_actual DATE;

		SELECT
			@ID_GrupoProfesor_actual = ID_GrupoProfesor,
			@ID_Expediente_actual = ID_Expediente,
			@Fecha_inscripcion_actual = Fecha_inscripcion
		FROM dbo.Inscripciones
		WHERE ID_Inscripcion = @ID_Inscripcion;

		SET @ID_GrupoProfesor = ISNULL(@ID_GrupoProfesor, @ID_GrupoProfesor_actual);
		SET @ID_Expediente = ISNULL(@ID_Expediente, @ID_Expediente_actual);
		SET @Fecha_inscripcion = ISNULL(@Fecha_inscripcion, @Fecha_inscripcion_actual);

		IF EXISTS (SELECT 1 FROM dbo.Inscripciones WHERE (ID_GrupoProfesor = @ID_GrupoProfesor AND ID_Expediente = @ID_Expediente) AND ID_Inscripcion <> @ID_Inscripcion)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50300, @Modulo = @Modulo;
		END

		UPDATE dbo.Inscripciones
		SET
			ID_GrupoProfesor = @ID_GrupoProfesor,
			ID_Expediente = @ID_Expediente,
			Fecha_inscripcion = @Fecha_inscripcion
		WHERE ID_Inscripcion = @ID_Inscripcion;
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO