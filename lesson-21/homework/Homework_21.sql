--MERGE Practice
CREATE TABLE Employees (
EmployeeID INT PRIMARY KEY,
EmployeeName VARCHAR(50),
Salary DECIMAL(10, 2),
DepartmentID INT
);

INSERT INTO Employees (EmployeeID, EmployeeName, Salary, DepartmentID) VALUES
(1, 'John Doe', 60000.00, 10),
(2, 'Jane Smith', 75000.00, 20),
(3, 'Alice Brown', 50000.00, 10);

CREATE TABLE NewEmployees (
EmployeeID INT PRIMARY KEY,
EmployeeName VARCHAR(50),
Salary DECIMAL(10, 2),
DepartmentID INT
);

INSERT INTO NewEmployees (EmployeeID, EmployeeName, Salary, DepartmentID) VALUES
(1, 'John Doe', 65000.00, 10),
(4, 'Bob Johnson', 80000.00, 30);

CREATE TABLE OldProducts (
ProductID INT PRIMARY KEY,
ProductName VARCHAR(50),
Price DECIMAL(10, 2)
);

INSERT INTO OldProducts (ProductID, ProductName, Price) VALUES
(101, 'Laptop', 1200.00),
(102, 'Shirt', 30.00),
(103, 'Sofa', 800.00);

CREATE TABLE CurrentProducts (
ProductID INT PRIMARY KEY,
ProductName VARCHAR(50),
Price DECIMAL(10, 2)
);

INSERT INTO CurrentProducts (ProductID, ProductName, Price) VALUES
(101, 'Laptop', 1200.00),
(104, 'Headphones', 150.00);

CREATE TABLE NewSalaryDetails (
EmployeeID INT PRIMARY KEY,
Salary DECIMAL(10, 2)
);

INSERT INTO NewSalaryDetails (EmployeeID, Salary) VALUES
(1, 70000.00),
(2, 70000.00),
(5, 55000.00);

CREATE TABLE Orders (
OrderID INT PRIMARY KEY,
CustomerID INT,
OrderAmount DECIMAL(10, 2)
);

INSERT INTO Orders (OrderID, CustomerID, OrderAmount) VALUES
(1, 201, 500.00),
(2, 202, 750.25),
(3, 201, 300.50);

CREATE TABLE NewOrders (
OrderID INT PRIMARY KEY,
CustomerID INT,
OrderAmount DECIMAL(10, 2)
);

INSERT INTO NewOrders (OrderID, CustomerID, OrderAmount) VALUES
(1, 201, 600.00),
(4, 203, 900.75);

CREATE TABLE StudentRecords (
StudentID INT PRIMARY KEY,
StudentName VARCHAR(50),
Age INT,
Grade INT
);

INSERT INTO StudentRecords (StudentID, StudentName, Age, Grade) VALUES
(1, 'Alice', 17, 85),
(2, 'Bob', 18, 90);

CREATE TABLE NewStudentRecords (
StudentID INT PRIMARY KEY,
StudentName VARCHAR(50),
Age INT,
Grade INT
);

INSERT INTO NewStudentRecords (StudentID, StudentName, Age, Grade) VALUES
(1, 'Alice', 17, 88),
(3, 'Charlie', 19, 92);

CREATE TABLE MergeLog (
LogID INT IDENTITY(1,1) PRIMARY KEY,
ActionType VARCHAR(50),
StudentID INT,
ActionDate DATETIME
);

--1 solution
MERGE INTO Employees AS target
USING NewEmployees AS source
ON target.EmployeeID = source.EmployeeID
WHEN MATCHED THEN
UPDATE SET target.EmployeeName = source.EmployeeName,
target.Salary = source.Salary,
target.DepartmentID = source.DepartmentID
WHEN NOT MATCHED BY TARGET THEN
INSERT (EmployeeID, EmployeeName, Salary, DepartmentID)
VALUES (source.EmployeeID, source.EmployeeName, source.Salary, source.DepartmentID);

--2 solution
MERGE INTO OldProducts AS target
USING CurrentProducts AS source
ON target.ProductID = source.ProductID
WHEN NOT MATCHED BY SOURCE THEN
DELETE;

--3 solution
MERGE INTO Employees AS target
USING NewSalaryDetails AS source
ON target.EmployeeID = source.EmployeeID
WHEN MATCHED AND source.Salary > target.Salary THEN
UPDATE SET target.Salary = source.Salary;

--4 solution
MERGE INTO Orders AS target
USING NewOrders AS source
ON target.OrderID = source.OrderID
WHEN MATCHED AND target.CustomerID = source.CustomerID AND source.OrderAmount > target.OrderAmount THEN
UPDATE SET target.OrderAmount = source.OrderAmount
WHEN NOT MATCHED BY TARGET THEN
INSERT (OrderID, CustomerID, OrderAmount)
VALUES (source.OrderID, source.CustomerID, source.OrderAmount);

