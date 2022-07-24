-- SQL Server Indexing Scripts
-- Last script revision - 2019-05-21
--
-- Scripts provided by MSSQLTips.com are from various contributors. Use links below to learn more about the scripts.
-- 
-- Be careful using any of these scripts. Test all scripts in Test/Dev prior to using in Production environments.
-- Please refer to the disclaimer policy: https://www.mssqltips.com/disclaimer/
-- Please refer to the copyright policy: https://www.mssqltips.com/copyright/
--
-- Note, these scripts are meant to be run individually.
--
-- Have a script to contribute or an update?  Send an email to: tips@mssqltips.com


---------------------------------------------------------------------------------------------------------------------------
-- Purpose: This query will return information about indexes and index usage.  Run this in the user database.
-- More Information: https://www.mssqltips.com/sqlservertip/1545/deeper-insight-into-used-and-unused-indexes-for-sql-server/
-- Revision: 2019-05-21
--
SELECT PVT.SCHEMANAME, PVT.TABLENAME, PVT.INDEXNAME, PVT.INDEX_ID, [1] AS COL1, [2] AS COL2, [3] AS COL3, [4] AS COL4,  [5] AS COL5, [6] AS COL6, [7] AS COL7, B.USER_SEEKS, B.USER_SCANS, B.USER_LOOKUPS, B.USER_UPDATES 
FROM   (SELECT SCHEMA_NAME(A.SCHEMA_id) AS SCHEMANAME,
               A.NAME AS TABLENAME, 
               A.OBJECT_ID, 
               B.NAME AS INDEXNAME, 
               B.INDEX_ID, 
               D.NAME AS COLUMNNAME, 
               C.KEY_ORDINAL 
        FROM   SYS.OBJECTS A 
               INNER JOIN SYS.INDEXES B ON A.OBJECT_ID = B.OBJECT_ID 
               LEFT JOIN SYS.INDEX_COLUMNS C ON B.OBJECT_ID = C.OBJECT_ID AND B.INDEX_ID = C.INDEX_ID 
               LEFT JOIN SYS.COLUMNS D ON C.OBJECT_ID = D.OBJECT_ID AND C.COLUMN_ID = D.COLUMN_ID 
        WHERE  A.TYPE = 'U') P 
       PIVOT 
       (MIN(COLUMNNAME) 
        FOR KEY_ORDINAL IN ( [1],[2],[3],[4],[5],[6],[7] ) ) AS PVT 
INNER JOIN SYS.DM_DB_INDEX_USAGE_STATS B ON PVT.OBJECT_ID = B.OBJECT_ID AND PVT.INDEX_ID = B.INDEX_ID AND B.DATABASE_ID = DB_ID() 
UNION -- below returns indexes not used with usage information
SELECT SCHEMANAME, TABLENAME, INDEXNAME, INDEX_ID, [1] AS COL1, [2] AS COL2, [3] AS COL3, [4] AS COL4, [5] AS COL5, [6] AS COL6, [7] AS COL7, 0, 0, 0, 0 
FROM   (SELECT SCHEMA_NAME(A.SCHEMA_id) AS SCHEMANAME,
               A.NAME AS TABLENAME, 
               A.OBJECT_ID, 
               B.NAME AS INDEXNAME, 
               B.INDEX_ID, 
               D.NAME AS COLUMNNAME, 
               C.KEY_ORDINAL 
        FROM   SYS.OBJECTS A 
               INNER JOIN SYS.INDEXES B ON A.OBJECT_ID = B.OBJECT_ID 
			   LEFT JOIN SYS.INDEX_COLUMNS C ON B.OBJECT_ID = C.OBJECT_ID AND B.INDEX_ID = C.INDEX_ID 
               LEFT JOIN SYS.COLUMNS D ON C.OBJECT_ID = D.OBJECT_ID AND C.COLUMN_ID = D.COLUMN_ID 
        WHERE  A.TYPE = 'U') P 
       PIVOT 
       (MIN(COLUMNNAME) 
        FOR KEY_ORDINAL IN ( [1],[2],[3],[4],[5],[6],[7] ) ) AS PVT 
WHERE  NOT EXISTS (SELECT OBJECT_ID, 
                          INDEX_ID 
                   FROM   SYS.DM_DB_INDEX_USAGE_STATS B 
                   WHERE  DATABASE_ID = DB_ID(DB_NAME()) 
                          AND PVT.OBJECT_ID = B.OBJECT_ID 
                          AND PVT.INDEX_ID = B.INDEX_ID) 
ORDER BY SCHEMANAME, TABLENAME, INDEX_ID; 

