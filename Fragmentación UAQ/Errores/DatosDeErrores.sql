/*
===================================================================================================================================
                                             INSERTAR DATOS EN EL CATÁLOGO DE ERRORES (IDEMPOTENTE)
===================================================================================================================================
*/

-- (1) Insertar datos en el catálogo "CodigosDeErrores" solo si no existen previamente

IF NOT EXISTS (SELECT 1 FROM dbo.CodigosDeErrores WHERE CodigoDeError = 50000)
    INSERT INTO dbo.CodigosDeErrores (CodigoDeError, Mensaje)
    VALUES (50000, 'Ocurrió un error durante la ejecución del procedimiento almacenado..');

IF NOT EXISTS (SELECT 1 FROM dbo.CodigosDeErrores WHERE CodigoDeError = 50100)
    INSERT INTO dbo.CodigosDeErrores (CodigoDeError, Mensaje)
    VALUES (50100, 'Los siguientes campos no aceptan valores NULL: ');

IF NOT EXISTS (SELECT 1 FROM dbo.CodigosDeErrores WHERE CodigoDeError = 50200)
    INSERT INTO dbo.CodigosDeErrores (CodigoDeError, Mensaje)
    VALUES (50200, 'Registro duplicado en la base de datos, cancelando inserción..');

IF NOT EXISTS (SELECT 1 FROM dbo.CodigosDeErrores WHERE CodigoDeError = 50300)
    INSERT INTO dbo.CodigosDeErrores (CodigoDeError, Mensaje)
    VALUES (50300, 'Registro duplicado en la base de datos, cancelando actualización..');

IF NOT EXISTS (SELECT 1 FROM dbo.CodigosDeErrores WHERE CodigoDeError = 50400)
    INSERT INTO dbo.CodigosDeErrores (CodigoDeError, Mensaje)
    VALUES (50400, 'No se pudo eliminar el registro, inténtelo de nuevo más tarde');

IF NOT EXISTS (SELECT 1 FROM dbo.CodigosDeErrores WHERE CodigoDeError = 50500)
    INSERT INTO dbo.CodigosDeErrores (CodigoDeError, Mensaje)
    VALUES (50500, 'El ID insertado no hace referencia a ningún registro existente: ');

IF NOT EXISTS (SELECT 1 FROM dbo.CodigosDeErrores WHERE CodigoDeError = 50600)
    INSERT INTO dbo.CodigosDeErrores (CodigoDeError, Mensaje)
    VALUES (50600, 'El valor del campo es inválido: ');
