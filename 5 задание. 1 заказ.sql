USE AdventureWorks2019


SELECT 
    MIN(SOH.OrderDate) AS 'Дата заказа',
    person.LastName AS 'Фамилия покупателя',
    person.FirstName AS 'Имя покупателя',
    STUFF((
        SELECT 
            CONCAT('- ', P.Name, ' Quantity: ', CAST(SOD.OrderQty AS varchar(10)), ' pc.', CHAR(10))
        FROM 
            Sales.SalesOrderDetail SOD
        INNER JOIN 
            Production.Product P ON P.ProductID = SOD.ProductID
        WHERE 
            SOH.SalesOrderID = SOD.SalesOrderID
        ORDER BY 
            P.Name
        FOR XML PATH('')), 1, 1, '') AS 'Содержимое заказа'
FROM 
    Sales.Customer C
JOIN 
    Sales.SalesOrderHeader SOH ON C.CustomerID = SOH.CustomerID
Left JOIN Person.Person person On c.PersonID = person.BusinessEntityID
GROUP BY 
    person.LastName,
    person.FirstName,
	SalesOrderID
ORDER BY 
    MIN(SOH.OrderDate) DESC