CREATE DATABASE Store
USE Store

CREATE TABLE Categories (
	categoryId int PRIMARY KEY IDENTITY,
	categoryName nvarchar(100) NOT NULL UNIQUE
);

CREATE TABLE Products (
	productId int PRIMARY KEY IDENTITY,
	productCode int NOT NULL UNIQUE,
	categoryID int foreign key references Categories(categoryId)
);

CREATE TABLE Stock (
	stockId int PRIMARY KEY IDENTITY,
	productID int foreign key references Products(productId),
	createdDate datetime2 DEFAULT GETDATE(),
	stockCount int NOT NULL 

);

ALTER TABLE Stock
ADD size int 

CREATE TABLE Sizes (
	sizeId int PRIMARY KEY IDENTITY,
	sizeLetter nvarchar(4) NOT NULL,
	min int,
	max int,
);

INSERT INTO Categories
VALUES ('T-Shirt') , ('Jeans') , ('Shoes') , ('Jacket') 

INSERT INTO Products
VALUES ( 123456 , 1 )  , ( 261519 , 2 )  , ( 798632 , 3 )  ,( 852364 , 4 )  

INSERT INTO Stock (productId , stockCount , size)
VALUES (1 , 465 , 120 ) , (2 , 327 , 130) ,(3 , 852 , 105 ) ,(4 , 621 , 108) 

INSERT INTO Sizes 
VALUES ('xs' , 100 , 110 ) , ('s' , 111 , 120 ) ,('m' , 121 , 130 ) ,('xl' , 131 , 140 ) 

CREATE VIEW productInfo
AS
SELECT p.productCode , c.categoryName , s.createdDate , s.stockCount , s.size FROM STOCK s
INNER JOIN Products p 
ON p.productId = s.productID 
INNER JOIN Categories c
ON c.categoryId = p.productId

SELECT * FROM productInfo

CREATE TRIGGER prodInsert
on Products
AFTER INSERT 
AS
BEGIN
	SELECT * FROM Products
END

CREATE FUNCTION findCount (@cat nvarchar(100) )
RETURNS INT
BEGIN 
	
	RETURN: SELECT COUNT(s.stockCount) FROM STOCK s
	INNER JOIN Products p 
	ON p.productId = s.productID 
	INNER JOIN Categories c
	ON c.categoryId = p.productId
	WHERE c.categoryName = @cat
END

