DECLARE @Backup      AS VARCHAR(100) = 'AdventureWorks2017.bak'
DECLARE @PathData    AS VARCHAR(255) ='/var/opt/mssql/data/'
DECLARE @PathBkp     AS VARCHAR(255) ='/var/opt/mssql/bkp/'

DECLARE @LogicalNameData AS VARCHAR(255) = ''
DECLARE @LogicalNameLog  AS VARCHAR(255) = ''

DECLARE @PhysicalNameData AS VARCHAR(255) = ''
DECLARE @PhysicalNameLog  AS VARCHAR(255) = ''

DECLARE @BackUpPath  AS VARCHAR(500) = @PathBkp + @Backup



CREATE TABLE  #DBFilesData
(
	 LogicalName					  VARCHAR(255)
	,PhysicalName					  VARCHAR(255)
	,[Type]							  VARCHAR(50)
	,FileGroupName					  VARCHAR(50)
	,Size							  VARCHAR(50)
	,MaxSize						  VARCHAR(50)
	,FileId							  INT
	,CreateLSN						  INT
	,DropLSN						  INT
	,UniqueId						  VARCHAR(255)
	,ReadOnlyLSN					  INT
	,ReadWriteLSN					  INT
	,BackupSizeInBytes				  VARCHAR(50)
	,SourceBlockSize				  INT
	,FileGroupId					  INT
	,LogGroupGUID					  VARCHAR(255)
	,DifferentialBaseLSN			  VARCHAR(50)
	,DifferentialBaseGUID			  VARCHAR(255)
	,IsReadOnly						  INT
	,IsPresent						  INT
	,TDEThumbprint					  VARCHAR(255)
	,SnapshotUrl					  VARCHAR(255)
)

INSERT #DBFilesData
EXEC ('RESTORE FILELISTONLY FROM DISK = '''+ @BackUpPath +'''')


SELECT @LogicalNameData = LogicalName FROM #DBFilesData WHERE PhysicalName LIKE '%mdf'
SELECT @LogicalNameLog  = LogicalName FROM #DBFilesData WHERE PhysicalName LIKE '%ldf'

SELECT @PhysicalNameData = LogicalName FROM #DBFilesData WHERE PhysicalName LIKE '%mdf'
SELECT @PhysicalNameLog  = LogicalName FROM #DBFilesData WHERE PhysicalName LIKE '%ldf'

SET @PhysicalNameData = @PathData + @PhysicalNameData
SET @PhysicalNameLog  = @PathData + @PhysicalNameLog


RESTORE DATABASE [AdventureWorks2017]
FILE = @LogicalNameData
FROM  DISK = @BackUpPath WITH  FILE = 1,
MOVE @LogicalNameData TO @PhysicalNameData  ,
MOVE @LogicalNameLog  TO @PhysicalNameLog   ,
REPLACE,  STATS = 20;

GO



USE [AdventureWorks2017]
DECLARE @LogicalNameLog AS VARCHAR(100)
SELECT @LogicalNameLog = LogicalName  FROM #DBFilesData
WHERE PhysicalName LIKE '%ldf'
DBCC SHRINKFILE (@LogicalNameLog, 1);

DROP TABLE #DBFilesData


