IF NOT EXISTS (SELECT 1 FROM sys.databases WHERE name = 'MedicinaUAQ')
BEGIN
	CREATE DATABASE MedicinaUAQ;
END

USE MedicinaUAQ;

-- Crear los catálogos
:r "C:\Users\ianrd\OneDrive\Documentos\BD\Fragmentación UAQ\Plantillas\EstructuraDeCatalogosGenerales.sql"

-- Insertar datos de los catálogos
:r "C:\Users\ianrd\OneDrive\Documentos\BD\Fragmentación UAQ\Plantillas\DatosDeCatalogos.sql"

-- Crear la estructura del campus
:r "C:\Users\ianrd\OneDrive\Documentos\BD\Fragmentación UAQ\Plantillas\EstructuraDeCampus.sql"

-- Insertar datos del campus
:r "C:\Users\ianrd\OneDrive\Documentos\BD\Fragmentación UAQ\Funcionamiento\Procedimientos almacenados\InsertarRegistro.sql"
:r "C:\Users\ianrd\OneDrive\Documentos\BD\Fragmentación UAQ\Funcionamiento\Procedimientos almacenados\MensajesDeError.sql"

-- Errores
:r "C:\Users\ianrd\OneDrive\Documentos\BD\Fragmentación UAQ\Errores\DatosDeErrores.sql"
:r "C:\Users\ianrd\OneDrive\Documentos\BD\Fragmentación UAQ\Errores\EstructuraDeErrores.sql"

-- Inf. Alumno Privada
:r "C:\Users\ianrd\OneDrive\Documentos\BD\Fragmentación UAQ\Plantillas\EstructuraDeAlumnosPrivada.sql"

-- Inf. Alumno Publica
:r "C:\Users\ianrd\OneDrive\Documentos\BD\Fragmentación UAQ\Plantillas\EstructuraDeAlumnosPublica.sql"

-- Inf. Profesor Privada
:r "C:\Users\ianrd\OneDrive\Documentos\BD\Fragmentación UAQ\Plantillas\EstructuraDeProfesoresPrivada.sql"

-- Inf. Profesor Publica
:r "C:\Users\ianrd\OneDrive\Documentos\BD\Fragmentación UAQ\Plantillas\EstructuraDeProfesoresPublica.sql"