DROP FUNCTION IF EXISTS dbo.fn_CaseStatementIntervals
GO

CREATE FUNCTION dbo.fn_CaseStatementIntervals(@lower_bound FLOAT
                                            , @upper_bound FLOAT
                                            , @num_of_intervals INT
                                            , @column NVARCHAR(255)
                                            )
RETURNS NVARCHAR(max)
AS
BEGIN 
/*
    This function creates case statements for equal intervals between two values.
    It looks at the lower bound, upper bound and num of intervals to create 
    the different case statements, and then also uses the column parameter to make
    sure its comparing the correct columns

    Example
    INPUT - PRINT  dbo.fn_CaseStatementIntervals(0, 100, 10, 'VAL')
    OUTPUT - CASE
            WHEN VAL > 0 AND VAL <= 10 THEN 1-10
            WHEN VAL > 10 AND VAL <= 20 THEN 11-20
            WHEN VAL > 20 AND VAL <= 30 THEN 21-30
            WHEN VAL > 30 AND VAL <= 40 THEN 31-40
            WHEN VAL > 40 AND VAL <= 50 THEN 41-50
            WHEN VAL > 50 AND VAL <= 60 THEN 51-60
            WHEN VAL > 60 AND VAL <= 70 THEN 61-70
            WHEN VAL > 70 AND VAL <= 80 THEN 71-80
            WHEN VAL > 80 AND VAL <= 90 THEN 81-90
            WHEN VAL > 90 AND VAL <= 100 THEN 91-100
            END AS Intervals 

*/


    /*
    DECLARE @lower_bound float = 0
    , @upper_bound float = 100
    , @num_of_intervals INT = 10
    , @column nvarchar(255) = 'VAL'
    */
    
    DECLARE @return_SQL NVARCHAR(max) = ''

    DECLARE @TotalValue FLOAT = @lower_bound
    DECLARE @SQLStatement NVARCHAR(max)

    DECLARE @IntervalSpread FLOAT = (@upper_bound - @lower_bound) / @num_of_intervals

    SET @return_SQL =  'CASE '

    WHILE @TotalValue < @upper_bound
    BEGIN

        SET @return_SQL = @return_SQL +  '
        WHEN ' + @column + ' > ' + CAST(@TotalValue AS VARCHAR(100)) + ' AND ' 
                + @column + ' <= ' + CAST(@TotalValue + @IntervalSpread AS VARCHAR(100)) 
                + ' THEN ' + CAST(@TotalValue + 1 AS VARCHAR(100)) + '-' + CAST(@TotalValue + @IntervalSpread AS VARCHAR(100))  

        SET @TotalValue = @TotalValue + @IntervalSpread
    END

    SET @return_SQL = @return_SQL +  '
    END AS Intervals'

    RETURN @return_SQL
END
GO


