/*
--------------------------
(1) SP_ActualizarDireccion
--------------------------
*/

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

	DECLARE @Modulo NVARCHAR(50) = 'Direcciones';
	DECLARE @CampoInvalido NVARCHAR(255);

	BEGIN TRY
		IF NOT EXISTS (SELECT 1 FROM dbo.Direcciones WHERE ID_Direccion = @ID_Direccion)
		BEGIN
			SET @CampoInvalido = '<ID_Direccion>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
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
		ELSE
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

	DECLARE @Modulo NVARCHAR(50) = 'Campus';
	DECLARE @CampoInvalido NVARCHAR(255);

	BEGIN TRY
		IF NOT EXISTS (SELECT 1 FROM dbo.Campus WHERE ID_Campus = @ID_Campus)
		BEGIN
			SET @CampoInvalido = '<ID_Campus>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
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

		DECLARE @Cambiar_ID BIT;
		DECLARE @ID_Nuevo INT;

		EXEC dbo.SP_ActualizarDireccion
			@ID_Direccion, @Pais, @Estado, @Municipio,
			@Localidad_comunidad, @Calle, @No_exterior, 
			@No_interior, @Colonia, @Tipo_asentamiento, 
			@Tipo_vialidad, @Codigo_postal, @Cambiar_ID,
			@ID_Nuevo;

		IF @Cambiar_ID = 1
		BEGIN
			SET @ID_Direccion = @ID_Nuevo;
		END

		IF EXISTS (SELECT 1 FROM dbo.Campus WHERE (Nombre = @Nombre OR ID_Direccion = @ID_Direccion) AND ID_Campus <> @ID_Campus)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50300, @Modulo = @Modulo;
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

CREATE OR ALTER PROCEDURE dbo.SP_ActualizarAula
	@ID_Aula INT,
	@Nombre VARCHAR(50) = NULL,
	@Estatus BIT = NULL
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Modulo NVARCHAR(50) = 'Aulas';
	DECLARE @CampoInvalido NVARCHAR(255);

	BEGIN TRY
		IF NOT EXISTS (SELECT 1 FROM dbo.Aulas WHERE ID_Aula = @ID_Aula)
		BEGIN
			SET @CampoInvalido = '<ID_Aula>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
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

		UPDATE dbo.Campus
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

	DECLARE @Modulo NVARCHAR(50) = 'Especialidades';
	DECLARE @CampoInvalido NVARCHAR(255);

	BEGIN TRY
		IF NOT EXISTS (SELECT 1 FROM dbo.Especialidades WHERE ID_Especialidad = @ID_Especialidad)
		BEGIN
			SET @CampoInvalido = '<ID_Especialidad>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END
		ELSE IF NOT EXISTS (SELECT 1 FROM dbo.Campus WHERE ID_Campus = @ID_Campus)
		BEGIN
			SET @CampoInvalido = '<ID_Campus>';
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CampoInvalido;
		END
		ELSE IF NOT EXISTS (SELECT 1 FROM dbo.Modalidades WHERE ID_Modalidad = @ID_Modalidad)
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

		UPDATE dbo.Campus
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