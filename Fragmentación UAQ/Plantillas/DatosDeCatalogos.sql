/*
===================================================================================================================================
											    INSERTAR DATOS EN LOS CAT�LOGOS
===================================================================================================================================
*/

-- (1) Insertar datos en el cat�logo "Sexos"
INSERT INTO dbo.Sexos(Nombre) VALUES
('Hombre'),
('Mujer'),
('Intersexual'),
('Prefiero no decirlo');

-- (2) Insertar datos en el cat�logo "EstatusDeAlumnos"
INSERT INTO dbo.EstatusDeAlumnos(Nombre) VALUES
('Activo'),
('Reincidente'),
('Egresado'),
('En tr�mite de titulaci�n'),
('Titulado'),
('Baja temporal'),
('Baja acad�mica');

-- (3) Insertar datos en el cat�logo "EstatusDeProfesores"
INSERT INTO dbo.EstatusDeProfesores(Nombre) VALUES
('Activo'),
('Sustituto'),
('Periodo vacacional'),
('Sab�tico'),
('Jubilado'),
('Baja temporal'),
('Baja permanente');

-- (4) Insertar datos en el cat�logo "Modalidades"
INSERT INTO dbo.Modalidades(Nombre) VALUES
('Presencial'),
('En l�nea'),
('H�brida'),
('Modelo dual');

-- (5) Insertar datos en el cat�logo "NivelesEducativos"
INSERT INTO dbo.NivelesEducativos(Nombre) VALUES
('T�cnico'),
('Licenciatura'),
('Licenciatura en ingenier�a'),
('Maestr�a'),
('Doctorado');