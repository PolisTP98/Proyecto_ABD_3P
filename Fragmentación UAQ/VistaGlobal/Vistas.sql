create database VistaGlobal;
GO

Use VistaGlobal;
Go

-- Eliminar la vista si existe
IF OBJECT_ID('VistaGlobalAlumnos', 'V') IS NOT NULL
BEGIN
    DROP VIEW VistaGlobalAlumnos;
    PRINT 'Vista VistaGlobalAlumnos eliminada para recreación.';
END
GO

-- Crear la vista global
CREATE VIEW VistaGlobalAlumnos AS
SELECT * FROM CienciasDeLaComputacionUAQ.dbo.Alumnos
UNION ALL
SELECT * FROM HumanidadesUAQ.dbo.Alumnos
UNION ALL
SELECT * FROM MedicinaUAQ.dbo.Alumnos;
GO

PRINT 'Vista VistaGlobalAlumnos creada exitosamente.';
GO

Use CienciasDeLaComputacionUAQ;
go 
select * from Campus;

Use HumanidadesUAQ;
go 
select * from ExpedientesAcademicos;

Use MedicinaUAQ;
go 
select * from ExpedientesAcademicos;