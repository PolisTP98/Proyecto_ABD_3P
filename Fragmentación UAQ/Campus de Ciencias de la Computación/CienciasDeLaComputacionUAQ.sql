IF NOT EXISTS (SELECT 1 FROM sys.databases WHERE name = 'CienciasDeLaComputacionUAQ')
BEGIN
	CREATE DATABASE CienciasDeLaComputacionUAQ;
END


USE CienciasDeLaComputacionUAQ;

-- Crear los catálogos
:r "C:\Users\ianrd\OneDrive\Documentos\BD\Fragmentación UAQ\Plantillas\EstructuraDeCatalogosGenerales.sql"

-- Insertar datos de los catálogos
:r "C:\Users\ianrd\OneDrive\Documentos\BD\Fragmentación UAQ\Plantillas\DatosDeCatalogos.sql"

-- Crear la estructura del campus
:r "C:\Users\ianrd\OneDrive\Documentos\BD\Fragmentación UAQ\Plantillas\EstructuraDeCampus.sql"

-- Insertar datos del campus
:r "C:\Users\ianrd\OneDrive\Documentos\Tareas\Fragmentación UAQ\Funcionamiento\Procedimientos almacenados\InsertarRegistro.sql"
:r "C:\Users\ianrd\OneDrive\Documentos\BD\Fragmentación UAQ\Funcionamiento\Procedimientos almacenados\MensajesDeError.sql"

-- Errores
:r "C:\Users\ianrd\OneDrive\Documentos\Tareas\Fragmentación UAQ\Errores\DatosDeErrores.sql"
:r "C:\Users\ianrd\OneDrive\Documentos\BD\Fragmentación UAQ\Errores\EstructuraDeErrores.sql"

-- Inf. Alumno Privada
:r "C:\Users\ianrd\OneDrive\Documentos\BD\Fragmentación UAQ\Plantillas\EstructuraDeAlumnosPrivada.sql"

-- Inf. Alumno Publica
:r "C:\Users\ianrd\OneDrive\Documentos\BD\Fragmentación UAQ\Plantillas\EstructuraDeAlumnosPublica.sql"

-- Inf. Profesor Privada
:r "C:\Users\ianrd\OneDrive\Documentos\BD\Fragmentación UAQ\Plantillas\EstructuraDeProfesoresPrivada.sql"

-- Inf. Profesor Publica
:r "C:\Users\ianrd\OneDrive\Documentos\BD\Fragmentación UAQ\Plantillas\EstructuraDeProfesoresPublica.sql"

--Insertar Campus

DECLARE @ID_Campus INT;

EXEC dbo.SP_InsertarCampus 
    @Nombre = N'Campus Juriquilla',
    @Estatus = 1,
    @Pais = N'México',
    @Estado = N'Querétaro',
    @Municipio = N'Querétaro',
    @Localidad_comunidad = N'Juriquilla',
    @Calle = N'Av. de las Ciencias',
    @No_exterior = '100',
    @No_interior = NULL,
    @Colonia = N'Juriquilla Santa Fe',
    @Tipo_asentamiento = N'Colonia',
    @Tipo_vialidad = N'Avenida',
    @Codigo_postal = '76230',
    @ID_Campus = @ID_Campus OUTPUT;

EXEC dbo.SP_InsertarCampus 
    @Nombre = N'Campus Centro Histórico',
    @Estatus = 1,
    @Pais = N'México',
    @Estado = N'Querétaro',
    @Municipio = N'Querétaro',
    @Localidad_comunidad = N'Centro',
    @Calle = N'Av. Universidad',
    @No_exterior = '12',
    @No_interior = 'B',
    @Colonia = N'Centro',
    @Tipo_asentamiento = N'Barrio',
    @Tipo_vialidad = N'Avenida',
    @Codigo_postal = '76000',
    @ID_Campus = @ID_Campus OUTPUT;

EXEC dbo.SP_InsertarCampus 
    @Nombre = N'Campus San Juan del Río',
    @Estatus = 1,
    @Pais = N'México',
    @Estado = N'Querétaro',
    @Municipio = N'San Juan del Río',
    @Localidad_comunidad = N'Centro',
    @Calle = N'Blvd. Hidalgo',
    @No_exterior = '500',
    @No_interior = NULL,
    @Colonia = N'Centro',
    @Tipo_asentamiento = N'Colonia',
    @Tipo_vialidad = N'Boulevard',
    @Codigo_postal = '76800',
    @ID_Campus = @ID_Campus OUTPUT;

EXEC dbo.SP_InsertarCampus 
    @Nombre = N'Campus Aeropuerto',
    @Estatus = 1,
    @Pais = N'México',
    @Estado = N'Querétaro',
    @Municipio = N'Colón',
    @Localidad_comunidad = N'Aeropuerto',
    @Calle = N'Carretera 57',
    @No_exterior = 'Km 34',
    @No_interior = NULL,
    @Colonia = N'Parque Industrial Aeropuerto',
    @Tipo_asentamiento = N'Parque Industrial',
    @Tipo_vialidad = N'Carretera',
    @Codigo_postal = '76220',
    @ID_Campus = @ID_Campus OUTPUT;

EXEC dbo.SP_InsertarCampus 
    @Nombre = N'Campus Amazcala',
    @Estatus = 1,
    @Pais = N'México',
    @Estado = N'Querétaro',
    @Municipio = N'El Marqués',
    @Localidad_comunidad = N'Amazcala',
    @Calle = N'Calle Universidad',
    @No_exterior = '15',
    @No_interior = NULL,
    @Colonia = N'Amazcala',
    @Tipo_asentamiento = N'Pueblo',
    @Tipo_vialidad = N'Calle',
    @Codigo_postal = '76260',
    @ID_Campus = @ID_Campus OUTPUT;

EXEC dbo.SP_InsertarCampus 
    @Nombre = N'Campus Tequisquiapan',
    @Estatus = 1,
    @Pais = N'México',
    @Estado = N'Querétaro',
    @Municipio = N'Tequisquiapan',
    @Localidad_comunidad = N'Centro',
    @Calle = N'Av. Juárez',
    @No_exterior = '45',
    @No_interior = NULL,
    @Colonia = N'Centro',
    @Tipo_asentamiento = N'Colonia',
    @Tipo_vialidad = N'Avenida',
    @Codigo_postal = '76750',
    @ID_Campus = @ID_Campus OUTPUT;

EXEC dbo.SP_InsertarCampus 
    @Nombre = N'Campus Cadereyta',
    @Estatus = 1,
    @Pais = N'México',
    @Estado = N'Querétaro',
    @Municipio = N'Cadereyta de Montes',
    @Localidad_comunidad = N'Centro',
    @Calle = N'Calle Hidalgo',
    @No_exterior = '8',
    @No_interior = 'A',
    @Colonia = N'Centro',
    @Tipo_asentamiento = N'Colonia',
    @Tipo_vialidad = N'Calle',
    @Codigo_postal = '76500',
    @ID_Campus = @ID_Campus OUTPUT;

EXEC dbo.SP_InsertarCampus 
    @Nombre = N'Campus Tolimán',
    @Estatus = 1,
    @Pais = N'México',
    @Estado = N'Querétaro',
    @Municipio = N'Tolimán',
    @Localidad_comunidad = N'San Miguel',
    @Calle = N'Calle Principal',
    @No_exterior = '23',
    @No_interior = NULL,
    @Colonia = N'San Miguel',
    @Tipo_asentamiento = N'Pueblo',
    @Tipo_vialidad = N'Calle',
    @Codigo_postal = '76640',
    @ID_Campus = @ID_Campus OUTPUT;

EXEC dbo.SP_InsertarCampus 
    @Nombre = N'Campus Peñamiller',
    @Estatus = 1,
    @Pais = N'México',
    @Estado = N'Querétaro',
    @Municipio = N'Peñamiller',
    @Localidad_comunidad = N'Centro',
    @Calle = N'Calle Independencia',
    @No_exterior = '5',
    @No_interior = NULL,
    @Colonia = N'Centro',
    @Tipo_asentamiento = N'Colonia',
    @Tipo_vialidad = N'Calle',
    @Codigo_postal = '76550',
    @ID_Campus = @ID_Campus OUTPUT;

EXEC dbo.SP_InsertarCampus 
    @Nombre = N'Campus Amealco',
    @Estatus = 1,
    @Pais = N'México',
    @Estado = N'Querétaro',
    @Municipio = N'Amealco de Bonfil',
    @Localidad_comunidad = N'Centro',
    @Calle = N'Av. Morelos',
    @No_exterior = '101',
    @No_interior = NULL,
    @Colonia = N'Centro',
    @Tipo_asentamiento = N'Colonia',
    @Tipo_vialidad = N'Avenida',
    @Codigo_postal = '76850',
    @ID_Campus = @ID_Campus OUTPUT;


-- Insertar Aula

DECLARE @ID_Aula INT;

EXEC dbo.SP_InsertarAula 
    @Nombre = 'Aula Magna',
    @Estatus = 1,
    @ID_Aula = @ID_Aula OUTPUT;