--5 solution
MERGE INTO StudentRecords AS target
USING NewStudentRecords AS source
ON target.StudentID = source.StudentID
WHEN MATCHED AND source.Age > 18 THEN
UPDATE SET target.StudentName = source.StudentName,
target.Age = source.Age,
target.Grade = source.Grade
OUTPUT 'UPDATE', deleted.StudentID, GETDATE() INTO MergeLog (ActionType, StudentID, ActionDate)
WHEN NOT MATCHED BY TARGET AND source.Age > 18 THEN
INSERT (StudentID, StudentName, Age, Grade)
VALUES (source.StudentID, source.StudentName, source.Age, source.Grade)
OUTPUT 'INSERT', inserted.StudentID, GETDATE() INTO MergeLog (ActionType, StudentID, ActionDate);


--View and Function Practice
CREATE TABLE Sales (
SaleID INT PRIMARY KEY,
CustomerID INT,
SaleDate DATE,
SalesAmount DECIMAL(10, 2)
);

INSERT INTO Sales (SaleID, CustomerID, SaleDate, SalesAmount) VALUES
(1, 201, '2024-01-15', 150.50),
(2, 202, '2024-02-10', 200.75),
(3, 201, '2024-03-05', 300.00),
(4, 203, '2024-04-20', 450.25);

CREATE TABLE Orders (
OrderID INT PRIMARY KEY,
CustomerID INT,
OrderDate DATE,
OrderAmount DECIMAL(10, 2)
);

INSERT INTO Orders (OrderID, CustomerID, OrderDate, OrderAmount) VALUES
(1, 201, '2024-01-20', 500.00),
(2, 202, '2024-02-15', 750.25),
(3, 201, '2024-03-10', 300.50),
(4, 203, '2024-04-05', 900.75);

CREATE TABLE Employees (
EmployeeID INT PRIMARY KEY,
FirstName VARCHAR(50),
LastName VARCHAR(50),
DepartmentID INT
);

INSERT INTO Employees (EmployeeID, FirstName, LastName, DepartmentID) VALUES
(1, 'John', 'Doe', 10),
(2, 'Jane', 'Smith', 20),
(3, 'Alice', 'Brown', 10);

CREATE TABLE Departments (
DepartmentID INT PRIMARY KEY,
DepartmentName VARCHAR(50)
);

INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(10, 'IT'),
(20, 'HR');

CREATE TABLE Products (
ProductID INT PRIMARY KEY,
ProductName VARCHAR(50),
StockQuantity INT
);

INSERT INTO Products (ProductID, ProductName, StockQuantity) VALUES
(101, 'Laptop', 50),
(102, 'Shirt', 200),
(103, 'Sofa', 20);

Solutions
--1 solution
CREATE VIEW SalesSummary AS
SELECT s.CustomerID,
SUM(s.SalesAmount) AS TotalSalesAmount,
COUNT(o.OrderID) AS NumberOfOrders
FROM Sales s
LEFT JOIN Orders o ON s.CustomerID = o.CustomerID
GROUP BY s.CustomerID;

--2 solution
CREATE VIEW EmployeeDepartmentDetails AS
SELECT e.EmployeeID,
e.FirstName,
e.LastName,
e.DepartmentID,
d.DepartmentName
FROM Employees e
LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID;

--3 solution
CREATE VIEW InventoryStatus AS
SELECT ProductID,
ProductName,
StockQuantity,
CASE
WHEN StockQuantity > 100 THEN 'In Stock'
WHEN StockQuantity > 0 THEN 'Low Stock'
ELSE 'Out of Stock'
END AS Availability
FROM Products;

--4 solution
CREATE FUNCTION fn_GetFullName (@FirstName VARCHAR(50), @LastName VARCHAR(50))
RETURNS VARCHAR(100)
AS
BEGIN
RETURN @FirstName + ' ' + @LastName;
END;

--5 solution
CREATE FUNCTION fn_GetHighSales (@Threshold DECIMAL(10, 2))
RETURNS TABLE
AS
RETURN (
SELECT SaleID,
CustomerID,
SaleDate,
SalesAmount
FROM Sales
WHERE SalesAmount > @Threshold
);

--6 solution
CREATE FUNCTION fn_GetCustomerStats ()
RETURNS @CustomerStats TABLE (
CustomerID INT,
TotalSales DECIMAL(10, 2),
TotalOrders INT,
AvgSaleAmount DECIMAL(10, 2)
)
AS
BEGIN
INSERT INTO @CustomerStats (CustomerID, TotalSales, TotalOrders, AvgSaleAmount)
SELECT s.CustomerID,
SUM(s.SalesAmount) AS TotalSales,
COUNT(o.OrderID) AS TotalOrders,
AVG(s.SalesAmount) AS AvgSaleAmount
FROM Sales s
LEFT JOIN Orders o ON s.CustomerID = o.CustomerID
GROUP BY s.CustomerID;
RETURN;
END;


