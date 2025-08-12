/*
---------------------
(1) SP_EliminarCampus
---------------------
*/

GO
CREATE OR ALTER PROCEDURE dbo.SP_EliminarCampus
	@ID_Campus INT
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

		UPDATE dbo.Campus SET Estatus = 0 WHERE ID_Campus = @ID_Campus AND Estatus <> 0;

		IF @@ROWCOUNT = 0
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50400, @Modulo = @Modulo;
		END
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO

/*
-------------------
(2) SP_EliminarAula
-------------------
*/

GO
CREATE OR ALTER PROCEDURE dbo.SP_EliminarAula
	@ID_Aula INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Modulo VARCHAR(50) = 'Aulas';
	DECLARE @CamposObligatorios VARCHAR(255) = '<ID_Aula>';

	BEGIN TRY
		IF @ID_Aula IS NULL
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50100, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF NOT EXISTS (SELECT 1 FROM dbo.Aulas WHERE ID_Aula = @ID_Aula)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		UPDATE dbo.Aulas SET Estatus = 0 WHERE ID_Aula = @ID_Aula AND Estatus <> 0;

		IF @@ROWCOUNT = 0
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50400, @Modulo = @Modulo;
		END
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO

/*
---------------------------
(3) SP_EliminarEspecialidad
---------------------------
*/

GO
CREATE OR ALTER PROCEDURE dbo.SP_EliminarEspecialidad
	@ID_Especialidad INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Modulo VARCHAR(50) = 'Especialidades';
	DECLARE @CamposObligatorios VARCHAR(255) = '<ID_Especialidad>';

	BEGIN TRY
		IF @ID_Especialidad  IS NULL
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50100, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF NOT EXISTS (SELECT 1 FROM dbo.Especialidades WHERE ID_Especialidad = @ID_Especialidad)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		UPDATE dbo.Especialidades SET Estatus = 0 WHERE ID_Especialidad = @ID_Especialidad AND Estatus <> 0;

		IF @@ROWCOUNT = 0
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50400, @Modulo = @Modulo;
		END
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO

/*
----------------------
(4) SP_EliminarCarrera
----------------------
*/

GO
CREATE OR ALTER PROCEDURE dbo.SP_EliminarCarrera
	@ID_Carrera INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Modulo VARCHAR(50) = 'Carreras';
	DECLARE @CamposObligatorios VARCHAR(255) = '<ID_Carrera>';

	BEGIN TRY
		IF @ID_Carrera  IS NULL
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50100, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF NOT EXISTS (SELECT 1 FROM dbo.Carreras WHERE ID_Carrera = @ID_Carrera)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		UPDATE dbo.Carreras SET Estatus = 0 WHERE ID_Carrera = @ID_Carrera AND Estatus <> 0;

		IF @@ROWCOUNT = 0
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50400, @Modulo = @Modulo;
		END
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO

/*
----------------------
(5) SP_EliminarMateria
----------------------
*/

GO
CREATE OR ALTER PROCEDURE dbo.SP_EliminarMateria
	@ID_Materia INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Modulo VARCHAR(50) = 'Materias';
	DECLARE @CamposObligatorios VARCHAR(255) = '<ID_Materia>';

	BEGIN TRY
		IF @ID_Materia  IS NULL
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50100, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF NOT EXISTS (SELECT 1 FROM dbo.Materias WHERE ID_Materia = @ID_Materia)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		UPDATE dbo.Materias SET Estatus = 0 WHERE ID_Materia = @ID_Materia AND Estatus <> 0;

		IF @@ROWCOUNT = 0
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50400, @Modulo = @Modulo;
		END
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO

/*
----------------------------
(6) SP_EliminarAulaPorCampus
----------------------------
*/

GO
CREATE OR ALTER PROCEDURE dbo.SP_EliminarAulaPorCampus
	@ID_Campus INT,
	@ID_Aula INT
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
		ELSE IF NOT EXISTS (SELECT 1 FROM dbo.AulasPorCampus WHERE ID_Campus = @ID_Campus AND ID_Aula = @ID_Aula)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		UPDATE dbo.AulasPorCampus SET Estatus = 0 WHERE ID_Campus = @ID_Campus AND ID_Aula = @ID_Aula AND Estatus <> 0;

		IF @@ROWCOUNT = 0
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50400, @Modulo = @Modulo;
		END
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO

/*
--------------------------------
(7) SP_EliminarMateriaPorCarrera
--------------------------------
*/

GO
CREATE OR ALTER PROCEDURE dbo.SP_EliminarMateriaPorCarrera
	@ID_Carrera INT,
	@ID_Materia INT
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
		ELSE IF NOT EXISTS (SELECT 1 FROM dbo.MateriasPorCarrera WHERE ID_Carrera = @ID_Carrera AND ID_Materia = @ID_Materia)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		UPDATE dbo.MateriasPorCarrera SET Estatus = 0 WHERE ID_Carrera = @ID_Carrera AND ID_Materia = @ID_Materia AND Estatus <> 0;

		IF @@ROWCOUNT = 0
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50400, @Modulo = @Modulo;
		END
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO

/*
--------------------
(8) SP_EliminarGrupo
--------------------
*/

GO
CREATE OR ALTER PROCEDURE dbo.SP_EliminarGrupo
	@ID_Grupo INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Modulo VARCHAR(50) = 'Grupos';
	DECLARE @CamposObligatorios VARCHAR(255) = '<ID_Grupo>';

	BEGIN TRY
		IF @ID_Grupo  IS NULL
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50100, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF NOT EXISTS (SELECT 1 FROM dbo.Grupos WHERE ID_Grupo = @ID_Grupo)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		UPDATE dbo.Grupos SET Estatus = 0 WHERE ID_Grupo = @ID_Grupo AND Estatus <> 0;

		IF @@ROWCOUNT = 0
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50400, @Modulo = @Modulo;
		END
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO

/*
----------------------------------
(9) SP_EliminarExpedienteAcademico
----------------------------------
*/

GO
CREATE OR ALTER PROCEDURE dbo.SP_EliminarExpedienteAcademico
	@ID_Expediente INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Modulo VARCHAR(50) = 'ExpedientesAcademicos';
	DECLARE @CamposObligatorios VARCHAR(255) = '<ID_Expediente>';

	BEGIN TRY
		IF @ID_Expediente IS NULL
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50100, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF NOT EXISTS (SELECT 1 FROM dbo.ExpedientesAcademicos WHERE ID_Expediente = @ID_Expediente)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		UPDATE dbo.ExpedientesAcademicos
		SET
			ID_EstatusAlumno = 7,
			Fecha_baja_academica = GETDATE()
		WHERE ID_Expediente = @ID_Expediente AND ID_EstatusAlumno <> 7;

		IF @@ROWCOUNT = 0
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50400, @Modulo = @Modulo;
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
(10) SP_EliminarProfesor
-----------------------
*/

GO
CREATE OR ALTER PROCEDURE dbo.SP_EliminarProfesor
	@ID_Profesor INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Modulo VARCHAR(50) = 'Profesores';
	DECLARE @CamposObligatorios VARCHAR(255) = '<ID_Profesor>';

	BEGIN TRY
		IF @ID_Profesor IS NULL
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50100, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF NOT EXISTS (SELECT 1 FROM dbo.ExpedientesLaborales WHERE ID_Profesor = @ID_Profesor)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		UPDATE dbo.ExpedientesLaborales
		SET
			ID_EstatusProfesor = 7,
			Fecha_fin_contrato = GETDATE()
		WHERE ID_Profesor = @ID_Profesor AND ID_EstatusProfesor <> 7;

		IF @@ROWCOUNT = 0
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50400, @Modulo = @Modulo;
		END
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO

/*
---------------------------------------
(11) SP_EliminarEspecialidadPorProfesor
---------------------------------------
*/

GO
CREATE OR ALTER PROCEDURE dbo.SP_EliminarEspecialidadPorProfesor
	@ID_Profesor INT,
	@ID_Especialidad INT
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
		ELSE IF NOT EXISTS (SELECT 1 FROM dbo.EspecialidadesPorProfesor WHERE ID_Profesor = @ID_Profesor AND ID_Especialidad = @ID_Especialidad)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		UPDATE dbo.EspecialidadesPorProfesor SET Estatus = 0 WHERE ID_Profesor = @ID_Profesor AND ID_Especialidad = @ID_Especialidad AND Estatus <> 0;

		IF @@ROWCOUNT = 0
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50400, @Modulo = @Modulo;
		END
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO

/*
--------------------------------
(12) SP_EliminarGrupoPorProfesor
--------------------------------
*/

GO
CREATE OR ALTER PROCEDURE dbo.SP_EliminarGrupoPorProfesor
	@ID_GrupoProfesor INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Modulo VARCHAR(50) = 'GruposPorProfesor';
	DECLARE @CamposObligatorios VARCHAR(255) = '<ID_GrupoProfesor>';

	BEGIN TRY
		IF @ID_GrupoProfesor IS NULL
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50100, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		IF NOT EXISTS (SELECT 1 FROM dbo.GruposPorProfesor WHERE ID_GrupoProfesor = @ID_GrupoProfesor)
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50500, @Modulo = @Modulo, @Detalles = @CamposObligatorios;
		END

		UPDATE dbo.GruposPorProfesor SET Estatus = 0 WHERE ID_GrupoProfesor = @ID_GrupoProfesor AND Estatus <> 0;

		IF @@ROWCOUNT = 0
		BEGIN
			EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50400, @Modulo = @Modulo;
		END
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		EXEC dbo.SP_ErrorPorCodigo @CodigoDeError = 50000, @Modulo = @Modulo;
	END CATCH
END
GO