EXEC dbo.SP_InsertarAula 
    @Nombre = 'Laboratorio de Cómputo 1',
    @Estatus = 1,
    @ID_Aula = @ID_Aula OUTPUT;

EXEC dbo.SP_InsertarAula 
    @Nombre = 'Laboratorio de Cómputo 2',
    @Estatus = 1,
    @ID_Aula = @ID_Aula OUTPUT;

EXEC dbo.SP_InsertarAula 
    @Nombre = 'Sala de Conferencias',
    @Estatus = 1,
    @ID_Aula = @ID_Aula OUTPUT;

EXEC dbo.SP_InsertarAula 
    @Nombre = 'Aula Virtual',
    @Estatus = 1,
    @ID_Aula = @ID_Aula OUTPUT;

EXEC dbo.SP_InsertarAula 
    @Nombre = 'Taller de Electrónica',
    @Estatus = 1,
    @ID_Aula = @ID_Aula OUTPUT;

EXEC dbo.SP_InsertarAula 
    @Nombre = 'Taller de Robótica',
    @Estatus = 1,
    @ID_Aula = @ID_Aula OUTPUT;

EXEC dbo.SP_InsertarAula 
    @Nombre = 'Aula Audiovisual',
    @Estatus = 1,
    @ID_Aula = @ID_Aula OUTPUT;

EXEC dbo.SP_InsertarAula 
    @Nombre = 'Sala de Idiomas',
    @Estatus = 1,
    @ID_Aula = @ID_Aula OUTPUT;

EXEC dbo.SP_InsertarAula 
    @Nombre = 'Laboratorio de Física',
    @Estatus = 1,
    @ID_Aula = @ID_Aula OUTPUT;

-- Insertar Especialidad

DECLARE @ID_Especialidad INT;

EXEC dbo.SP_InsertarEspecialidad
    @ID_Campus = 1,
    @Nombre = N'Ingeniería en Software',
    @Fecha_registro = '2025-08-11',
    @ID_Modalidad = 1,
    @Estatus = 1,
    @ID_Especialidad = @ID_Especialidad OUTPUT;

EXEC dbo.SP_InsertarEspecialidad
    @ID_Campus = 2,
    @Nombre = N'Licenciatura en Matemáticas Aplicadas',
    @Fecha_registro = '2025-08-11',
    @ID_Modalidad = 1,
    @Estatus = 1,
    @ID_Especialidad = @ID_Especialidad OUTPUT;

EXEC dbo.SP_InsertarEspecialidad
    @ID_Campus = 3,
    @Nombre = N'Ingeniería en Ciberseguridad',
    @Fecha_registro = '2025-08-11',
    @ID_Modalidad = 3,
    @Estatus = 1,
    @ID_Especialidad = @ID_Especialidad OUTPUT;

EXEC dbo.SP_InsertarEspecialidad
    @ID_Campus = 4,
    @Nombre = N'Tecnologías de la Información',
    @Fecha_registro = '2025-08-11',
    @ID_Modalidad = 2,
    @Estatus = 1,
    @ID_Especialidad = @ID_Especialidad OUTPUT;

EXEC dbo.SP_InsertarEspecialidad
    @ID_Campus = 5,
    @Nombre = N'Ingeniería Mecatrónica',
    @Fecha_registro = '2025-08-11',
    @ID_Modalidad = 1,
    @Estatus = 1,
    @ID_Especialidad = @ID_Especialidad OUTPUT;

EXEC dbo.SP_InsertarEspecialidad
    @ID_Campus = 6,
    @Nombre = N'Licenciatura en Física',
    @Fecha_registro = '2025-08-11',
    @ID_Modalidad = 1,
    @Estatus = 1,
    @ID_Especialidad = @ID_Especialidad OUTPUT;

EXEC dbo.SP_InsertarEspecialidad
    @ID_Campus = 7,
    @Nombre = N'Ingeniería Ambiental',
    @Fecha_registro = '2025-08-11',
    @ID_Modalidad = 3,
    @Estatus = 1,
    @ID_Especialidad = @ID_Especialidad OUTPUT;

EXEC dbo.SP_InsertarEspecialidad
    @ID_Campus = 8,
    @Nombre = N'Ingeniería Civil',
    @Fecha_registro = '2025-08-11',
    @ID_Modalidad = 1,
    @Estatus = 1,
    @ID_Especialidad = @ID_Especialidad OUTPUT;

EXEC dbo.SP_InsertarEspecialidad
    @ID_Campus = 9,
    @Nombre = N'Arquitectura',
    @Fecha_registro = '2025-08-11',
    @ID_Modalidad = 2,
    @Estatus = 1,
    @ID_Especialidad = @ID_Especialidad OUTPUT;

EXEC dbo.SP_InsertarEspecialidad
    @ID_Campus = 10,
    @Nombre = N'Licenciatura en Diseño Industrial',
    @Fecha_registro = '2025-08-11',
    @ID_Modalidad = 1,
    @Estatus = 1,
    @ID_Especialidad = @ID_Especialidad OUTPUT;

--Insertar Carrera

DECLARE @ID_Carrera INT;

EXEC dbo.SP_InsertarCarrera
    @ID_Campus = 1,
    @Clave = 'ISW-2025-01',
    @Nombre = N'Ingeniería en Software',
    @Fecha_registro = '2025-08-11',
    @Duracion_semestres = 9,
    @Year_vigencia = 2025,
    @ID_Nivel = 1,
    @Estatus = 1,
    @ID_Carrera = @ID_Carrera OUTPUT;

EXEC dbo.SP_InsertarCarrera
    @ID_Campus = 2,
    @Clave = 'MAT-2025-01',
    @Nombre = N'Matemáticas Aplicadas',
    @Fecha_registro = '2025-08-11',
    @Duracion_semestres = 8,
    @Year_vigencia = 2025,
    @ID_Nivel = 1,
    @Estatus = 1,
    @ID_Carrera = @ID_Carrera OUTPUT;

EXEC dbo.SP_InsertarCarrera
    @ID_Campus = 3,
    @Clave = 'CIB-2025-01',
    @Nombre = N'Ingeniería en Ciberseguridad',
    @Fecha_registro = '2025-08-11',
    @Duracion_semestres = 9,
    @Year_vigencia = 2025,
    @ID_Nivel = 1,
    @Estatus = 1,
    @ID_Carrera = @ID_Carrera OUTPUT;

EXEC dbo.SP_InsertarCarrera
    @ID_Campus = 4,
    @Clave = 'TIC-2025-01',
    @Nombre = N'Tecnologías de la Información',
    @Fecha_registro = '2025-08-11',
    @Duracion_semestres = 8,
    @Year_vigencia = 2025,
    @ID_Nivel = 1,
    @Estatus = 1,
    @ID_Carrera = @ID_Carrera OUTPUT;

EXEC dbo.SP_InsertarCarrera
    @ID_Campus = 5,
    @Clave = 'MEC-2025-01',
    @Nombre = N'Ingeniería Mecatrónica',
    @Fecha_registro = '2025-08-11',
    @Duracion_semestres = 9,
    @Year_vigencia = 2025,
    @ID_Nivel = 1,
    @Estatus = 1,
    @ID_Carrera = @ID_Carrera OUTPUT;

EXEC dbo.SP_InsertarCarrera
    @ID_Campus = 6,
    @Clave = 'FIS-2025-01',
    @Nombre = N'Licenciatura en Física',
    @Fecha_registro = '2025-08-11',
    @Duracion_semestres = 8,
    @Year_vigencia = 2025,
    @ID_Nivel = 1,
    @Estatus = 1,
    @ID_Carrera = @ID_Carrera OUTPUT;

EXEC dbo.SP_InsertarCarrera
    @ID_Campus = 7,
    @Clave = 'AMB-2025-01',
    @Nombre = N'Ingeniería Ambiental',
    @Fecha_registro = '2025-08-11',
    @Duracion_semestres = 9,
    @Year_vigencia = 2025,
    @ID_Nivel = 1,
    @Estatus = 1,
    @ID_Carrera = @ID_Carrera OUTPUT;

EXEC dbo.SP_InsertarCarrera
    @ID_Campus = 8,
    @Clave = 'CIV-2025-01',
    @Nombre = N'Ingeniería Civil',
    @Fecha_registro = '2025-08-11',
    @Duracion_semestres = 9,
    @Year_vigencia = 2025,
    @ID_Nivel = 1,
    @Estatus = 1,
    @ID_Carrera = @ID_Carrera OUTPUT;

EXEC dbo.SP_InsertarCarrera
    @ID_Campus = 9,
    @Clave = 'ARQ-2025-01',
    @Nombre = N'Arquitectura',
    @Fecha_registro = '2025-08-11',
    @Duracion_semestres = 10,
    @Year_vigencia = 2025,
    @ID_Nivel = 1,
    @Estatus = 1,
    @ID_Carrera = @ID_Carrera OUTPUT;

