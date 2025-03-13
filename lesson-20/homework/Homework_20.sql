EASY:
CREATE TABLE Sales (
SaleID INT,
ProductID INT,
SaleDate DATE,
SalesAmount DECIMAL(10, 2),
SalespersonID INT,
ProductCategory VARCHAR(50),
StoreID INT
);

INSERT INTO Sales (SaleID, ProductID, SaleDate, SalesAmount, SalespersonID, ProductCategory, StoreID) VALUES
(1, 101, '2024-01-15', 150.50, 1, 'Electronics', 1),
(2, 102, '2024-02-10', 200.75, 2, 'Clothing', 2),
(3, 101, '2024-03-05', 300.00, 1, 'Electronics', 1),
(4, 103, '2024-04-20', 450.25, 3, 'Furniture', 3),
(5, 102, '2024-05-15', 120.00, 2, 'Clothing', 2);

CREATE TABLE Orders (
OrderID INT,
CustomerID INT,
OrderDate DATE,
OrderAmount DECIMAL(10, 2)
);

INSERT INTO Orders (OrderID, CustomerID, OrderDate, OrderAmount) VALUES
(1, 201, '2024-01-20', 500.00),
(2, 202, '2024-02-15', 750.25),
(3, 201, '2024-03-10', 300.50),
(4, 203, '2024-04-05', 900.75),
(5, 202, '2024-05-01', 250.00);

CREATE TABLE Products (
ProductID INT,
ProductName VARCHAR(50),
Price DECIMAL(10, 2),
StockQuantity INT
);

INSERT INTO Products (ProductID, ProductName, Price, StockQuantity) VALUES
(101, 'Laptop', 1200.00, 50),
(102, 'Shirt', 30.00, 200),
(103, 'Sofa', 800.00, 20),
(104, 'Headphones', 150.00, 100),
(105, 'Table', 400.00, 30);

CREATE TABLE Employees (
EmployeeID INT,
EmployeeName VARCHAR(50),
Salary DECIMAL(10, 2)
);

INSERT INTO Employees (EmployeeID, EmployeeName, Salary) VALUES
(1, 'John Doe', 60000.00),
(2, 'Jane Smith', 75000.00),
(3, 'Alice Brown', 50000.00),
(4, 'Bob Johnson', 80000.00),
(5, 'Emma Davis', 65000.00);