CREATE TABLE Sales (
SaleID INT PRIMARY KEY,
ProductID INT,
SaleDate DATE,
SalesAmount DECIMAL(10, 2),
ProductCategory VARCHAR(50)
);

INSERT INTO Sales (SaleID, ProductID, SaleDate, SalesAmount, ProductCategory) VALUES
(1, 101, '2024-01-15', 150.50, 'Electronics'),
(2, 102, '2024-02-10', 200.75, 'Clothing'),
(3, 101, '2024-03-05', 300.00, 'Electronics'),
(4, 103, '2024-04-20', 450.25, 'Furniture');

CREATE TABLE Employees (
EmployeeID INT PRIMARY KEY,
EmployeeName VARCHAR(50),
Salary DECIMAL(10, 2),
DepartmentID INT
);

INSERT INTO Employees (EmployeeID, EmployeeName, Salary, DepartmentID) VALUES
(1, 'John Doe', 60000.00, 10),
(2, 'Jane Smith', 75000.00, 20),
(3, 'Alice Brown', 50000.00, 10);

CREATE TABLE Students (
StudentID INT PRIMARY KEY,
StudentName VARCHAR(50),
TestScore INT
);

INSERT INTO Students (StudentID, StudentName, TestScore) VALUES
(1, 'Alice', 85),
(2, 'Bob', 85),
(3, 'Charlie', 90),
(4, 'David', 75);

CREATE TABLE StockPrices (
StockID INT PRIMARY KEY,
StockDate DATE,
Price DECIMAL(10, 2)
);

INSERT INTO StockPrices (StockID, StockDate, Price) VALUES
(1, '2024-01-01', 100.00),
(2, '2024-01-02', 105.50),
(3, '2024-01-03', 102.75),
(4, '2024-01-04', 110.00);

CREATE TABLE Customers (
CustomerID INT PRIMARY KEY,
TotalSpending DECIMAL(10, 2)
);

INSERT INTO Customers (CustomerID, TotalSpending) VALUES
(201, 1500.50),
(202, 2000.75),
(203, 3000.00),
(204, 4500.25),
(205, 1000.00);

--1
-- Explanation: Window functions are more efficient than 
--subqueries or temporary tables for calculating cumulative 
--sales because they process the data in a single pass, 
--avoiding the need for multiple table scans or intermediate storage. 
--Subqueries often require nested operations that can be 
--computationally expensive, and temporary tables involve additional I/O operations 
--for writing and reading data. Window functions, on the other hand, 
--leverage the database engine's ability to perform calculations over 
--a set of rows efficiently, maintaining sort order and partitioning without redundant data access.

	
--2 solution
SELECT SaleID, ProductID, SaleDate, SalesAmount,
SUM(SalesAmount) OVER (ORDER BY SaleDate) AS CumulativeSales
FROM Sales;

SELECT EmployeeID, EmployeeName, Salary, DepartmentID,
AVG(Salary) OVER (PARTITION BY DepartmentID) AS AvgSalaryWindow
FROM Employees;

SELECT DepartmentID,
AVG(Salary) AS AvgSalaryGroupBy
FROM Employees
GROUP BY DepartmentID;

--3 solution
SELECT SaleID, ProductID, SaleDate, SalesAmount, ProductCategory,
SUM(SalesAmount) OVER (PARTITION BY ProductCategory ORDER BY SaleDate) AS CumulativeRevenue
FROM Sales;

SELECT ProductCategory,
SUM(SalesAmount) AS TotalRevenue
FROM Sales
GROUP BY ProductCategory;

--4 solution
SELECT StudentID, StudentName, TestScore,
ROW_NUMBER() OVER (ORDER BY TestScore DESC) AS RowNumRank
FROM Students;

SELECT StudentID, StudentName, TestScore,
RANK() OVER (ORDER BY TestScore DESC) AS RankValue
FROM Students;

SELECT StudentID, StudentName, TestScore,
DENSE_RANK() OVER (ORDER BY TestScore DESC) AS DenseRankValue
FROM Students;

--5 solution
SELECT StockID, StockDate, Price,
LAG(Price) OVER (ORDER BY StockDate) AS PrevPrice,
Price - LAG(Price) OVER (ORDER BY StockDate) AS PriceChangePrev
FROM StockPrices;

SELECT StockID, StockDate, Price,
LEAD(Price) OVER (ORDER BY StockDate) AS NextPrice,
LEAD(Price) OVER (ORDER BY StockDate) - Price AS PriceChangeNext
FROM StockPrices;

--6 solution
SELECT CustomerID, TotalSpending,
NTILE(4) OVER (ORDER BY TotalSpending) AS Quartile
FROM Customers;

SELECT CustomerID, TotalSpending,
NTILE(5) OVER (ORDER BY TotalSpending) AS Quintile
FROM Customers;