EXEC dbo.SP_InsertarCarrera
    @ID_Campus = 10,
    @Clave = 'DIS-2025-01',
    @Nombre = N'Diseño Industrial',
    @Fecha_registro = '2025-08-11',
    @Duracion_semestres = 8,
    @Year_vigencia = 2025,
    @ID_Nivel = 1,
    @Estatus = 1,
    @ID_Carrera = @ID_Carrera OUTPUT;

-- Insertar Materias

-- 1. Prueba con todos los campos válidos
DECLARE @ID_Materia INT;
EXEC dbo.SP_InsertarMateria
    @Clave = 'MAT101',
    @Nombre = 'Matemáticas Básicas',
    @Fecha_registro = '2025-08-11',
    @Creditos = 6,
    @Estatus = 1,
    @ID_Materia = @ID_Materia OUTPUT;
PRINT 'ID_Materia insertada: ' + CAST(@ID_Materia AS VARCHAR);

-- 2. Prueba dejando que Fecha_registro y Estatus usen valores por defecto
DECLARE @ID_Materia2 INT;
EXEC dbo.SP_InsertarMateria
    @Clave = 'MAT102',
    @Nombre = 'Física General',
    @Creditos = 8,
    @ID_Materia = @ID_Materia2 OUTPUT;
PRINT 'ID_Materia insertada: ' + CAST(@ID_Materia2 AS VARCHAR);

DECLARE @ID_Materia3 INT;
EXEC dbo.SP_InsertarMateria
    @Clave = 'MAT105',
    @Nombre = 'Programación I',
    @Fecha_registro = DEFAULT,  
    @Creditos = 8,
    @Estatus = DEFAULT,
    @ID_Materia = @ID_Materia3 OUTPUT;
PRINT 'ID_Materia insertada: ' + CAST(@ID_Materia3 AS VARCHAR);

DECLARE @ID_Materia4 INT;
EXEC dbo.SP_InsertarMateria
    @Clave = 'MAT106',
    @Nombre = 'Base de Datos',
    @Fecha_registro = DEFAULT,
    @Creditos = 7,
    @Estatus = DEFAULT,
    @ID_Materia = @ID_Materia4 OUTPUT;
PRINT 'ID_Materia insertada: ' + CAST(@ID_Materia4 AS VARCHAR);

DECLARE @ID_Materia5 INT;
EXEC dbo.SP_InsertarMateria
    @Clave = 'MAT107',
    @Nombre = 'Ingeniería de Software',
    @Fecha_registro = DEFAULT,
    @Creditos = 9,
    @Estatus = DEFAULT,
    @ID_Materia = @ID_Materia5 OUTPUT;
PRINT 'ID_Materia insertada: ' + CAST(@ID_Materia5 AS VARCHAR);

DECLARE @ID_Materia6 INT;
EXEC dbo.SP_InsertarMateria
    @Clave = 'MAT108',
    @Nombre = 'Cálculo Diferencial',
    @Fecha_registro = DEFAULT,
    @Creditos = 6,
    @Estatus = DEFAULT,
    @ID_Materia = @ID_Materia6 OUTPUT;
PRINT 'ID_Materia insertada: ' + CAST(@ID_Materia6 AS VARCHAR);

DECLARE @ID_Materia7 INT;
EXEC dbo.SP_InsertarMateria
    @Clave = 'MAT109',
    @Nombre = 'Sistemas Operativos',
    @Fecha_registro = DEFAULT,
    @Creditos = 7,
    @Estatus = DEFAULT,
    @ID_Materia = @ID_Materia7 OUTPUT;
PRINT 'ID_Materia insertada: ' + CAST(@ID_Materia7 AS VARCHAR);

DECLARE @ID_Materia8 INT;
EXEC dbo.SP_InsertarMateria
    @Clave = 'MAT110',
    @Nombre = 'Redes de Computadoras',
    @Fecha_registro = DEFAULT,
    @Creditos = 8,
    @Estatus = DEFAULT,
    @ID_Materia = @ID_Materia8 OUTPUT;
PRINT 'ID_Materia insertada: ' + CAST(@ID_Materia8 AS VARCHAR);

DECLARE @ID_Materia9 INT;
EXEC dbo.SP_InsertarMateria
    @Clave = 'MAT111',
    @Nombre = 'Inteligencia Artificial',
    @Fecha_registro = DEFAULT,
    @Creditos = 10,
    @Estatus = DEFAULT,
    @ID_Materia = @ID_Materia9 OUTPUT;
PRINT 'ID_Materia insertada: ' + CAST(@ID_Materia9 AS VARCHAR);


-- Verificar inserciones
SELECT * FROM dbo.Materias;


-------------PRUEBA DE ERRORES EN MATERIAS-------------------------------------------
-- 3. Prueba con campo obligatorio faltante (Nombre nulo)
EXEC dbo.SP_InsertarMateria
    @Clave = 'MAT103',
    @Nombre = NULL,
    @Creditos = 5;

-- 4. Prueba con créditos fuera de rango
EXEC dbo.SP_InsertarMateria
    @Clave = 'MAT104',
    @Nombre = 'Química',
    @Creditos = 15;

-- 5. Prueba con clave duplicada
DECLARE @ID_Materia3 INT;
EXEC dbo.SP_InsertarMateria
    @Clave = 'MAT101', 
    @Nombre = 'Matemáticas Avanzadas',
    @Creditos = 6,
    @ID_Materia = @ID_Materia3 OUTPUT;

-- 6. Verificar que las materias se insertaron correctamente
SELECT * FROM dbo.Materias;



--Insertar Aula por campus

EXEC dbo.SP_InsertarAulaPorCampus @ID_Campus = 1, @ID_Aula = 1;
EXEC dbo.SP_InsertarAulaPorCampus @ID_Campus = 1, @ID_Aula = 2;
EXEC dbo.SP_InsertarAulaPorCampus @ID_Campus = 2, @ID_Aula = 3;
EXEC dbo.SP_InsertarAulaPorCampus @ID_Campus = 2, @ID_Aula = 4, @Estatus = 0;
EXEC dbo.SP_InsertarAulaPorCampus @ID_Campus = 3, @ID_Aula = 5;
EXEC dbo.SP_InsertarAulaPorCampus @ID_Campus = 3, @ID_Aula = 6;
EXEC dbo.SP_InsertarAulaPorCampus @ID_Campus = 1, @ID_Aula = 7;
EXEC dbo.SP_InsertarAulaPorCampus @ID_Campus = 2, @ID_Aula = 8, @Estatus = 0;
EXEC dbo.SP_InsertarAulaPorCampus @ID_Campus = 3, @ID_Aula = 9;
EXEC dbo.SP_InsertarAulaPorCampus @ID_Campus = 1, @ID_Aula = 10;


--Insertar Materia por Carrera
-- Asignar materias a carreras (IDs de materia del 1 al 9 según tu inserción)

EXEC dbo.SP_InsertarMateriaPorCarrera @ID_Carrera = 1, @ID_Materia = 1;  -- Matemáticas Básicas
EXEC dbo.SP_InsertarMateriaPorCarrera @ID_Carrera = 1, @ID_Materia = 2;  -- Física General
EXEC dbo.SP_InsertarMateriaPorCarrera @ID_Carrera = 2, @ID_Materia = 3;  -- Programación I
EXEC dbo.SP_InsertarMateriaPorCarrera @ID_Carrera = 2, @ID_Materia = 4;  -- Base de Datos
EXEC dbo.SP_InsertarMateriaPorCarrera @ID_Carrera = 3, @ID_Materia = 5;  -- Ingeniería de Software
EXEC dbo.SP_InsertarMateriaPorCarrera @ID_Carrera = 3, @ID_Materia = 6;  -- Cálculo Diferencial
EXEC dbo.SP_InsertarMateriaPorCarrera @ID_Carrera = 4, @ID_Materia = 7;  -- Sistemas Operativos
EXEC dbo.SP_InsertarMateriaPorCarrera @ID_Carrera = 4, @ID_Materia = 8;  -- Redes de Computadoras
EXEC dbo.SP_InsertarMateriaPorCarrera @ID_Carrera = 5, @ID_Materia = 9;  -- Inteligencia Artificial
EXEC dbo.SP_InsertarMateriaPorCarrera @ID_Carrera = 5, @ID_Materia = 1, @Estatus = 0;  -- Matemáticas Básicas (con estatus inactivo)

SELECT * FROM dbo.MateriasPorCarrera;
DELETE FROM dbo.MateriasPorCarrera;

--Insertar Grupo

DECLARE @ID_Grupo INT;

EXEC dbo.SP_InsertarGrupo @ID_Carrera = 1, @Clave = 'GRP-ISW-01', @Nombre = 'Grupo Software A', @Semestre_actual = 1, @Estatus = 1, @ID_Grupo = @ID_Grupo OUTPUT;
PRINT 'Grupo insertado con ID: ' + CAST(@ID_Grupo AS VARCHAR);

