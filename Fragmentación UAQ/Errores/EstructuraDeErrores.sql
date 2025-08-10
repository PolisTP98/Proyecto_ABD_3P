/*
===================================================================================================================================
											   CAT�LOGO DE ERRORES DEL SISTEMA
===================================================================================================================================
*/


-- (1) Crear tabla para documentar c�digos con mensajes de error personalizados
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'CodigosDeErrores' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
    CREATE TABLE dbo.CodigosDeErrores (
        CodigoDeError INT PRIMARY KEY,
        Mensaje VARCHAR(255) NOT NULL
    );
END