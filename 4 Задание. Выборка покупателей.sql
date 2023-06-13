USE AdventureWorks2019

SELECT person.LastName,person.FirstName, prod.Name, SUM(s.OrderQty) AS Quantity
FROM Sales.SalesOrderDetail s
LEFT JOIN Sales.SalesOrderHeader o ON s.SalesOrderID = o.SalesOrderID
LEFT JOIN Production.Product prod ON s.ProductID = prod.ProductID
LEFT JOIN Sales.Customer c ON o.CustomerID = c.CustomerID
LEFT JOIN Person.Person person ON c.PersonID = person.BusinessEntityID
WHERE  c.PersonID IS NOT NULL 
GROUP BY person.LastName,person.FirstName,  prod.Name
HAVING SUM(s.OrderQty) > 15
ORDER BY Quantity DESC,  person.LastName ASC, person.FirstName ASC;