EXEC dbo.SP_InsertarGrupo @ID_Carrera = 2, @Clave = 'GRP-MAT-01', @Nombre = 'Grupo Matemáticas A', @Semestre_actual = 2, @ID_Grupo = @ID_Grupo OUTPUT;
PRINT 'Grupo insertado con ID: ' + CAST(@ID_Grupo AS VARCHAR);

EXEC dbo.SP_InsertarGrupo @ID_Carrera = 3, @Clave = 'GRP-CIB-01', @Nombre = 'Grupo Ciberseguridad A', @Semestre_actual = 3, @Estatus = 0, @ID_Grupo = @ID_Grupo OUTPUT;
PRINT 'Grupo insertado con ID: ' + CAST(@ID_Grupo AS VARCHAR);

EXEC dbo.SP_InsertarGrupo @ID_Carrera = 4, @Clave = 'GRP-TIC-01', @Nombre = 'Grupo TIC B', @Semestre_actual = 1, @ID_Grupo = @ID_Grupo OUTPUT;
PRINT 'Grupo insertado con ID: ' + CAST(@ID_Grupo AS VARCHAR);

EXEC dbo.SP_InsertarGrupo @ID_Carrera = 5, @Clave = 'GRP-MEC-01', @Nombre = 'Grupo Mecatrónica A', @Semestre_actual = 4, @ID_Grupo = @ID_Grupo OUTPUT;
PRINT 'Grupo insertado con ID: ' + CAST(@ID_Grupo AS VARCHAR);

EXEC dbo.SP_InsertarGrupo @ID_Carrera = 6, @Clave = 'GRP-FIS-01', @Nombre = 'Grupo Física B', @Semestre_actual = 2, @ID_Grupo = @ID_Grupo OUTPUT;
PRINT 'Grupo insertado con ID: ' + CAST(@ID_Grupo AS VARCHAR);

EXEC dbo.SP_InsertarGrupo @ID_Carrera = 7, @Clave = 'GRP-AMB-01', @Nombre = 'Grupo Ambiental A', @Semestre_actual = 3, @Estatus = 1, @ID_Grupo = @ID_Grupo OUTPUT;
PRINT 'Grupo insertado con ID: ' + CAST(@ID_Grupo AS VARCHAR);

EXEC dbo.SP_InsertarGrupo @ID_Carrera = 8, @Clave = 'GRP-CIV-01', @Nombre = 'Grupo Civil A', @Semestre_actual = 1, @ID_Grupo = @ID_Grupo OUTPUT;
PRINT 'Grupo insertado con ID: ' + CAST(@ID_Grupo AS VARCHAR);

EXEC dbo.SP_InsertarGrupo @ID_Carrera = 9, @Clave = 'GRP-ARQ-01', @Nombre = 'Grupo Arquitectura A', @Semestre_actual = 2, @ID_Grupo = @ID_Grupo OUTPUT;
PRINT 'Grupo insertado con ID: ' + CAST(@ID_Grupo AS VARCHAR);

EXEC dbo.SP_InsertarGrupo @ID_Carrera = 10, @Clave = 'GRP-DIS-01', @Nombre = 'Grupo Diseño Industrial A', @Semestre_actual = 1, @ID_Grupo = @ID_Grupo OUTPUT;
PRINT 'Grupo insertado con ID: ' + CAST(@ID_Grupo AS VARCHAR);


--Insertar Alumno

DECLARE @ID_Alumno INT;

EXEC dbo.SP_InsertarAlumno
    @Nombres = N'Juan',
    @Apellido_paterno = N'Pérez',
    @Apellido_materno = N'Gómez',
    @Fecha_nacimiento = '2000-05-15',
    @Pais_origen = N'México',
    @Correo_personal = 'juan.perez@email.com',
    @ID_Sexo = 1,
    @CURP = 'PEGA000515HDFRZN09',
    @NSS = '123456789012345',
    @Telefono = '5512345678',
    @Pais = N'México',
    @Estado = N'CDMX',
    @Municipio = N'Coyoacán',
    @Localidad_comunidad = N'Ciudad Universitaria',
    @Calle = N'Av. Universidad',
    @No_exterior = '300',
    @No_interior = '2A',
    @Colonia = N'Copilco',
    @Tipo_asentamiento = N'Colonia',
    @Tipo_vialidad = N'Avenida',
    @Codigo_postal = '04510',
    @ID_Alumno = @ID_Alumno OUTPUT;
PRINT 'ID Alumno insertado: ' + CAST(@ID_Alumno AS VARCHAR);

EXEC dbo.SP_InsertarAlumno
    @Nombres = N'María',
    @Apellido_paterno = N'López',
    @Apellido_materno = N'Martínez',
    @Fecha_nacimiento = '1999-11-22',
    @Pais_origen = N'México',
    @Correo_personal = 'maria.lopez@mail.com',
    @ID_Sexo = 2,
    @CURP = 'LOMM991122MDFRTL08',
    @NSS = '987654321098765',
    @Telefono = '5523456789',
    @Pais = N'México',
    @Estado = N'Jalisco',
    @Municipio = N'Guadalajara',
    @Localidad_comunidad = N'Zapopan',
    @Calle = N'Av. Patria',
    @No_exterior = '150',
    @No_interior = NULL,
    @Colonia = N'Vallarta',
    @Tipo_asentamiento = N'Colonia',
    @Tipo_vialidad = N'Avenida',
    @Codigo_postal = '44100',
    @ID_Alumno = @ID_Alumno OUTPUT;
PRINT 'ID Alumno insertado: ' + CAST(@ID_Alumno AS VARCHAR);

EXEC dbo.SP_InsertarAlumno
    @Nombres = N'Carlos',
    @Apellido_paterno = N'Ramírez',
    @Apellido_materno = NULL,
    @Fecha_nacimiento = '2001-03-05',
    @Pais_origen = N'México',
    @Correo_personal = 'carlos.ramirez@email.com',
    @ID_Sexo = 1,
    @CURP = 'RACM010305HDFRMC07',
    @NSS = '567890123456789',
    @Telefono = '5534567890',
    @Pais = N'México',
    @Estado = N'Nuevo León',
    @Municipio = N'Monterrey',
    @Localidad_comunidad = N'San Pedro',
    @Calle = N'Calle 5 de Mayo',
    @No_exterior = '45',
    @No_interior = '3B',
    @Colonia = N'Centro',
    @Tipo_asentamiento = N'Colonia',
    @Tipo_vialidad = N'Calle',
    @Codigo_postal = '64000',
    @ID_Alumno = @ID_Alumno OUTPUT;
PRINT 'ID Alumno insertado: ' + CAST(@ID_Alumno AS VARCHAR);

EXEC dbo.SP_InsertarAlumno
    @Nombres = N'Andrea',
    @Apellido_paterno = N'Hernández',
    @Apellido_materno = N'Vázquez',
    @Fecha_nacimiento = '2002-07-18',
    @Pais_origen = N'México',
    @Correo_personal = 'andrea.hernandez@mail.com',
    @ID_Sexo = 2,
    @CURP = 'HEVA020718MDFRNDA6',
    @NSS = '123459876543210',
    @Telefono = '5545678901',
    @Pais = N'México',
    @Estado = N'Puebla',
    @Municipio = N'Puebla',
    @Localidad_comunidad = N'La Paz',
    @Calle = N'Calle Reforma',
    @No_exterior = '78',
    @No_interior = NULL,
    @Colonia = N'Centro',
    @Tipo_asentamiento = N'Barrio',
    @Tipo_vialidad = N'Calle',
    @Codigo_postal = '72000',
    @ID_Alumno = @ID_Alumno OUTPUT;
PRINT 'ID Alumno insertado: ' + CAST(@ID_Alumno AS VARCHAR);

EXEC dbo.SP_InsertarAlumno
    @Nombres = N'Luis',
    @Apellido_paterno = N'González',
    @Apellido_materno = N'Flores',
    @Fecha_nacimiento = '1998-01-10',
    @Pais_origen = N'México',
    @Correo_personal = 'luis.gonzalez@email.com',
    @ID_Sexo = 1,
    @CURP = 'GOFL980110HDFRNL09',
    @NSS = '345678901234567',
    @Telefono = '5556789012',
    @Pais = N'México',
    @Estado = N'Chiapas',
    @Municipio = N'Tuxtla Gutiérrez',
    @Localidad_comunidad = N'5 de Mayo',
    @Calle = N'Avenida Central',
    @No_exterior = '20',
    @No_interior = '1C',
    @Colonia = N'Campestre',
    @Tipo_asentamiento = N'Colonia',
    @Tipo_vialidad = N'Avenida',
    @Codigo_postal = '29000',
    @ID_Alumno = @ID_Alumno OUTPUT;
PRINT 'ID Alumno insertado: ' + CAST(@ID_Alumno AS VARCHAR);

