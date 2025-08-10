/*
===================================================================================================================================
											    INSERTAR DATOS EN LOS CATÁLOGOS
===================================================================================================================================
*/

-- (1) Insertar datos en el catálogo "Sexos"
INSERT INTO dbo.Sexos(Nombre) VALUES
('Hombre'),
('Mujer'),
('Intersexual'),
('Prefiero no decirlo');

-- (2) Insertar datos en el catálogo "EstatusDeAlumnos"
INSERT INTO dbo.EstatusDeAlumnos(Nombre) VALUES
('Activo'),
('Reincidente'),
('Egresado'),
('En trámite de titulación'),
('Titulado'),
('Baja temporal'),
('Baja académica');

-- (3) Insertar datos en el catálogo "EstatusDeProfesores"
INSERT INTO dbo.EstatusDeProfesores(Nombre) VALUES
('Activo'),
('Sustituto'),
('Periodo vacacional'),
('Sabático'),
('Jubilado'),
('Baja temporal'),
('Baja permanente');

-- (4) Insertar datos en el catálogo "Modalidades"
INSERT INTO dbo.Modalidades(Nombre) VALUES
('Presencial'),
('En línea'),
('Híbrida'),
('Modelo dual');

-- (5) Insertar datos en el catálogo "NivelesEducativos"
INSERT INTO dbo.NivelesEducativos(Nombre) VALUES
('Técnico'),
('Licenciatura'),
('Licenciatura en ingeniería'),
('Maestría'),
('Doctorado');