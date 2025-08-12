-- Crear tabla auditoría si no existe
IF OBJECT_ID('dbo.AuditoriaGeneral') IS NULL
BEGIN
    CREATE TABLE dbo.AuditoriaGeneral (
        ID_Auditoria INT IDENTITY PRIMARY KEY,
        NombreTabla SYSNAME,
        TipoOperacion NVARCHAR(10),
        Usuario NVARCHAR(100),
        FechaOperacion DATETIME,
        ComandoEjecutado NVARCHAR(MAX)
    );
END
GO

DECLARE @NombreTabla SYSNAME;
DECLARE @SQL NVARCHAR(MAX);

-- Eliminar triggers de auditoría viejos
DECLARE cursorDrop CURSOR FOR
SELECT t.name AS TriggerName,
       OBJECT_NAME(t.parent_id) AS TablaAuditada
FROM sys.triggers t
JOIN sys.tables tab ON tab.object_id = t.parent_id
WHERE t.name LIKE 'trg_Auditoria_%'
  AND SCHEMA_NAME(tab.schema_id) = 'dbo';

OPEN cursorDrop;
DECLARE @TriggerName SYSNAME, @TablaAuditada SYSNAME;
FETCH NEXT FROM cursorDrop INTO @TriggerName, @TablaAuditada;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @SQL = 'DROP TRIGGER dbo.' + QUOTENAME(@TriggerName);
    EXEC sp_executesql @SQL;

    FETCH NEXT FROM cursorDrop INTO @TriggerName, @TablaAuditada;
END

CLOSE cursorDrop;
DEALLOCATE cursorDrop;

-- Crear triggers nuevos para todas las tablas excepto AuditoriaGeneral
DECLARE cursorTablas CURSOR FOR
SELECT t.name
FROM sys.tables t
JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE s.name = 'dbo'
  AND t.is_ms_shipped = 0
  AND t.name <> 'AuditoriaGeneral';

OPEN cursorTablas;
FETCH NEXT FROM cursorTablas INTO @NombreTabla;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @SQL = '
    CREATE OR ALTER TRIGGER trg_Auditoria_' + @NombreTabla + '
    ON dbo.' + QUOTENAME(@NombreTabla) + '
    FOR INSERT, UPDATE, DELETE
    AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @Comando NVARCHAR(MAX);
        DECLARE @spid INT = @@SPID;

        -- Tabla temporal para DBCC INPUTBUFFER
        CREATE TABLE #InputBuffer (
            EventType NVARCHAR(30),
            Parameters INT,
            EventInfo NVARCHAR(4000)
        );

        INSERT INTO #InputBuffer EXEC(''DBCC INPUTBUFFER('' + CAST(@spid AS NVARCHAR) + '') WITH NO_INFOMSGS'');

        SELECT @Comando = EventInfo FROM #InputBuffer;

        DROP TABLE #InputBuffer;

        INSERT INTO dbo.AuditoriaGeneral (
            NombreTabla,
            TipoOperacion,
            Usuario,
            FechaOperacion,
            ComandoEjecutado
        )
        SELECT
            ''' + @NombreTabla + ''',
            CASE
                WHEN EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted) THEN ''UPDATE''
                WHEN EXISTS(SELECT * FROM inserted) THEN ''INSERT''
                WHEN EXISTS(SELECT * FROM deleted) THEN ''DELETE''
            END,
            SUSER_SNAME(),
            GETDATE(),
            @Comando;
    END;
    ';

    EXEC sp_executesql @SQL;

    FETCH NEXT FROM cursorTablas INTO @NombreTabla;
END

CLOSE cursorTablas;
DEALLOCATE cursorTablas;