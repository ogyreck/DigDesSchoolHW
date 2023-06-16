-- Создание таблицы "Покупатель"
CREATE TABLE Buyer (
  BuyerId INT PRIMARY KEY IDENTITY(1,1),
  FirstName NVARCHAR(50),
  MiddleName NVARCHAR(50),
  LastName NVARCHAR(50),
  Gender CHAR(1),
  Adress NVARCHAR(100)
);

-- Создание таблицы "Товар"
CREATE TABLE Product (
  ProductId INT PRIMARY KEY IDENTITY(1,1),
  NameProduct NVARCHAR(50),
  Price DECIMAL(18,2)
);

-- Создание таблицы "Покупка"
CREATE TABLE Purchase (
  PurchaseId INT PRIMARY KEY IDENTITY(1,1),
  idBuyer INT,
  idProduct INT,
  DatePurchase DATE,
  Quantity INT,
  FOREIGN KEY (idBuyer) REFERENCES Buyer(BuyerId),
  FOREIGN KEY (idProduct) REFERENCES Product(ProductId)
);

-- Добавление данных в таблицу "Покупатель"
INSERT INTO Buyer (FirstName, MiddleName,LastName, Gender, Adress)
VALUES ('Петр',NULL,'Романов', 'М', 'СПб, Сенатская площадь д.1'),
       ('Софи́я́', N'Авгу́ста Фредери́ка', 'А́нгальт-Це́рбстская', 'Ж', 'СПб, площадь Островского д.1'),
       ('Александр', 'Рюрикович', NULL, 'М', 'СПб, пл. Александра Невского д.1');
       

-- Добавление данных в таблицу "Товар"
INSERT INTO Product(NameProduct, Price)
VALUES ('Рама оконная', 3875),
       ('Платье бальное', 15000),
       ('Грудки куриные', 180),
       ('Салат', 52),
       ('Топор', 500),
       ('Пила', 450),
       ('Доски', 4890),
       ('Брус', 9390),
       ('Парусина', 182);

-- Добавление данных в таблицу "Покупка"
INSERT INTO Purchase (idBuyer, idProduct,DatePurchase, Quantity)
VALUES (1, 1,'1703-05-27', 1),
       (2, 2,'1762-06-28', 999),
       (3, 3,'1242-04-05', 5),
       (3, 4,'1242-04-05', 5),
       (1, 5,'1704-11-05', 1),
       (1, 6,'1704-11-05', 1),
       (1, 7,'1704-11-05', 200),
       (1, 8,'1704-11-05', 20),
       (1, 9,'1704-11-05', 100);