EXEC dbo.SP_InsertarAlumno
    @Nombres = N'Sofía',
    @Apellido_paterno = N'Morales',
    @Apellido_materno = NULL,
    @Fecha_nacimiento = '2000-12-01',
    @Pais_origen = N'México',
    @Correo_personal = 'sofia.morales@mail.com',
    @ID_Sexo = 2,
    @CURP = 'MOSF001201MDFRLNS5',
    @NSS = '678901234567890',
    @Telefono = '5567890123',
    @Pais = N'México',
    @Estado = N'Yucatán',
    @Municipio = N'Mérida',
    @Localidad_comunidad = N'Centro',
    @Calle = N'Calle 60',
    @No_exterior = '10',
    @No_interior = NULL,
    @Colonia = N'Centro',
    @Tipo_asentamiento = N'Colonia',
    @Tipo_vialidad = N'Calle',
    @Codigo_postal = '97000',
    @ID_Alumno = @ID_Alumno OUTPUT;
PRINT 'ID Alumno insertado: ' + CAST(@ID_Alumno AS VARCHAR);

EXEC dbo.SP_InsertarAlumno
    @Nombres = N'Pedro',
    @Apellido_paterno = N'Sánchez',
    @Apellido_materno = N'Ramírez',
    @Fecha_nacimiento = '1997-09-25',
    @Pais_origen = N'México',
    @Correo_personal = 'pedro.sanchez@mail.com',
    @ID_Sexo = 1,
    @CURP = 'SARP970925HDFLMD08',
    @NSS = '789012345678901',
    @Telefono = '5578901234',
    @Pais = N'México',
    @Estado = N'Jalisco',
    @Municipio = N'Tlajomulco',
    @Localidad_comunidad = N'Las Pintas',
    @Calle = N'Calle Primavera',
    @No_exterior = '25',
    @No_interior = '4B',
    @Colonia = N'Los Fresnos',
    @Tipo_asentamiento = N'Fraccionamiento',
    @Tipo_vialidad = N'Calle',
    @Codigo_postal = '45640',
    @ID_Alumno = @ID_Alumno OUTPUT;
PRINT 'ID Alumno insertado: ' + CAST(@ID_Alumno AS VARCHAR);

EXEC dbo.SP_InsertarAlumno
    @Nombres = N'Gabriela',
    @Apellido_paterno = N'Mendoza',
    @Apellido_materno = N'Vega',
    @Fecha_nacimiento = '2001-04-12',
    @Pais_origen = N'México',
    @Correo_personal = 'gabriela.mendoza@email.com',
    @ID_Sexo = 2,
    @CURP = 'MEVG010412MDFNDG07',
    @NSS = '890123456789012',
    @Telefono = '5589012345',
    @Pais = N'México',
    @Estado = N'Querétaro',
    @Municipio = N'San Juan del Río',
    @Localidad_comunidad = N'Centro',
    @Calle = N'Avenida Hidalgo',
    @No_exterior = '50',
    @No_interior = NULL,
    @Colonia = N'Centro',
    @Tipo_asentamiento = N'Colonia',
    @Tipo_vialidad = N'Avenida',
    @Codigo_postal = '76800',
    @ID_Alumno = @ID_Alumno OUTPUT;
PRINT 'ID Alumno insertado: ' + CAST(@ID_Alumno AS VARCHAR);

EXEC dbo.SP_InsertarAlumno
    @Nombres = N'Ricardo',
    @Apellido_paterno = N'Fernández',
    @Apellido_materno = N'Castillo',
    @Fecha_nacimiento = '1999-06-30',
    @Pais_origen = N'México',
    @Correo_personal = 'ricardo.fernandez@mail.com',
    @ID_Sexo = 1,
    @CURP = 'FECR990630HDFRNC05',
    @NSS = '901234567890123',
    @Telefono = '5590123456',
    @Pais = N'México',
    @Estado = N'Morelos',
    @Municipio = N'Cuernavaca',
    @Localidad_comunidad = N'Centro',
    @Calle = N'Calle Morelos',
    @No_exterior = '100',
    @No_interior = '1A',
    @Colonia = N'Centro',
    @Tipo_asentamiento = N'Colonia',
    @Tipo_vialidad = N'Calle',
    @Codigo_postal = '62000',
    @ID_Alumno = @ID_Alumno OUTPUT;
PRINT 'ID Alumno insertado: ' + CAST(@ID_Alumno AS VARCHAR);

--Insertar Expediente

DECLARE @ID_Expediente INT;

EXEC dbo.SP_InsertarExpedienteAcademico
    @Matricula = 'MAT202300001',
    @ID_Alumno = 1,
    @ID_Grupo = 1,
    @Periodo = '2023-1',
    @Fecha_ingreso = '2023-01-15',
    @Fecha_egreso = NULL,
    @Fecha_baja_academica = NULL,
    @Promedio_general = 8.75,
    @Correo_institucional = 'juan.perez@university.edu.mx',
    @Baja_temporal = 0,
    @ID_EstatusAlumno = 1,
    @ID_Campus = 1,
    @ID_Expediente = @ID_Expediente OUTPUT;
PRINT 'ID Expediente insertado: ' + CAST(@ID_Expediente AS VARCHAR);

EXEC dbo.SP_InsertarExpedienteAcademico
    @Matricula = 'MAT202300002',
    @ID_Alumno = 2,
    @ID_Grupo = 2,
    @Periodo = '2023-1',
    @Fecha_ingreso = '2023-01-20',
    @Correo_institucional = 'maria.lopez@university.edu.mx',
    @ID_Campus = 1,
    @ID_Expediente = @ID_Expediente OUTPUT;
PRINT 'ID Expediente insertado: ' + CAST(@ID_Expediente AS VARCHAR);

EXEC dbo.SP_InsertarExpedienteAcademico
    @Matricula = 'MAT202300003',
    @ID_Alumno = 3,
    @ID_Grupo = 3,
    @Periodo = '2023-2',
    @Fecha_ingreso = '2023-08-01',
    @Promedio_general = 9.10,
    @Correo_institucional = 'carlos.ramirez@university.edu.mx',
    @Baja_temporal = 1,
    @ID_EstatusAlumno = 2,
    @ID_Campus = 2,
    @ID_Expediente = @ID_Expediente OUTPUT;
PRINT 'ID Expediente insertado: ' + CAST(@ID_Expediente AS VARCHAR);

EXEC dbo.SP_InsertarExpedienteAcademico
    @Matricula = 'MAT202300004',
    @ID_Alumno = 4,
    @ID_Grupo = 1,
    @Periodo = '2023-1',
    @Fecha_ingreso = '2023-01-15',
    @Fecha_baja_academica = '2023-04-15',
    @Correo_institucional = 'andrea.hernandez@university.edu.mx',
    @ID_Campus = 1,
    @ID_Expediente = @ID_Expediente OUTPUT;
PRINT 'ID Expediente insertado: ' + CAST(@ID_Expediente AS VARCHAR);

EXEC dbo.SP_InsertarExpedienteAcademico
    @Matricula = 'MAT202300005',
    @ID_Alumno = 5,
    @ID_Grupo = 2,
    @Periodo = '2023-2',
    @Correo_institucional = 'luis.gonzalez@university.edu.mx',
    @ID_Campus = 2,
    @ID_Expediente = @ID_Expediente OUTPUT;
PRINT 'ID Expediente insertado: ' + CAST(@ID_Expediente AS VARCHAR);

EXEC dbo.SP_InsertarExpedienteAcademico
    @Matricula = 'MAT202300006',
    @ID_Alumno = 6,
    @ID_Grupo = 3,
    @Periodo = '2023-1',
    @Fecha_ingreso = '2023-01-10',
    @Promedio_general = 7.5,
    @Correo_institucional = 'sofia.morales@university.edu.mx',
    @Baja_temporal = 1,
    @ID_EstatusAlumno = 1,
    @ID_Campus = 1,
    @ID_Expediente = @ID_Expediente OUTPUT;
PRINT 'ID Expediente insertado: ' + CAST(@ID_Expediente AS VARCHAR);

EXEC dbo.SP_InsertarExpedienteAcademico
    @Matricula = 'MAT202300007',
    @ID_Alumno = 7,
    @ID_Grupo = 1,
    @Periodo = '2023-2',
    @Correo_institucional = 'pedro.sanchez@university.edu.mx',
    @ID_Campus = 2,
    @ID_Expediente = @ID_Expediente OUTPUT;
PRINT 'ID Expediente insertado: ' + CAST(@ID_Expediente AS VARCHAR);

EXEC dbo.SP_InsertarExpedienteAcademico
    @Matricula = 'MAT202300008',
    @ID_Alumno = 8,
    @ID_Grupo = 2,
    @Periodo = '2023-1',
    @Fecha_ingreso = '2023-01-15',
    @Fecha_egreso = '2024-12-10',
    @Promedio_general = 9.5,
    @Correo_institucional = 'gabriela.mendoza@university.edu.mx',
    @ID_EstatusAlumno = 3,
    @ID_Campus = 1,
    @ID_Expediente = @ID_Expediente OUTPUT;
PRINT 'ID Expediente insertado: ' + CAST(@ID_Expediente AS VARCHAR);

