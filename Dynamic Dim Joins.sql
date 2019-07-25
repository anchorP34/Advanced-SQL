-- Get all of the capital letters in the alphabet
DROP TABLE IF EXISTS #Alphabet
-- Craete the temp table #Alphabet
CREATE TABLE #Alphabet
(
    PK INT
    , Letter nvarchar(10)
);


-- Insert uppercase values of letters into the table #Alphabet
with 
cte_tally as
(
    select row_number() over (order by (select 1)) as n 
    from sys.all_columns
)
INSERT INTO #Alphabet
select ROW_NUMBER() OVER (ORDER BY Char(n))
  , Char(n) as alpha
from 
  cte_tally
where
  (n > 64 and n < 91)


SELECT *
FROM #Alphabet

----------------------------------------------------
----------------------------------------------------
----------------------------------------------------


-- Declare variables that will need to be used for this process
declare @ColumnName NVARCHAR(255)
declare @letter nvarchar(5)
DECLARE @i int = 1
DECLARE @FactTableSchema nvarchar(255) = 'dbo'
declare @FactTableName nvarchar(255) = 'FactPlayByPlay'

-- Declare the cursor and put in the values of the dimentional columns of the fact table
DECLARE db_cursor CURSOR FOR
SELECT COLUMN_NAME
from INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME LIKE 'Dim%'
AND TABLE_NAME = @FactTableName

-- Open The Cursor
OPEN db_cursor

-- Get the first value of the cursor and place it into the variable @ColumnName
FETCH NEXT FROM db_cursor INTO @ColumnName

PRINT 'SELECT TOP 100 *
FROM ' + @FactTableSchema + '.' + @FactTableName + ' pbp'

-- This means "While there are still more values left in the cursor"
WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Get the letter value needed for the join
        set @letter = (select Letter from #Alphabet where PK = @i )

        -- Get the Table name by taking off "ID" at the end of the string
        declare @JoinTableName nvarchar(255) = (SELECT LEFT(@ColumnName, len(@ColumnName) - 2))

        -- Print the left join for the SQL Query
        PRINT 'LEFT JOIN dbo.' + @JoinTableName + ' ' + @letter + ' ON ' + @letter + '.' 
                                                        + @ColumnName + ' = pbp.' + @ColumnName
        -- Get the next table value from the cursor
        FETCH NEXT FROM db_cursor INTO @ColumnName
        -- Update the value of i
        set @i = @i + 1
    END

-- Close the cursor and then get rid of it
CLOSE db_cursor
DEALLOCATE db_cursor

