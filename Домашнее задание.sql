
-- Нужно ускорить запросы ниже любыми способами
-- Можно менять текст самого запроса или добавилять новые индексы
-- Схему БД менять нельзя
-- В овете пришлите итоговый запрос и все что было создано для его ускорения

-- Задача 1
CREATE INDEX IX_WebLog_SessionStart_ServerID ON Marketing.WebLog (SessionStart, ServerID)

DECLARE @StartTime datetime2 = '2010-08-30 16:27';

SELECT TOP(5000) wl.SessionID, wl.ServerID, wl.UserName 
FROM Marketing.WebLog AS wl
WHERE wl.SessionStart >= @StartTime
ORDER BY wl.SessionStart, wl.ServerID;
GO

-- Задача 2
CREATE INDEX IX_StateCode_PostalCode ON Marketing.PostalCode(StateCode, PostalCode);

SELECT PostalCode, Country
FROM Marketing.PostalCode 
WHERE StateCode = 'KY'
ORDER BY StateCode, PostalCode;
GO

-- Задача 3
CREATE INDEX IX_LastName_FirstName ON Marketing.Prospect(LastName,FirstName)
CREATE INDEX IX_LastName_FirstName_SP ON Marketing.Salesperson(LastName)

DECLARE @Counter INT = 0;
WHILE @Counter < 350
BEGIN
  SELECT p.LastName, p.FirstName 
  FROM Marketing.Prospect AS p
  INNER JOIN Marketing.Salesperson AS sp
  ON p.LastName = sp.LastName
  ORDER BY p.LastName, p.FirstName;
  
  SELECT * 
  FROM Marketing.Prospect AS p
  WHERE p.LastName = 'Smith';
  SET @Counter += 1;

END;


-- Задача 4
CREATE INDEX IX_ProductModelIDPM ON Marketing.ProductModel(ProductModelID)
CREATE INDEX IX_ProductModelID_SubID ON Marketing.Product(ProductModelID,SubcategoryID)
CREATE INDEX IX_SubcategoryID ON Marketing.Subcategory(SubcategoryID)
CREATE INDEX IX_CategoryID  ON Marketing.Category(CategoryID)

SELECT
	c.CategoryName,
	sc.SubcategoryName,
	pm.ProductModel,
	COUNT(p.ProductID) AS ModelCount
FROM Marketing.ProductModel pm
	JOIN Marketing.Product p
		ON p.ProductModelID = pm.ProductModelID
	JOIN Marketing.Subcategory sc
		ON sc.SubcategoryID = p.SubcategoryID
	JOIN Marketing.Category c
		ON c.CategoryID = sc.CategoryID
GROUP BY c.CategoryName,
	sc.SubcategoryName,
	pm.ProductModel
HAVING COUNT(p.ProductID) > 1