---------------------------------------------------------------------------------------------------------------------------
-- Purpose: This query will find indexes with duplicate columns. Run this in the user database.
-- More Information: https://www.mssqltips.com/sqlservertip/3604/identify-sql-server-indexes-with-duplicate-columns/
-- Revision: 2019-05-21
--
SELECT t1.tablename, t1.indexname ,t1.columnlist, t2.indexname, t2.columnlist 
FROM
   (SELECT 
      DISTINCT object_name(i.object_id) tablename, 
      i.name indexname,
      (SELECT DISTINCT STUFF( (SELECT ', ' + c.name
                               FROM sys.index_columns ic1 
                               INNER JOIN sys.columns c ON ic1.object_id=c.object_id AND ic1.column_id=c.column_id
                               WHERE 
                                     ic1.index_id = ic.index_id 
                                 AND ic1.object_id=i.object_id
                                 AND ic1.index_id=i.index_id
                               ORDER BY index_column_id FOR XML PATH('')
                              ),1,2,'')
       FROM sys.index_columns ic 
       WHERE object_id=i.object_id AND index_id=i.index_id
     ) as columnlist
   FROM sys.indexes i 
   INNER JOIN sys.index_columns ic ON i.object_id=ic.object_id AND i.index_id=ic.index_id 
   INNER JOIN sys.objects o ON i.object_id=o.object_id 
   WHERE o.is_ms_shipped=0) t1 
INNER JOIN 
   (SELECT 
      DISTINCT object_name(i.object_id) tablename,
      i.name indexname,
     (SELECT DISTINCT STUFF( (SELECT ', ' + c.name
                              FROM sys.index_columns ic1 
                              INNER JOIN sys.columns c ON ic1.object_id=c.object_id AND ic1.column_id=c.column_id
                              WHERE 
                                    ic1.index_id = ic.index_id 
                                AND ic1.object_id=i.object_id 
                                AND ic1.index_id=i.index_id
                              ORDER BY index_column_id FOR XML PATH('')
                             ),1,2,'')
      FROM sys.index_columns ic 
      WHERE object_id=i.object_id AND index_id=i.index_id
     ) as columnlist
    FROM sys.indexes i 
    INNER JOIN sys.index_columns ic ON i.object_id=ic.object_id AND i.index_id=ic.index_id 
    INNER JOIN sys.objects o ON i.object_id=o.object_id 
    WHERE o.is_ms_shipped=0) t2 
 ON t1.tablename=t2.tablename 
AND substring(t2.columnlist,1,len(t1.columnlist))=t1.columnlist 
AND (t1.columnlist<>t2.columnlist or (t1.columnlist=t2.columnlist AND t1.indexname<>t2.indexname))

---------------------------------------------------------------------------------------------------------------------------
-- Purpose: This query will list all indexes in the database and show index columns and included columns. Run this in the user database.
-- More Information: https://www.mssqltips.com/sqlservertip/2914/rolling-up-multiple-rows-into-a-single-row-and-column-for-sql-server-data/
-- Revision: 2019-05-21
--
SELECT 
   SCHEMA_NAME(ss.SCHEMA_id) AS SchemaName,
   ss.name as TableName, 
   ss2.name as IndexName, 
   ss2.index_id,
   ss2.type_desc,
   STUFF((SELECT ', ' + name 
          FROM sys.index_columns a INNER JOIN sys.all_columns b ON a.object_id = b.object_id and a.column_id = b.column_id and a.object_id = ss.object_id and a.index_id = ss2.index_id and is_included_column = 0
          ORDER BY a.key_ordinal
          FOR XML PATH('')), 1, 2, '') IndexColumns,
   STUFF((SELECT ', ' + name 
          FROM sys.index_columns a INNER JOIN sys.all_columns b ON a.object_id = b.object_id and a.column_id = b.column_id and a.object_id = ss.object_id and a.index_id = ss2.index_id and is_included_column = 1
          FOR XML PATH('')), 1, 2, '') IncludedColumns
FROM sys.objects SS INNER JOIN sys.indexes ss2 ON ss.OBJECT_ID = ss2.OBJECT_ID 
WHERE ss.type = 'U'
ORDER BY 1, 2, 3         


---------------------------------------------------------------------------------------------------------------------------
-- Purpose: This query will list all indexes in the database and show index columns and included columns using STRING_AGG (SQL 2017 and later). Run this in the user database.
-- More Information: 
-- Revision: 2019-05-21
--
SELECT 
   SCHEMA_NAME(ss.SCHEMA_id) AS SCHEMANAME,
   ss.name as TableName, 
   ss2.name as IndexName, 
   ss2.index_id,
   (SELECT STRING_AGG(name,', ') 
    FROM sys.index_columns a INNER JOIN sys.all_columns b ON a.object_id = b.object_id and a.column_id = b.column_id and a.object_id = ss.object_id and a.index_id = ss2.index_id and is_included_column = 0
   ) as IndexColumns,
   (SELECT STRING_AGG(name,', ') 
    FROM sys.index_columns a INNER JOIN sys.all_columns b ON a.object_id = b.object_id and a.column_id = b.column_id and a.object_id = ss.object_id and a.index_id = ss2.index_id and is_included_column = 1
   ) as IncludedColumns
