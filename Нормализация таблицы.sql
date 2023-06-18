
CREATE TABLE Buyer (
  BuyerId INT PRIMARY KEY IDENTITY(1,1),
  FirstName NVARCHAR(50),
  MiddleName NVARCHAR(50),
  LastName NVARCHAR(50),
  Gender CHAR(1)

);


CREATE TABLE Product (
  ProductId INT PRIMARY KEY IDENTITY(1,1),
  NameProduct NVARCHAR(50)
);


CREATE TABLE OrderHeader (
    OrderHeaderID INT IDENTITY(1, 1) PRIMARY KEY,
    BuyerId INT,
    DateBuyer DATE,
    City NVARCHAR(50),
    Adress NVARCHAR(100),
    FOREIGN KEY (BuyerId) REFERENCES Buyer(BuyerId)
);

CREATE TABLE OrderDetail (
    OrderDetailID INT IDENTITY(1, 1) PRIMARY KEY,
    OrderHeaderID INT ,
    ProductId INT ,
    Quantity INT ,
    Price DECIMAL(18,2)
    Total AS Price * Quantity, 
    FOREIGN KEY (OrderHeaderID) REFERENCES OrderHeader(OrderHeaderID),
    FOREIGN KEY (ProductId) REFERENCES Product(ProductId)
);

INSERT INTO Buyer (FirstName, MiddleName,LastName, Gender)
VALUES ('Петр',NULL,'Романов', 'М' ),
       ('Софи́я́', N'Авгу́ста Фредери́ка', 'А́нгальт-Це́рбстская', 'Ж'),
       ('Александр', 'Рюрикович', NULL, 'М');

INSERT INTO Product (NameProduct)
VALUES ('Рама оконная'),
       ('Платье бальное'),
       ('Грудки куриные'),
	   ('Cалат'),
       ('Топор'),
       ('Пила'),
       ('Доски'),
       ('Брус'),
       ('Парусина');

INSERT INTO OrderHeader (BuyerId, DateBuyer, City, Adress)
VALUES (1, '1703-05-27', 'СПб', 'Сенатская площадь д.1'),
       (2, '1762-06-28', 'СПб', 'площадь Островского д.1'),
       (3, '1242-04-05', 'СПб', 'пл. Александра Невского д.1'),
       (1, '1704-11-05', 'СПб', 'Сенатская площадь д.1');

INSERT INTO OrderDetail (OrderHeaderID, ProductId, Quantity, Price)
INSERT INTO OrderDetail (OrderHeaderID, ProductId, Quantity, Price)
VALUES (1, 1, '1', 3875),
       (2, 2, '999', 15000),
       (3, 3, '5', 180),
	   (3, 4, '5', 52),
       (1, 5, '1', 500),
       (1, 6, '1', 450),
       (1, 7, '200', 4890),
       (1, 8, '20', 9390),
       (1, 9, '100', 182);



