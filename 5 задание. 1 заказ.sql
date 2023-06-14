USE AdventureWorks2019

SELECT 
    oh.OrderDate AS '���� ������',
	person.LastName AS '������� ����������',
    person.FirstName AS '������� ����������',
    STRING_AGG(CONCAT(p.Name, N' ����������: ', CAST(od.OrderQty AS VARCHAR(10)), N' ��.'), CHAR(13) + CHAR(10)) WITHIN GROUP (ORDER BY oh.OrderDate) AS '���������� ������'
FROM 
    Sales.SalesOrderHeader oh
    JOIN Sales.Customer c ON oh.CustomerID = c.CustomerID
    JOIN Sales.SalesOrderDetail od ON oh.SalesOrderID = od.SalesOrderID
    JOIN Production.Product p ON od.ProductID = p.ProductID
	JOIN Person.Person person On c.PersonID = person.BusinessEntityID
WHERE oh.OrderDate = (
  SELECT MIN(OrderDate) 
  FROM Sales.SalesOrderHeader
  WHERE CustomerID = c.CustomerID
)
GROUP BY 
    oh.OrderDate, person.LastName,person.FirstName
ORDER BY 
    oh.OrderDate DESC;