EXEC dbo.SP_InsertarExpedienteAcademico
    @Matricula = 'MAT202300009',
    @ID_Alumno = 9,
    @ID_Grupo = 3,
    @Periodo = '2023-2',
    @Correo_institucional = 'ricardo.fernandez@university.edu.mx',
    @ID_Campus = 2,
    @ID_Expediente = @ID_Expediente OUTPUT;
PRINT 'ID Expediente insertado: ' + CAST(@ID_Expediente AS VARCHAR);

EXEC dbo.SP_InsertarExpedienteAcademico
    @Matricula = 'MAT202300010',
    @ID_Alumno = 10,
    @ID_Grupo = 1,
    @Periodo = '2023-1',
    @Fecha_ingreso = '2023-01-15',
    @Correo_institucional = 'ana.garcia@university.edu.mx',
    @Baja_temporal = 0,
    @ID_EstatusAlumno = 1,
    @ID_Campus = 1,
    @ID_Expediente = @ID_Expediente OUTPUT;
PRINT 'ID Expediente insertado: ' + CAST(@ID_Expediente AS VARCHAR);

select * from dbo.ExpedientesAcademicos;

--Insertar Profesor

DECLARE @ID_Profesor INT;

-- Ejemplo 1
EXEC dbo.SP_InsertarProfesor
	@Nombres = N'Juan',
	@Apellido_paterno = N'Pérez',
	@Apellido_materno = N'García',
	@Fecha_nacimiento = '1980-05-15',
	@Pais_origen = N'México',
	@Correo_personal = N'juan.perez@email.com',
	@ID_Sexo = 1,
	@ID_Campus = 2,
	@RFC = 'PEPJ800515AAA01',
	@CURP = 'PEPJ800515HDFRRN01',
	@NSS = '12345678901',
	@Telefono = '5551112221',
	@Pais = N'México',
	@Estado = N'CDMX',
	@Municipio = N'Benito Juárez',
	@Localidad_comunidad = N'Ciudad de México',
	@Calle = N'Avenida Reforma',
	@No_exterior = '123',
	@No_interior = '5A',
	@Colonia = N'Centro',
	@Tipo_asentamiento = N'Colonia',
	@Tipo_vialidad = N'Avenida',
	@Codigo_postal = '06000',
	@Matricula = 'MAT10001',
	@Fecha_contratacion = '2023-01-10',
	@Fecha_fin_contrato = '2025-01-10',
	@Correo_institucional = N'jperez@universidad.edu.mx',
	@Salario_quincenal = 8500.00,
	@ID_EstatusProfesor = 1,
	@ID_Profesor = @ID_Profesor OUTPUT;

PRINT 'ID Profesor Insertado 1: ' + CAST(@ID_Profesor AS NVARCHAR);

-- Ejemplo 2
EXEC dbo.SP_InsertarProfesor
	@Nombres = N'María',
	@Apellido_paterno = N'López',
	@Fecha_nacimiento = '1975-12-22',
	@Pais_origen = N'México',
	@Correo_personal = N'mlopez@email.com',
	@ID_Sexo = 2,
	@ID_Campus = 1,
	@RFC = 'LOPM751222BBB02',
	@CURP = 'LOPM751222MDFLRR02',
	@NSS = '98765432109',
	@Telefono = '5551112222',
	@Pais = N'México',
	@Estado = N'Jalisco',
	@Municipio = N'Guadalajara',
	@Localidad_comunidad = N'Guadalajara',
	@Calle = N'Calle Morelos',
	@No_exterior = '456',
	@No_interior = NULL,
	@Colonia = N'Providencia',
	@Tipo_asentamiento = N'Colonia',
	@Tipo_vialidad = N'Calle',
	@Codigo_postal = '44100',
	@Matricula = 'MAT10002',
	@Fecha_contratacion = '2022-09-01',
	@Fecha_fin_contrato = NULL,
	@Correo_institucional = N'mlopez@universidad.edu.mx',
	@Salario_quincenal = 9000.50,
	@ID_EstatusProfesor = 1,
	@ID_Profesor = @ID_Profesor OUTPUT;

PRINT 'ID Profesor Insertado 2: ' + CAST(@ID_Profesor AS NVARCHAR);

-- Ejemplo 3
EXEC dbo.SP_InsertarProfesor
	@Nombres = N'Carlos',
	@Apellido_paterno = N'Martínez',
	@Apellido_materno = N'Ramos',
	@Fecha_nacimiento = '1990-03-10',
	@Pais_origen = N'México',
	@Correo_personal = N'carlos.martinez@email.com',
	@ID_Sexo = 1,
	@ID_Campus = 3,
	@RFC = 'MARC900310CCC03',
	@CURP = 'MARC900310HDFLRS03',
	@NSS = '11223344556',
	@Telefono = '5551112223',
	@Pais = N'México',
	@Estado = N'Nuevo León',
	@Municipio = N'Monterrey',
	@Localidad_comunidad = N'Monterrey',
	@Calle = N'Calle Juárez',
	@No_exterior = '789',
	@No_interior = '2B',
	@Colonia = N'San Pedro',
	@Tipo_asentamiento = N'Colonia',
	@Tipo_vialidad = N'Calle',
	@Codigo_postal = '64000',
	@Matricula = 'MAT10003',
	@Fecha_contratacion = '2024-03-15',
	@Fecha_fin_contrato = '2026-03-15',
	@Correo_institucional = N'cmartinez@universidad.edu.mx',
	@Salario_quincenal = 10000.00,
	@ID_EstatusProfesor = 2,
	@ID_Profesor = @ID_Profesor OUTPUT;

PRINT 'ID Profesor Insertado 3: ' + CAST(@ID_Profesor AS NVARCHAR);

-- Ejemplo 4
EXEC dbo.SP_InsertarProfesor
	@Nombres = N'Laura',
	@Apellido_paterno = N'Sánchez',
	@Apellido_materno = NULL,
	@Fecha_nacimiento = '1985-07-08',
	@Pais_origen = N'México',
	@Correo_personal = N'laura.sanchez@email.com',
	@ID_Sexo = 2,
	@ID_Campus = 2,
	@RFC = 'SALA850708DDD04',
	@CURP = 'SALA850708MDFLNR04',
	@NSS = '99887766554',
	@Telefono = '5551112224',
	@Pais = N'México',
	@Estado = N'Puebla',
	@Municipio = N'Puebla',
	@Localidad_comunidad = N'Puebla',
	@Calle = N'Boulevard Atlixco',
	@No_exterior = '321',
	@No_interior = NULL,
	@Colonia = N'Centro',
	@Tipo_asentamiento = N'Colonia',
	@Tipo_vialidad = N'Boulevard',
	@Codigo_postal = '72000',
	@Matricula = 'MAT10004',
	@Fecha_contratacion = '2021-06-20',
	@Fecha_fin_contrato = NULL,
	@Correo_institucional = N'lsanchez@universidad.edu.mx',
	@Salario_quincenal = 7500.00,
	@ID_EstatusProfesor = 1,
	@ID_Profesor = @ID_Profesor OUTPUT;

PRINT 'ID Profesor Insertado 4: ' + CAST(@ID_Profesor AS NVARCHAR);

-- Ejemplo 5
EXEC dbo.SP_InsertarProfesor
	@Nombres = N'Fernando',
	@Apellido_paterno = N'Gómez',
	@Apellido_materno = N'Morales',
	@Fecha_nacimiento = '1978-11-30',
	@Pais_origen = N'México',
	@Correo_personal = N'fernando.gomez@email.com',
	@ID_Sexo = 1,
	@ID_Campus = 1,
	@RFC = 'GOMF781130EEE05',
	@CURP = 'GOMF781130HDFMRL05',
	@NSS = '66778899001',
	@Telefono = '5551112225',
	@Pais = N'México',
	@Estado = N'Chiapas',
	@Municipio = N'Tuxtla Gutiérrez',
	@Localidad_comunidad = N'Tuxtla',
	@Calle = N'Calle Central',
	@No_exterior = '100',
	@No_interior = '1',
	@Colonia = N'Barrio Nuevo',
	@Tipo_asentamiento = N'Colonia',
	@Tipo_vialidad = N'Calle',
	@Codigo_postal = '29000',
	@Matricula = 'MAT10005',
	@Fecha_contratacion = '2020-02-01',
	@Fecha_fin_contrato = '2024-02-01',
	@Correo_institucional = N'fgomez@universidad.edu.mx',
	@Salario_quincenal = 8200.00,
	@ID_EstatusProfesor = 1,
	@ID_Profesor = @ID_Profesor OUTPUT;

PRINT 'ID Profesor Insertado 5: ' + CAST(@ID_Profesor AS NVARCHAR);

