USE AdventureWorks2019

CREATE PROCEDURE [dbo].[GetSingleMaleEmployeesBornBetweenDates]
(
    @StartDate DATE,
    @EndDate DATE,
    @ResultCount INT OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        e.BusinessEntityID,
		person.LastName,
		person.FirstName,
        Gender, 
        BirthDate, 
        MaritalStatus
    INTO #TempEmployees
    FROM HumanResources.Employee e
	LEFT JOIN 
		Person.Person person ON person.BusinessEntityID = e.BusinessEntityID
    WHERE Gender = 'M' AND MaritalStatus = 'S'
    AND BirthDate BETWEEN @StartDate AND @EndDate;

    SET @ResultCount = @@ROWCOUNT;

    SELECT * FROM #TempEmployees;

    DROP TABLE #TempEmployees;
END

DECLARE @count INT
EXEC GetSingleMaleEmployeesBornBetweenDates '1980-01-01', '1990-01-01', @count OUTPUT
SELECT @count