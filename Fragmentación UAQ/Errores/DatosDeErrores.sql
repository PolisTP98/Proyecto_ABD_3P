/*
===================================================================================================================================
                                             INSERTAR DATOS EN EL CAT�LOGO DE ERRORES (IDEMPOTENTE)
===================================================================================================================================
*/

-- (1) Insertar datos en el cat�logo "CodigosDeErrores" solo si no existen previamente

IF NOT EXISTS (SELECT 1 FROM dbo.CodigosDeErrores WHERE CodigoDeError = 50000)
    INSERT INTO dbo.CodigosDeErrores (CodigoDeError, Mensaje)
    VALUES (50000, 'Ocurri� un error durante la ejecuci�n del procedimiento almacenado..');

IF NOT EXISTS (SELECT 1 FROM dbo.CodigosDeErrores WHERE CodigoDeError = 50100)
    INSERT INTO dbo.CodigosDeErrores (CodigoDeError, Mensaje)
    VALUES (50100, 'Los siguientes campos no aceptan valores NULL: ');

IF NOT EXISTS (SELECT 1 FROM dbo.CodigosDeErrores WHERE CodigoDeError = 50200)
    INSERT INTO dbo.CodigosDeErrores (CodigoDeError, Mensaje)
    VALUES (50200, 'Registro duplicado en la base de datos, cancelando inserci�n..');

IF NOT EXISTS (SELECT 1 FROM dbo.CodigosDeErrores WHERE CodigoDeError = 50300)
    INSERT INTO dbo.CodigosDeErrores (CodigoDeError, Mensaje)
    VALUES (50300, 'Registro duplicado en la base de datos, cancelando actualizaci�n..');

IF NOT EXISTS (SELECT 1 FROM dbo.CodigosDeErrores WHERE CodigoDeError = 50400)
    INSERT INTO dbo.CodigosDeErrores (CodigoDeError, Mensaje)
    VALUES (50400, 'No se pudo eliminar el registro, int�ntelo de nuevo m�s tarde');

IF NOT EXISTS (SELECT 1 FROM dbo.CodigosDeErrores WHERE CodigoDeError = 50500)
    INSERT INTO dbo.CodigosDeErrores (CodigoDeError, Mensaje)
    VALUES (50500, 'El ID insertado no hace referencia a ning�n registro existente: ');

IF NOT EXISTS (SELECT 1 FROM dbo.CodigosDeErrores WHERE CodigoDeError = 50600)
    INSERT INTO dbo.CodigosDeErrores (CodigoDeError, Mensaje)
    VALUES (50600, 'El valor del campo es inv�lido: ');
