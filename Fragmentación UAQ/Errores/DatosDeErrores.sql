/*
===================================================================================================================================
											 INSERTAR DATOS EN EL CAT�LOGO DE ERRORES
===================================================================================================================================
*/


-- (1) Insertar datos en el cat�logo "CodigosDeErrores"
INSERT INTO dbo.CodigosDeErrores(CodigoDeError, Mensaje) VALUES
(50000, 'Ocurri� un error durante la ejecuci�n del procedimiento almacenado..'),
(50100, 'Los siguientes campos no aceptan valores NULL: '),
(50200, 'Registro duplicado en la base de datos, cancelando inserci�n..'),
(50300, 'Registro duplicado en la base de datos, cancelando actualizaci�n..'),
(50400, 'No se pudo eliminar el registro, int�ntelo de nuevo m�s tarde'),
(50500, 'El ID insertado no hace referencia a ning�n registro existente: '),
(50600, 'El valor del campo es inv�lido: ');