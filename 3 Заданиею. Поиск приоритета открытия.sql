USE AdventureWorks2019

Select TOP (10)  withoutSt.City, row_number() over(ORDER BY cityCount.countPeson Desc) as OpeningPriority 
from(

--Поиск городов без магазинов
SELECT adre.City
from Person.Address as adre
Group by  adre.City

EXCEPT

SELECT cityID.City
FROM Sales.Store as st
LEFT JOIN (
SELECT adres.City,business.BusinessEntityID
FROM Person.Address as adres
Left Join Person.BusinessEntityAddress as business on adres.AddressID = business.AddressID ) as cityID ON cityID.BusinessEntityID = st.BusinessEntityID
GROUP BY cityID.City
) as withoutSt

Left Join (
-- Подсчёт покупателей в каждом городе 
SELECT  CityId.City as city, COUNT(pr.BusinessEntityID) as countPeson
from Person.Person as pr
Left Join (
SELECT adres.City,business.BusinessEntityID
FROM Person.Address as adres
Left Join Person.BusinessEntityAddress as business on adres.AddressID = business.AddressID) as CityId On CityId.BusinessEntityID = pr.BusinessEntityID 
WHERE CityId.City IS NOT NULL 
GROUP BY CityId.City


) as cityCount on cityCount.city = withoutSt.City

ORDER BY cityCount.countPeson DESC