1. SELECT SaleID, ProductID, SaleDate, SalesAmount, SUM(SalesAmount) OVER (ORDER BY SaleDate) AS RunningTotal FROM Sales;
2. SELECT OrderID, CustomerID, OrderDate, OrderAmount, SUM(OrderAmount) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS CumulativeSum FROM Orders;
3. SELECT OrderID, CustomerID, OrderDate, OrderAmount, SUM(OrderAmount) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS RunningTotal FROM Orders;
4. SELECT SaleID, ProductID, SaleDate, SalesAmount, AVG(SalesAmount) OVER (PARTITION BY ProductID ORDER BY SaleDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS AvgSales FROM Sales;
5. SELECT OrderID, CustomerID, OrderDate, OrderAmount, RANK() OVER (ORDER BY OrderAmount) AS OrderRank FROM Orders;
6. SELECT SaleID, ProductID, SaleDate, SalesAmount, LEAD(SalesAmount) OVER (PARTITION BY ProductID ORDER BY SaleDate) AS NextAmount FROM Sales;
7. SELECT OrderID, CustomerID, OrderDate, OrderAmount, SUM(OrderAmount) OVER () AS TotalSales FROM Orders;
8. SELECT OrderID, CustomerID, OrderDate, OrderAmount, COUNT(*) OVER (ORDER BY OrderDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS OrderCount FROM Orders;
9. SELECT SaleID, ProductID, SaleDate, SalesAmount, ProductCategory, SUM(SalesAmount) OVER (PARTITION BY ProductCategory ORDER BY SaleDate) AS CategoryRunningTotal FROM Sales;
10. SELECT OrderID, CustomerID, OrderDate, OrderAmount, ROW_NUMBER() OVER (ORDER BY OrderDate) AS RowNum FROM Orders;
11. SELECT OrderID, CustomerID, OrderDate, OrderAmount, LAG(OrderAmount) OVER (ORDER BY OrderDate) AS PrevOrderAmount FROM Orders;
12. SELECT ProductID, ProductName, Price, NTILE(4) OVER (ORDER BY Price) AS PriceQuartile FROM Products;
13. SELECT SaleID, ProductID, SalespersonID, SalesAmount, SUM(SalesAmount) OVER (PARTITION BY SalespersonID) AS TotalSalesPerPerson FROM Sales;
14. SELECT ProductID, ProductName, StockQuantity, DENSE_RANK() OVER (ORDER BY StockQuantity DESC) AS StockRank FROM Products;
15. SELECT OrderID, CustomerID, OrderDate, OrderAmount, OrderAmount - LEAD(OrderAmount) OVER (ORDER BY OrderDate) AS AmountDifference FROM Orders;
16. SELECT ProductID, ProductName, Price, RANK() OVER (ORDER BY Price DESC) AS PriceRank FROM Products;
17. SELECT OrderID, CustomerID, OrderDate, OrderAmount, AVG(OrderAmount) OVER (PARTITION BY CustomerID) AS AvgOrderAmount FROM Orders;
18. SELECT EmployeeID, EmployeeName, Salary, ROW_NUMBER() OVER (ORDER BY Salary DESC) AS RowNum FROM Employees;
19. SELECT SaleID, ProductID, StoreID, SalesAmount, SUM(SalesAmount) OVER (PARTITION BY StoreID ORDER BY SaleDate) AS StoreRunningTotal FROM Sales;
20. SELECT OrderID, CustomerID, OrderDate, OrderAmount, LAG(OrderAmount) OVER (ORDER BY OrderDate) AS PrevOrderAmount FROM Orders;


MEDIUM:
CREATE TABLE Sales (
SaleID INT,
ProductID INT,
SaleDate DATE,
SalesAmount DECIMAL(10, 2),
SalespersonID INT,
ProductCategory VARCHAR(50),
StoreID INT,
DepartmentID INT
);

INSERT INTO Sales (SaleID, ProductID, SaleDate, SalesAmount, SalespersonID, ProductCategory, StoreID, DepartmentID) VALUES
(1, 101, '2024-01-15', 150.50, 1, 'Electronics', 1, 10),
(2, 102, '2024-02-10', 200.75, 2, 'Clothing', 2, 20),
(3, 101, '2024-03-05', 300.00, 1, 'Electronics', 1, 10),
(4, 103, '2024-04-20', 450.25, 3, 'Furniture', 3, 30),
(5, 102, '2024-05-15', 120.00, 2, 'Clothing', 2, 20),
(6, 104, '2024-06-10', 250.00, 4, 'Electronics', 1, 10),
(7, 105, '2024-07-05', 600.00, 5, 'Furniture', 3, 30);

CREATE TABLE Orders (
OrderID INT,
CustomerID INT,
OrderDate DATE,
OrderAmount DECIMAL(10, 2)
);

INSERT INTO Orders (OrderID, CustomerID, OrderDate, OrderAmount) VALUES
(1, 201, '2024-01-20', 500.00),
(2, 202, '2024-02-15', 750.25),
(3, 201, '2024-03-10', 300.50),
(4, 203, '2024-04-05', 900.75),
(5, 202, '2024-05-01', 250.00);

CREATE TABLE Products (
ProductID INT,
ProductName VARCHAR(50),
Price DECIMAL(10, 2),
SalesAmount DECIMAL(10, 2)
);

INSERT INTO Products (ProductID, ProductName, Price, SalesAmount) VALUES
(101, 'Laptop', 1200.00, 1500.50),
(102, 'Shirt', 30.00, 320.75),
(103, 'Sofa', 800.00, 1050.25),
(104, 'Headphones', 150.00, 250.00),
(105, 'Table', 400.00, 600.00),
(106, 'Mouse', 25.00, 100.00),
(107, 'Chair', 200.00, 300.00);

CREATE TABLE Employees (
EmployeeID INT,
EmployeeName VARCHAR(50),
Salary DECIMAL(10, 2),
DepartmentID INT
);

INSERT INTO Employees (EmployeeID, EmployeeName, Salary, DepartmentID) VALUES
(1, 'John Doe', 60000.00, 10),
(2, 'Jane Smith', 75000.00, 20),
(3, 'Alice Brown', 50000.00, 10),
(4, 'Bob Johnson', 80000.00, 30),
(5, 'Emma Davis', 65000.00, 20),
(6, 'Mike Wilson', 70000.00, 30);


--1 solution
SELECT SaleID, SalespersonID, SalesAmount,
SUM(SalesAmount) OVER (PARTITION BY SalespersonID ORDER BY SaleDate) AS CumulativeSum
FROM Sales;

--2 solution
SELECT OrderID, CustomerID, OrderDate, OrderAmount,
OrderAmount - LEAD(OrderAmount) OVER (ORDER BY OrderDate) AS AmountDifference
FROM Orders;

--3 solution 
WITH RankedSales AS (
SELECT ProductID, SaleDate, SalesAmount,
ROW_NUMBER() OVER (ORDER BY SalesAmount DESC) AS RowNum
FROM Sales
)
SELECT ProductID, SaleDate, SalesAmount, RowNum
FROM RankedSales
WHERE RowNum <= 5;

--4 solution 
WITH RankedProducts AS (
SELECT ProductID, ProductName, SalesAmount,
RANK() OVER (ORDER BY SalesAmount DESC) AS SalesRank
FROM Products
)
SELECT ProductID, ProductName, SalesAmount, SalesRank
FROM RankedProducts
WHERE SalesRank <= 10;

--5 solution
SELECT ProductID, COUNT(*) AS OrderCount
FROM Sales
GROUP BY ProductID;

--6 solution
SELECT SaleID, ProductID, SaleDate, SalesAmount, ProductCategory,
SUM(SalesAmount) OVER (PARTITION BY ProductCategory ORDER BY SaleDate) AS RunningTotal
FROM Sales;

--7 solution
SELECT EmployeeID, EmployeeName, Salary, DepartmentID,
DENSE_RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS SalaryRank
FROM Employees;

--8 solution
SELECT SaleID, ProductID, SaleDate, SalesAmount,
AVG(SalesAmount) OVER (ORDER BY SaleDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingAverage
FROM Sales;

--9 solution
SELECT ProductID, ProductName, Price,
NTILE(3) OVER (ORDER BY Price) AS PriceGroup
FROM Products;

--10 solution
SELECT SaleID, SalespersonID, SaleDate, SalesAmount,
LAG(SalesAmount) OVER (PARTITION BY SalespersonID ORDER BY SaleDate) AS PrevSalesAmount
FROM Sales;

--11 solution
SELECT SaleID, SalespersonID, SaleDate, SalesAmount,
SUM(SalesAmount) OVER (PARTITION BY SalespersonID ORDER BY SaleDate) AS CumulativeSum
FROM Sales;

--12 solution
SELECT SaleID, ProductID, SaleDate, SalesAmount,
LEAD(SalesAmount) OVER (PARTITION BY ProductID ORDER BY SaleDate) AS NextSalesAmount
FROM Sales;

--13 solution
SELECT ProductID, SaleDate, SalesAmount,
SUM(SalesAmount) OVER (PARTITION BY ProductID ORDER BY SaleDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS MovingSum
FROM Sales;

--14 solution
SELECT EmployeeID, EmployeeName, Salary,
RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Employees
WHERE RANK() OVER (ORDER BY Salary DESC) <= 3;

--15 solution
SELECT OrderID, CustomerID, OrderDate, OrderAmount,
AVG(OrderAmount) OVER (PARTITION BY CustomerID) AS AvgOrderAmount
FROM Orders;

--16 solution
SELECT OrderID, CustomerID, OrderDate, OrderAmount,
ROW_NUMBER() OVER (ORDER BY OrderDate) AS RowNum
FROM Orders;

--17 solution
SELECT SaleID, SalespersonID, SalesAmount, DepartmentID,
SUM(SalesAmount) OVER (PARTITION BY DepartmentID ORDER BY SaleDate) AS RunningTotal
FROM Sales;

--18 solution
SELECT EmployeeID, EmployeeName, Salary,
NTILE(5) OVER (ORDER BY Salary) AS SalaryGroup
FROM Employees;

--19 solution
SELECT ProductID, SaleDate, SalesAmount,
SUM(SalesAmount) OVER (PARTITION BY ProductID ORDER BY SaleDate) AS CumulativeSum,
(SELECT SUM(SalesAmount) FROM Sales s2 WHERE s2.ProductID = s1.ProductID) AS TotalSales
FROM Sales s1;

--20 solution
SELECT ProductID, SaleDate, SalesAmount,
DENSE_RANK() OVER (ORDER BY SalesAmount DESC) AS SalesRank
FROM Sales
WHERE DENSE_RANK() OVER (ORDER BY SalesAmount DESC) <= 5;


DIFFICULT:
CREATE TABLE Sales (
SaleID INT,
ProductID INT,
SaleDate DATE,
SalesAmount DECIMAL(10, 2),
SalespersonID INT,
ProductCategory VARCHAR(50),
StoreID INT,
DepartmentID INT
);

INSERT INTO Sales (SaleID, ProductID, SaleDate, SalesAmount, SalespersonID, ProductCategory, StoreID, DepartmentID) VALUES
(1, 101, '2024-01-15', 150.50, 1, 'Electronics', 1, 10),
(2, 102, '2024-02-10', 200.75, 2, 'Clothing', 2, 20),
(3, 101, '2024-03-05', 300.00, 1, 'Electronics', 1, 10),
(4, 103, '2024-04-20', 450.25, 3, 'Furniture', 3, 30),
(5, 102, '2024-05-15', 120.00, 2, 'Clothing', 2, 20),
(6, 104, '2024-06-10', 250.00, 4, 'Electronics', 1, 10),
(7, 105, '2024-07-05', 600.00, 5, 'Furniture', 3, 30);

CREATE TABLE Orders (
OrderID INT,
CustomerID INT,
OrderDate DATE,
OrderAmount DECIMAL(10, 2)
);

INSERT INTO Orders (OrderID, CustomerID, OrderDate, OrderAmount) VALUES
(1, 201, '2024-01-20', 500.00),
(2, 202, '2024-02-15', 750.25),
(3, 201, '2024-03-10', 300.50),
(4, 203, '2024-04-05', 900.75),
(5, 202, '2024-05-01', 250.00),
(6, 204, '2024-06-15', 400.00),
(7, 205, '2024-07-20', 600.50),
(8, 201, '2024-08-10', 350.00),
(9, 202, '2024-09-05', 450.75),
(10, 203, '2024-10-01', 800.00);

CREATE TABLE Products (
ProductID INT,
ProductName VARCHAR(50),
Price DECIMAL(10, 2),
SalesAmount DECIMAL(10, 2)
);

INSERT INTO Products (ProductID, ProductName, Price, SalesAmount) VALUES
(101, 'Laptop', 1200.00, 450.50),
(102, 'Shirt', 30.00, 320.75),
(103, 'Sofa', 800.00, 1050.25),
(104, 'Headphones', 150.00, 250.00),
(105, 'Table', 400.00, 600.00),
(106, 'Mouse', 25.00, 100.00),
(107, 'Chair', 200.00, 300.00);

CREATE TABLE Employees (
EmployeeID INT,
EmployeeName VARCHAR(50),
Salary DECIMAL(10, 2),
DepartmentID INT
);

INSERT INTO Employees (EmployeeID, EmployeeName, Salary, DepartmentID) VALUES
(1, 'John Doe', 60000.00, 10),
(2, 'Jane Smith', 75000.00, 20),
(3, 'Alice Brown', 50000.00, 10),
(4, 'Bob Johnson', 80000.00, 30),
(5, 'Emma Davis', 65000.00, 20);


--1 solution
SELECT ProductID, StoreID, SaleDate, SalesAmount,
SUM(SalesAmount) OVER (PARTITION BY ProductID, StoreID ORDER BY SaleDate) AS RunningTotal
FROM Sales;

--2 solution
SELECT OrderID, CustomerID, OrderDate, OrderAmount,
((LEAD(OrderAmount) OVER (ORDER BY OrderDate) - OrderAmount) / OrderAmount * 100) AS PercentageChange
FROM Orders;

--3 solution
SELECT ProductID, SaleDate, SalesAmount
FROM (
SELECT ProductID, SaleDate, SalesAmount,
ROW_NUMBER() OVER (ORDER BY SalesAmount DESC) AS RowNum
FROM Sales
) AS RankedSales
WHERE RowNum <= 3;

--4 solution
SELECT EmployeeID, EmployeeName, Salary, DepartmentID,
RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS SalaryRank
FROM Employees;

--5 solution
SELECT OrderID, OrderAmount,
NTILE(10) OVER (ORDER BY OrderAmount DESC) AS OrderPercentile
FROM Orders;

--6 solution
SELECT SaleID, ProductID, SaleDate, SalesAmount,
LAG(SalesAmount) OVER (PARTITION BY ProductID ORDER BY SaleDate) AS PrevSalesAmount,
SalesAmount - LAG(SalesAmount) OVER (PARTITION BY ProductID ORDER BY SaleDate) AS Change
FROM Sales;

--7 solution
SELECT ProductID, SaleDate, SalesAmount,
AVG(SalesAmount) OVER (PARTITION BY ProductID ORDER BY SaleDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS CumulativeAvg
FROM Sales;

--8 solution
SELECT ProductID, ProductName, SalesAmount,
DENSE_RANK() OVER (ORDER BY SalesAmount DESC) AS SalesRank
FROM Products
WHERE DENSE_RANK() OVER (ORDER BY SalesAmount DESC) <= 5;

--9 solution
SELECT SaleID, SaleDate, SalesAmount, ProductCategory,
SUM(SalesAmount) OVER (PARTITION BY ProductCategory ORDER BY SaleDate) AS RunningTotal
FROM Sales;

--10 solution
SELECT OrderID, CustomerID, OrderDate, OrderAmount,
LEAD(OrderAmount) OVER (ORDER BY OrderDate) - LAG(OrderAmount) OVER (ORDER BY OrderDate) AS Difference
FROM Orders;

--11 solution
SELECT SaleID, SalespersonID, SaleDate, SalesAmount,
SUM(SalesAmount) OVER (PARTITION BY SalespersonID ORDER BY SaleDate) AS CumulativeTotal
FROM Sales;

--12 solution
SELECT ProductID, ProductName, Price,
NTILE(10) OVER (ORDER BY Price) AS PriceGroup
FROM Products;

--13 solution
SELECT OrderID, CustomerID, OrderDate, OrderAmount,
AVG(OrderAmount) OVER (ORDER BY OrderDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingAverage
FROM Orders;

--14 solution
SELECT EmployeeID, EmployeeName, Salary, DepartmentID,
ROW_NUMBER() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS RowNum
FROM Employees;

--15 solution
SELECT CustomerID, COUNT(*) AS OrderCount
FROM Orders
GROUP BY CustomerID;

--16 solution 
WITH SalesCount AS (
SELECT ProductID, COUNT(*) AS SalesCount
FROM Sales
GROUP BY ProductID
)
SELECT ProductID, SalesCount,
RANK() OVER (ORDER BY SalesCount DESC) AS SalesRank
FROM SalesCount
WHERE RANK() OVER (ORDER BY SalesCount DESC) <= 3;

--17 solution
SELECT SaleID, SalespersonID, ProductID, SalesAmount,
SUM(SalesAmount) OVER (PARTITION BY SalespersonID, ProductID ORDER BY SaleDate) AS CumulativeSales
FROM Sales;

--18 solution
SELECT SaleID, SalespersonID, SalesAmount, DepartmentID,
DENSE_RANK() OVER (PARTITION BY DepartmentID ORDER BY SalesAmount DESC) AS SalesRank
FROM Sales;

--19 solution
SELECT StoreID, SaleDate, SalesAmount,
SUM(SalesAmount) OVER (PARTITION BY StoreID ORDER BY SaleDate) AS CumulativeTotal
FROM Sales;

--20 solution
SELECT SaleID, ProductID, SaleDate, SalesAmount,
LAG(SalesAmount) OVER (PARTITION BY ProductID ORDER BY SaleDate) AS PrevSalesAmount,
SalesAmount - LAG(SalesAmount) OVER (PARTITION BY ProductID ORDER BY SaleDate) AS Difference
FROM Sales;