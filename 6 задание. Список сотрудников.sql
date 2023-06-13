USE AdventureWorks2019


;With EmployeeHierarchy(BusinessEntityID, BirthDate, HireDate, OrganizationLevel, Depth) AS (
	SELECT BusinessEntityID, BirthDate, HireDate, OrganizationLevel, 0 as Depth
	FROM HumanResources.Employee 
	WHERE OrganizationLevel IS NULL

	UNION ALL

	SELECT e.BusinessEntityID, e.BirthDate, e.HireDate, e.OrganizationLevel, EH.Depth +1 as Depth
	FROM EmployeeHierarchy as EH
	INNER JOIN HumanResources.Employee  AS e ON EH.BusinessEntityID = e.OrganizationLevel

)

SELECT 
	CONCAT(meneger.LastName, ' ', LEFT(meneger.FirstName, 1), '.', LEFT(meneger.MiddleName, 1), '.') AS ManagerName,
    M.HireDate AS ManagerHireDate,
    M.BirthDate AS ManagerBirthDate,
    CONCAT(empoly.LastName, ' ', LEFT(empoly.FirstName, 1), '.', LEFT(empoly.MiddleName, 1), '.') AS EmployeeName,
    eh.HireDate AS EmployeeHireDate,
	eh.BirthDate AS EmployeeBirthDate
	
FROM EmployeeHierarchy as eh
Inner JOIN Person.Person meneger ON meneger.BusinessEntityID = eh.Depth
INNER JOIN Person.Person empoly ON empoly.BusinessEntityID = eh.BusinessEntityID
inner  JOIN EmployeeHierarchy as m ON m.BusinessEntityID = eh.Depth

WHERE
    M.BirthDate > eh.BirthDate AND
    M.HireDate > eh.HireDate
		
order by eh.Depth, meneger.LastName, empoly.LastName