FROM sys.objects SS INNER JOIN sys.indexes ss2 ON ss.OBJECT_ID = ss2.OBJECT_ID 
WHERE ss.type = 'U'
ORDER BY 1, 2, 3   

---------------------------------------------------------------------------------------------------------------------------
-- Purpose: This script will find all indexes that are disabled. Run this in the user database.
-- More Information: https://www.mssqltips.com/sqlservertip/1788/disabling-indexes-in-sql-server-2005-and-sql-server-2008/
-- Revision: 2019-05-21
--
DECLARE @is_disabled bit = 0 -- 1=disabled  0=enabled

SELECT 
   SCHEMA_NAME(ss.SCHEMA_id) AS SchemaName,
   ss.name AS TableName,
   ss2.index_id AS IndexID,
   ss2.name AS IndexName, 
   ss2.type_desc AS IndexType, 
   CASE ss2.is_disabled  
      WHEN 0 THEN 'Enabled' 
      ELSE 'Disabled'  
   END AS IndexStatus,  
   ss2.fill_factor AS [FillFactor] 
FROM sys.objects SS INNER JOIN sys.indexes ss2 ON ss.OBJECT_ID = ss2.OBJECT_ID 
WHERE ss.is_ms_shipped = 0
  AND ss2.is_disabled = @is_disabled 
GO

---------------------------------------------------------------------------------------------------------------------------
-- Purpose: Find out how much SQL Server memory each index or heap is currently using. Run this in the user database.
-- More Information: https://www.mssqltips.com/sqlservertip/2393/determine-sql-server-memory-use-by-database-and-object/
-- Revision: 2019-05-21
--
;WITH src
AS (SELECT
      [Object] = o.name,
      [Type] = o.type_desc,
      [Index] = COALESCE(i.name, ''),
      [Index_Type] = i.type_desc,
      p.[object_id],
      p.index_id,
      au.allocation_unit_id
    FROM sys.partitions AS p
      INNER JOIN sys.allocation_units AS au ON p.hobt_id = au.container_id
      INNER JOIN sys.objects AS o ON p.[object_id] = o.[object_id]
      INNER JOIN sys.indexes AS i ON o.[object_id] = i.[object_id] AND p.index_id = i.index_id
    WHERE au.[type] IN (1, 2, 3)
      AND o.is_ms_shipped = 0)
SELECT
  src.[Object],
  src.[Type],
  src.[Index],
  src.Index_Type,
  buffer_pages = COUNT_BIG(b.page_id),
  buffer_mb = COUNT_BIG(b.page_id) / 128
FROM src
  INNER JOIN sys.dm_os_buffer_descriptors AS b ON src.allocation_unit_id = b.allocation_unit_id
WHERE b.database_id = DB_ID()
GROUP BY src.[Object],
         src.[Type],
         src.[Index],
         src.Index_Type
ORDER BY buffer_pages DESC;

---------------------------------------------------------------------------------------------------------------------------
-- Purpose: This script will generate create scripts for all existing indexes in a database. Run this in the user database.
-- More Information: https://www.mssqltips.com/sqlservertip/3441/script-out-all-sql-server-indexes-in-a-database-using-tsql/
-- Revision: 2019-05-21
--
declare @SchemaName varchar(100)declare @TableName varchar(256)
declare @IndexName varchar(256)
declare @ColumnName varchar(100)
declare @is_unique varchar(100)
declare @IndexTypeDesc varchar(100)
declare @FileGroupName varchar(100)
declare @is_disabled varchar(100)
declare @IndexOptions varchar(max)
declare @IndexColumnId int
declare @IsDescendingKey int 
declare @IsIncludedColumn int
declare @TSQLScripCreationIndex varchar(max)
declare @TSQLScripDisableIndex varchar(max)