-- Ejemplo 6
EXEC dbo.SP_InsertarProfesor
	@Nombres = N'Andrea',
	@Apellido_paterno = N'Ruiz',
	@Apellido_materno = N'Vázquez',
	@Fecha_nacimiento = '1988-04-25',
	@Pais_origen = N'México',
	@Correo_personal = N'andrea.ruiz@email.com',
	@ID_Sexo = 2,
	@ID_Campus = 3,
	@RFC = 'RUZA880425FFF06',
	@CURP = 'RUZA880425MDFRVZ06',
	@NSS = '55443322110',
	@Telefono = '5551112226',
	@Pais = N'México',
	@Estado = N'Yucatán',
	@Municipio = N'Mérida',
	@Localidad_comunidad = N'Mérida',
	@Calle = N'Calle 60',
	@No_exterior = '250',
	@No_interior = NULL,
	@Colonia = N'Centro',
	@Tipo_asentamiento = N'Colonia',
	@Tipo_vialidad = N'Calle',
	@Codigo_postal = '97000',
	@Matricula = 'MAT10006',
	@Fecha_contratacion = '2023-05-01',
	@Fecha_fin_contrato = NULL,
	@Correo_institucional = N'aruiz@universidad.edu.mx',
	@Salario_quincenal = 7800.00,
	@ID_EstatusProfesor = 1,
	@ID_Profesor = @ID_Profesor OUTPUT;

PRINT 'ID Profesor Insertado 6: ' + CAST(@ID_Profesor AS NVARCHAR);

-- Ejemplo 7
EXEC dbo.SP_InsertarProfesor
	@Nombres = N'Roberto',
	@Apellido_paterno = N'Muñoz',
	@Apellido_materno = N'Lopez',
	@Fecha_nacimiento = '1992-08-14',
	@Pais_origen = N'México',
	@Correo_personal = N'roberto.munoz@email.com',
	@ID_Sexo = 1,
	@ID_Campus = 1,
	@RFC = 'MURR920814GGG07',
	@CURP = 'MURR920814HDFMPL07',
	@NSS = '11235813213',
	@Telefono = '5551112227',
	@Pais = N'México',
	@Estado = N'Querétaro',
	@Municipio = N'Santiago de Querétaro',
	@Localidad_comunidad = N'Querétaro',
	@Calle = N'Boulevard Bernardo Quintana',
	@No_exterior = '555',
	@No_interior = '10',
	@Colonia = N'Juriquilla',
	@Tipo_asentamiento = N'Fraccionamiento',
	@Tipo_vialidad = N'Boulevard',
	@Codigo_postal = '76230',
	@Matricula = 'MAT10007',
	@Fecha_contratacion = '2021-11-20',
	@Fecha_fin_contrato = '2023-11-20',
	@Correo_institucional = N'rmunoz@universidad.edu.mx',
	@Salario_quincenal = 8700.00,
	@ID_EstatusProfesor = 2,
	@ID_Profesor = @ID_Profesor OUTPUT;

PRINT 'ID Profesor Insertado 7: ' + CAST(@ID_Profesor AS NVARCHAR);

-- Ejemplo 8
EXEC dbo.SP_InsertarProfesor
	@Nombres = N'Paola',
	@Apellido_paterno = N'Hernández',
	@Apellido_materno = N'Martínez',
	@Fecha_nacimiento = '1983-01-30',
	@Pais_origen = N'México',
	@Correo_personal = N'paola.hernandez@email.com',
	@ID_Sexo = 2,
	@ID_Campus = 2,
	@RFC = 'HEMP830130HHH08',
	@CURP = 'HEMP830130MDFRMN08',
	@NSS = '99887766553',
	@Telefono = '5551112228',
	@Pais = N'México',
	@Estado = N'Oaxaca',
	@Municipio = N'Oaxaca de Juárez',
	@Localidad_comunidad = N'Oaxaca',
	@Calle = N'Calle 20 de Noviembre',
	@No_exterior = '89',
	@No_interior = NULL,
	@Colonia = N'Centro',
	@Tipo_asentamiento = N'Colonia',
	@Tipo_vialidad = N'Calle',
	@Codigo_postal = '68000',
	@Matricula = 'MAT10008',
	@Fecha_contratacion = '2019-08-15',
	@Fecha_fin_contrato = NULL,
	@Correo_institucional = N'phernandez@universidad.edu.mx',
	@Salario_quincenal = 7300.00,
	@ID_EstatusProfesor = 1,
	@ID_Profesor = @ID_Profesor OUTPUT;

PRINT 'ID Profesor Insertado 8: ' + CAST(@ID_Profesor AS NVARCHAR);

-- Ejemplo 9
EXEC dbo.SP_InsertarProfesor
	@Nombres = N'Andrés',
	@Apellido_paterno = N'Cruz',
	@Apellido_materno = N'Santos',
	@Fecha_nacimiento = '1970-10-10',
	@Pais_origen = N'México',
	@Correo_personal = N'andres.cruz@email.com',
	@ID_Sexo = 1,
	@ID_Campus = 3,
	@RFC = 'CRUA701010III09',
	@CURP = 'CRUA701010HDFRNS09',
	@NSS = '55446677889',
	@Telefono = '5551112229',
	@Pais = N'México',
	@Estado = N'Sonora',
	@Municipio = N'Hermosillo',
	@Localidad_comunidad = N'Hermosillo',
	@Calle = N'Avenida Kino',
	@No_exterior = '200',
	@No_interior = NULL,
	@Colonia = N'San Benito',
	@Tipo_asentamiento = N'Colonia',
	@Tipo_vialidad = N'Avenida',
	@Codigo_postal = '83000',
	@Matricula = 'MAT10009',
	@Fecha_contratacion = '2018-04-01',
	@Fecha_fin_contrato = '2023-04-01',
	@Correo_institucional = N'acruz@universidad.edu.mx',
	@Salario_quincenal = 9500.00,
	@ID_EstatusProfesor = 3,
	@ID_Profesor = @ID_Profesor OUTPUT;

PRINT 'ID Profesor Insertado 9: ' + CAST(@ID_Profesor AS NVARCHAR);

-- Ejemplo 10
EXEC dbo.SP_InsertarProfesor
	@Nombres = N'Gabriela',
	@Apellido_paterno = N'Méndez',
	@Apellido_materno = N'Ortiz',
	@Fecha_nacimiento = '1995-06-20',
	@Pais_origen = N'México',
	@Correo_personal = N'gabriela.mendez@email.com',
	@ID_Sexo = 2,
	@ID_Campus = 1,
	@RFC = 'MOGG950620JJJ10',
	@CURP = 'MOGG950620MDFMRZ10',
	@NSS = '66779900112',
	@Telefono = '5551112230',
	@Pais = N'México',
	@Estado = N'Zacatecas',
	@Municipio = N'Zacatecas',
	@Localidad_comunidad = N'Zacatecas',
	@Calle = N'Calle Hidalgo',
	@No_exterior = '10',
	@No_interior = '3C',
	@Colonia = N'Centro Histórico',
	@Tipo_asentamiento = N'Colonia',
	@Tipo_vialidad = N'Calle',
	@Codigo_postal = '98000',
	@Matricula = 'MAT10010',
	@Fecha_contratacion = '2024-07-01',
	@Fecha_fin_contrato = NULL,
	@Correo_institucional = N'gmendez@universidad.edu.mx',
	@Salario_quincenal = 7700.00,
	@ID_EstatusProfesor = 1,
	@ID_Profesor = @ID_Profesor OUTPUT;

PRINT 'ID Profesor Insertado 10: ' + CAST(@ID_Profesor AS NVARCHAR);

select * from dbo.ProfesoresPrivado;

--Insertar Especialidades por Profesor

EXEC dbo.SP_InsertarEspecialidadPorProfesor @ID_Profesor = 1, @ID_Especialidad = 3;
EXEC dbo.SP_InsertarEspecialidadPorProfesor @ID_Profesor = 1, @ID_Especialidad = 4;
EXEC dbo.SP_InsertarEspecialidadPorProfesor @ID_Profesor = 2, @ID_Especialidad = 1;
EXEC dbo.SP_InsertarEspecialidadPorProfesor @ID_Profesor = 2, @ID_Especialidad = 2;
EXEC dbo.SP_InsertarEspecialidadPorProfesor @ID_Profesor = 3, @ID_Especialidad = 2;
EXEC dbo.SP_InsertarEspecialidadPorProfesor @ID_Profesor = 3, @ID_Especialidad = 3;
EXEC dbo.SP_InsertarEspecialidadPorProfesor @ID_Profesor = 4, @ID_Especialidad = 1;
EXEC dbo.SP_InsertarEspecialidadPorProfesor @ID_Profesor = 5, @ID_Especialidad = 1;
EXEC dbo.SP_InsertarEspecialidadPorProfesor @ID_Profesor = 6, @ID_Especialidad = 2;
EXEC dbo.SP_InsertarEspecialidadPorProfesor @ID_Profesor = 7, @ID_Especialidad = 1;

SELECT ID_Profesor, ID_Especialidad FROM dbo.EspecialidadesPorProfesor;

--Insertar Grupo por Profesor

DECLARE @ID_GrupoProfesor INT;

