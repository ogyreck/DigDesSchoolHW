USE AdventureWorks2019;

GO  
  if OBJECT_ID('HumanResources.EmployeeDemo') is not null
 drop table HumanResources.EmployeeDemo 

 SELECT emp.BusinessEntityID AS EmployeeID,  
  (SELECT  man.BusinessEntityID FROM HumanResources.Employee man 
	    WHERE emp.OrganizationNode.GetAncestor(1)=man.OrganizationNode OR 
		    (emp.OrganizationNode.GetAncestor(1) = 0x AND man.OrganizationNode IS NULL)) AS ManagerID,
        emp.HireDate, emp.BirthDate, emp.OrganizationLevel
INTO HumanResources.EmployeeDemo   
FROM HumanResources.Employee emp ;
GO

SELECT 
	CONCAT(personM.LastName, ' ', LEFT(personM.FirstName, 1), '.', LEFT(personM.MiddleName, 1), '.') AS 'Имя руководителя',
    Mgr.HireDate AS 'Дата приема руководителя на работу', 
	Mgr.BirthDate AS 'Дата рождения руководителя',
	CONCAT(personE.LastName, ' ', LEFT(personE.FirstName, 1), '.', LEFT(personE.MiddleName, 1), '.') AS 'Имя сотрудника',
    Emp.HireDate AS 'Дата приема сотрудника на работу', 
	Emp.BirthDate AS 'Дата рождения сотрудника'
FROM HumanResources.EmployeeDemo AS Emp  
LEFT JOIN HumanResources.EmployeeDemo AS Mgr ON Emp.ManagerID = Mgr.EmployeeID 
LEFT JOIN Person.Person personM ON  Mgr.EmployeeID = personM.BusinessEntityID
LEFT JOIN Person.Person personE ON  Emp.EmployeeID = personE.BusinessEntityID 
WHERE
    Mgr.BirthDate > Emp.BirthDate AND
    Mgr.HireDate > Emp.HireDate
		
ORDER BY emp.OrganizationLevel, personM.LastName,personE.LastName  


