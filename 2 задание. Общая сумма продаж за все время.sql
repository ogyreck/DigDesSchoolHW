USE AdventureWorks2019

SELECT YEAR(sHeader.OrderDate)Years,MONTH(sHeader.OrderDate) Months,SUM(LineTotal) Total_amount 
FROM Sales.SalesOrderDetail sDetail
	LEFT JOIN  Sales.SalesOrderHeader as sHeader  ON sDetail.SalesOrderID = sHeader.SalesOrderID
GROUP BY YEAR(sHeader.OrderDate),MONTH(sHeader.OrderDate)
ORDER BY YEAR(sHeader.OrderDate),MONTH(sHeader.OrderDate)