EXEC dbo.SP_InsertarGrupoPorProfesor
	@ID_Profesor = 1,
	@ID_Grupo = 1,
	@ID_Materia = 1,
	@Hora_inicio = '08:00',
	@Hora_fin = '10:00',
	@ID_Aula = 1,
	@Estatus = 1,
	@ID_GrupoProfesor = @ID_GrupoProfesor OUTPUT;
PRINT 'ID GrupoProfesor Insertado 1: ' + CAST(@ID_GrupoProfesor AS NVARCHAR);

EXEC dbo.SP_InsertarGrupoPorProfesor
	@ID_Profesor = 2,
	@ID_Grupo = 2,
	@ID_Materia = 3,
	@Hora_inicio = '10:00',
	@Hora_fin = '12:00',
	@ID_Aula = 2,
	@Estatus = 1,
	@ID_GrupoProfesor = @ID_GrupoProfesor OUTPUT;
PRINT 'ID GrupoProfesor Insertado 2: ' + CAST(@ID_GrupoProfesor AS NVARCHAR);

EXEC dbo.SP_InsertarGrupoPorProfesor
	@ID_Profesor = 3,
	@ID_Grupo = 3,
	@ID_Materia = 2,
	@Hora_inicio = '13:00',
	@Hora_fin = '15:00',
	@ID_Aula = 3,
	@Estatus = 1,
	@ID_GrupoProfesor = @ID_GrupoProfesor OUTPUT;
PRINT 'ID GrupoProfesor Insertado 3: ' + CAST(@ID_GrupoProfesor AS NVARCHAR);

EXEC dbo.SP_InsertarGrupoPorProfesor
	@ID_Profesor = 4,
	@ID_Grupo = 4,
	@ID_Materia = 4,
	@Hora_inicio = '15:00',
	@Hora_fin = '17:00',
	@ID_Aula = 4,
	@Estatus = NULL,
	@ID_GrupoProfesor = @ID_GrupoProfesor OUTPUT;
PRINT 'ID GrupoProfesor Insertado 4: ' + CAST(@ID_GrupoProfesor AS NVARCHAR);

EXEC dbo.SP_InsertarGrupoPorProfesor
	@ID_Profesor = 5,
	@ID_Grupo = 5,
	@ID_Materia = 5,
	@Hora_inicio = '08:30',
	@Hora_fin = '10:30',
	@ID_Aula = 5,
	@ID_GrupoProfesor = @ID_GrupoProfesor OUTPUT;
PRINT 'ID GrupoProfesor Insertado 5: ' + CAST(@ID_GrupoProfesor AS NVARCHAR);

EXEC dbo.SP_InsertarGrupoPorProfesor
	@ID_Profesor = 1,
	@ID_Grupo = 6,
	@ID_Materia = 3,
	@Hora_inicio = '11:00',
	@Hora_fin = '13:00',
	@ID_Aula = 6,
	@Estatus = 0,
	@ID_GrupoProfesor = @ID_GrupoProfesor OUTPUT;
PRINT 'ID GrupoProfesor Insertado 6: ' + CAST(@ID_GrupoProfesor AS NVARCHAR);

EXEC dbo.SP_InsertarGrupoPorProfesor
	@ID_Profesor = 2,
	@ID_Grupo = 7,
	@ID_Materia = 1,
	@Hora_inicio = '14:00',
	@Hora_fin = '16:00',
	@ID_Aula = 7,
	@Estatus = 1,
	@ID_GrupoProfesor = @ID_GrupoProfesor OUTPUT;
PRINT 'ID GrupoProfesor Insertado 7: ' + CAST(@ID_GrupoProfesor AS NVARCHAR);

EXEC dbo.SP_InsertarGrupoPorProfesor
	@ID_Profesor = 3,
	@ID_Grupo = 8,
	@ID_Materia = 4,
	@Hora_inicio = '16:30',
	@Hora_fin = '18:30',
	@ID_Aula = 8,
	@ID_GrupoProfesor = @ID_GrupoProfesor OUTPUT;
PRINT 'ID GrupoProfesor Insertado 8: ' + CAST(@ID_GrupoProfesor AS NVARCHAR);

EXEC dbo.SP_InsertarGrupoPorProfesor
	@ID_Profesor = 4,
	@ID_Grupo = 9,
	@ID_Materia = 2,
	@Hora_inicio = '09:00',
	@Hora_fin = '11:00',
	@ID_Aula = 9,
	@Estatus = 1,
	@ID_GrupoProfesor = @ID_GrupoProfesor OUTPUT;
PRINT 'ID GrupoProfesor Insertado 9: ' + CAST(@ID_GrupoProfesor AS NVARCHAR);

EXEC dbo.SP_InsertarGrupoPorProfesor
	@ID_Profesor = 5,
	@ID_Grupo = 10,
	@ID_Materia = 5,
	@Hora_inicio = '12:00',
	@Hora_fin = '14:00',
	@ID_Aula = 10,
	@Estatus = 1,
	@ID_GrupoProfesor = @ID_GrupoProfesor OUTPUT;
PRINT 'ID GrupoProfesor Insertado 10: ' + CAST(@ID_GrupoProfesor AS NVARCHAR);

--Insertar Inscripcion

DECLARE @ID_Inscripcion INT;

EXEC dbo.SP_InsertarInscripcion @ID_GrupoProfesor = 1, @ID_Expediente = 1, @Fecha_inscripcion = '2025-08-01', @Periodo = '2025-1', @ID_Inscripcion = @ID_Inscripcion OUTPUT;
PRINT 'Inscripcion Insertada ID: ' + CAST(@ID_Inscripcion AS NVARCHAR);

EXEC dbo.SP_InsertarInscripcion @ID_GrupoProfesor = 2, @ID_Expediente = 2, @Fecha_inscripcion = '2025-08-02', @Periodo = '2025-1', @ID_Inscripcion = @ID_Inscripcion OUTPUT;
PRINT 'Inscripcion Insertada ID: ' + CAST(@ID_Inscripcion AS NVARCHAR);

EXEC dbo.SP_InsertarInscripcion @ID_GrupoProfesor = 3, @ID_Expediente = 3, @Fecha_inscripcion = NULL, @Periodo = '2025-1', @ID_Inscripcion = @ID_Inscripcion OUTPUT;
PRINT 'Inscripcion Insertada ID: ' + CAST(@ID_Inscripcion AS NVARCHAR);

EXEC dbo.SP_InsertarInscripcion @ID_GrupoProfesor = 4, @ID_Expediente = 4, @Fecha_inscripcion = '2025-07-15', @Periodo = '2025-1', @ID_Inscripcion = @ID_Inscripcion OUTPUT;
PRINT 'Inscripcion Insertada ID: ' + CAST(@ID_Inscripcion AS NVARCHAR);

EXEC dbo.SP_InsertarInscripcion @ID_GrupoProfesor = 5, @ID_Expediente = 5, @Fecha_inscripcion = NULL, @Periodo = '2025-1', @ID_Inscripcion = @ID_Inscripcion OUTPUT;
PRINT 'Inscripcion Insertada ID: ' + CAST(@ID_Inscripcion AS NVARCHAR);

EXEC dbo.SP_InsertarInscripcion @ID_GrupoProfesor = 6, @ID_Expediente = 6, @Fecha_inscripcion = '2025-06-30', @Periodo = '2025-1', @ID_Inscripcion = @ID_Inscripcion OUTPUT;
PRINT 'Inscripcion Insertada ID: ' + CAST(@ID_Inscripcion AS NVARCHAR);

EXEC dbo.SP_InsertarInscripcion @ID_GrupoProfesor = 7, @ID_Expediente = 7, @Fecha_inscripcion = NULL, @Periodo = '2025-1', @ID_Inscripcion = @ID_Inscripcion OUTPUT;
PRINT 'Inscripcion Insertada ID: ' + CAST(@ID_Inscripcion AS NVARCHAR);

EXEC dbo.SP_InsertarInscripcion @ID_GrupoProfesor = 8, @ID_Expediente = 8, @Fecha_inscripcion = '2025-07-01', @Periodo = '2025-1', @ID_Inscripcion = @ID_Inscripcion OUTPUT;
PRINT 'Inscripcion Insertada ID: ' + CAST(@ID_Inscripcion AS NVARCHAR);

EXEC dbo.SP_InsertarInscripcion @ID_GrupoProfesor = 9, @ID_Expediente = 9, @Fecha_inscripcion = NULL, @Periodo = '2025-1', @ID_Inscripcion = @ID_Inscripcion OUTPUT;
PRINT 'Inscripcion Insertada ID: ' + CAST(@ID_Inscripcion AS NVARCHAR);

EXEC dbo.SP_InsertarInscripcion @ID_GrupoProfesor = 10, @ID_Expediente = 10, @Fecha_inscripcion = '2025-08-12', @Periodo = '2025-1', @ID_Inscripcion = @ID_Inscripcion OUTPUT;
PRINT 'Inscripcion Insertada ID: ' + CAST(@ID_Inscripcion AS NVARCHAR);

select * from dbo.Inscripciones;