declare CursorIndex cursor for
 select schema_name(t.schema_id) [schema_name], t.name, ix.name,
 case when ix.is_unique = 1 then 'UNIQUE ' else '' END 
 , ix.type_desc,
 case when ix.is_padded=1 then 'PAD_INDEX = ON, ' else 'PAD_INDEX = OFF, ' end
 + case when ix.allow_page_locks=1 then 'ALLOW_PAGE_LOCKS = ON, ' else 'ALLOW_PAGE_LOCKS = OFF, ' end
 + case when ix.allow_row_locks=1 then  'ALLOW_ROW_LOCKS = ON, ' else 'ALLOW_ROW_LOCKS = OFF, ' end
 + case when INDEXPROPERTY(t.object_id, ix.name, 'IsStatistics') = 1 then 'STATISTICS_NORECOMPUTE = ON, ' else 'STATISTICS_NORECOMPUTE = OFF, ' end
 + case when ix.ignore_dup_key=1 then 'IGNORE_DUP_KEY = ON, ' else 'IGNORE_DUP_KEY = OFF, ' end
 + 'SORT_IN_TEMPDB = OFF, FILLFACTOR =' + CAST(ix.fill_factor AS VARCHAR(3)) AS IndexOptions
 , ix.is_disabled , FILEGROUP_NAME(ix.data_space_id) FileGroupName
 from sys.tables t 
 inner join sys.indexes ix on t.object_id=ix.object_id
 where ix.type>0 and ix.is_primary_key=0 and ix.is_unique_constraint=0 --and schema_name(tb.schema_id)= @SchemaName and tb.name=@TableName
 and t.is_ms_shipped=0 and t.name<>'sysdiagrams'
 order by schema_name(t.schema_id), t.name, ix.name

open CursorIndex
fetch next from CursorIndex into  @SchemaName, @TableName, @IndexName, @is_unique, @IndexTypeDesc, @IndexOptions,@is_disabled, @FileGroupName

while (@@fetch_status=0)
begin
 declare @IndexColumns varchar(max)
 declare @IncludedColumns varchar(max)
 
 set @IndexColumns=''
 set @IncludedColumns=''
 
 declare CursorIndexColumn cursor for 
  select col.name, ixc.is_descending_key, ixc.is_included_column
  from sys.tables tb 
  inner join sys.indexes ix on tb.object_id=ix.object_id
  inner join sys.index_columns ixc on ix.object_id=ixc.object_id and ix.index_id= ixc.index_id
  inner join sys.columns col on ixc.object_id =col.object_id  and ixc.column_id=col.column_id
  where ix.type>0 and (ix.is_primary_key=0 or ix.is_unique_constraint=0)
  and schema_name(tb.schema_id)=@SchemaName and tb.name=@TableName and ix.name=@IndexName
  order by ixc.index_column_id
 
 open CursorIndexColumn 
 fetch next from CursorIndexColumn into  @ColumnName, @IsDescendingKey, @IsIncludedColumn
 
 while (@@fetch_status=0)
 begin
  if @IsIncludedColumn=0 
   set @IndexColumns=@IndexColumns + @ColumnName  + case when @IsDescendingKey=1  then ' DESC, ' else  ' ASC, ' end
  else 
   set @IncludedColumns=@IncludedColumns  + @ColumnName  +', ' 

  fetch next from CursorIndexColumn into @ColumnName, @IsDescendingKey, @IsIncludedColumn
 end

 close CursorIndexColumn
 deallocate CursorIndexColumn

 set @IndexColumns = substring(@IndexColumns, 1, len(@IndexColumns)-1)
 set @IncludedColumns = case when len(@IncludedColumns) >0 then substring(@IncludedColumns, 1, len(@IncludedColumns)-1) else '' end
 --  print @IndexColumns
 --  print @IncludedColumns

 set @TSQLScripCreationIndex =''
 set @TSQLScripDisableIndex =''
 set @TSQLScripCreationIndex='CREATE '+ @is_unique  +@IndexTypeDesc + ' INDEX ' +QUOTENAME(@IndexName)+' ON ' + QUOTENAME(@SchemaName) +'.'+ QUOTENAME(@TableName)+ '('+@IndexColumns+') '+ 
  case when len(@IncludedColumns)>0 then CHAR(13) +'INCLUDE (' + @IncludedColumns+ ')' else '' end + CHAR(13)+'WITH (' + @IndexOptions+ ') ON ' + QUOTENAME(@FileGroupName) + ';'  

 if @is_disabled=1 
  set  @TSQLScripDisableIndex=  CHAR(13) +'ALTER INDEX ' +QUOTENAME(@IndexName) + ' ON ' + QUOTENAME(@SchemaName) +'.'+ QUOTENAME(@TableName) + ' DISABLE;' + CHAR(13) 

 print @TSQLScripCreationIndex
 print @TSQLScripDisableIndex

 fetch next from CursorIndex into  @SchemaName, @TableName, @IndexName, @is_unique, @IndexTypeDesc, @IndexOptions,@is_disabled, @FileGroupName

end
close CursorIndex
deallocate CursorIndex