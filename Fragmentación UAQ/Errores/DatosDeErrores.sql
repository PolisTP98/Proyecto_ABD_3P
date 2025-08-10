/*
===================================================================================================================================
											 INSERTAR DATOS EN EL CATÁLOGO DE ERRORES
===================================================================================================================================
*/


-- (1) Insertar datos en el catálogo "CodigosDeErrores"
INSERT INTO dbo.CodigosDeErrores(CodigoDeError, Mensaje) VALUES
(50000, 'Ocurrió un error durante la ejecución del procedimiento almacenado..'),
(50100, 'Los siguientes campos no aceptan valores NULL: '),
(50200, 'Registro duplicado en la base de datos, cancelando inserción..'),
(50300, 'Registro duplicado en la base de datos, cancelando actualización..'),
(50400, 'No se pudo eliminar el registro, inténtelo de nuevo más tarde'),
(50500, 'El ID insertado no hace referencia a ningún registro existente: '),
(50600, 'El valor del campo es inválido: ');