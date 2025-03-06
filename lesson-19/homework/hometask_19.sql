

CREATE TABLE Employees (
EmployeeID INT PRIMARY KEY,
FirstName VARCHAR(50),
LastName VARCHAR(50),
Salary DECIMAL(10, 2),
DepartmentID INT,
Age INT,
HireDate DATE
);

CREATE TABLE Products (
ProductID INT PRIMARY KEY,
ProductName VARCHAR(100),
Price DECIMAL(10, 2)
);

CREATE TABLE Sales (
SaleID INT PRIMARY KEY,
ProductID INT,
ProductCategory VARCHAR(50),
SalesAmount DECIMAL(10, 2)
);

CREATE TABLE Orders (
OrderID INT PRIMARY KEY,
CustomerID INT,
OrderDate DATE,
OrderAmount DECIMAL(10, 2)
);

INSERT INTO Employees (EmployeeID, FirstName, LastName, Salary, DepartmentID, Age, HireDate) VALUES
(1, 'John', 'Doe', 60000.00, 1, 30, '2020-01-15'),
(2, 'Jane', 'Smith', 75000.00, 1, 35, '2019-03-22'),
(3, 'Alice', 'Johnson', 50000.00, 2, 28, '2021-06-10'),
(4, 'Bob', 'Brown', 80000.00, 2, 40, '2018-11-05'),
(5, 'Charlie', 'Davis', 65000.00, 3, 32, '2020-09-18');

INSERT INTO Products (ProductID, ProductName, Price) VALUES
(1, 'Laptop', 1200.00),
(2, 'Smartphone', 800.00),
(3, 'Tablet', 500.00),
(4, 'Headphones', 150.00),
(5, 'Monitor', 300.00);

INSERT INTO Sales (SaleID, ProductID, ProductCategory, SalesAmount) VALUES
(1, 1, 'Electronics', 2400.00),
(2, 2, 'Electronics', 1600.00),
(3, 3, 'Electronics', 1500.00),
(4, 4, 'Accessories', 450.00),
(5, 5, 'Accessories', 900.00);

INSERT INTO Orders (OrderID, CustomerID, OrderDate, OrderAmount) VALUES
(1, 101, '2023-01-10', 1200.00),
(2, 101, '2023-02-15', 800.00),
(3, 102, '2023-03-20', 500.00),
(4, 103, '2023-04-25', 150.00),
(5, 103, '2023-05-30', 300.00);

--EASY:
--1
 SELECT EmployeeID, FirstName, LastName, Salary, ROW_NUMBER() OVER (ORDER BY Salary) AS RowNum FROM Employees; 
--2
  SELECT ProductID, ProductName, Price, RANK() OVER (ORDER BY Price DESC) AS PriceRank FROM Products; 
--3
  SELECT EmployeeID, FirstName, LastName, Salary, DENSE_RANK() OVER (ORDER BY Salary) AS SalaryRank FROM Employees; 
--4
  SELECT EmployeeID, FirstName, LastName, DepartmentID, Salary, LEAD(Salary) OVER (PARTITION BY DepartmentID ORDER BY Salary) AS NextSalary FROM Employees; 
--5
  SELECT OrderID, CustomerID, OrderDate, OrderAmount, ROW_NUMBER() OVER (ORDER BY OrderID) AS OrderNumber FROM Orders; 
--6  
WITH RankedSalaries AS (SELECT EmployeeID, FirstName, LastName, Salary, RANK() OVER (ORDER BY Salary DESC) AS SalaryRank FROM Employees) SELECT EmployeeID, FirstName, LastName, Salary, SalaryRank FROM RankedSalaries WHERE SalaryRank IN (1, 2); 
--7
  SELECT EmployeeID, FirstName, LastName, Salary, LAG(Salary) OVER (ORDER BY Salary) AS PreviousSalary FROM Employees; 
--8
  SELECT EmployeeID, FirstName, LastName, Salary, NTILE(4) OVER (ORDER BY Salary) AS SalaryGroup FROM Employees; 
--9  
SELECT EmployeeID, FirstName, LastName, DepartmentID, Salary, ROW_NUMBER() OVER (PARTITION BY DepartmentID ORDER BY EmployeeID) AS RowNumInDept FROM Employees; 
--10 
SELECT ProductID, ProductName, Price, DENSE_RANK() OVER (ORDER BY Price ASC) AS PriceRank FROM Products; 
--11
  SELECT ProductID, ProductName, Price, AVG(Price) OVER (ORDER BY ProductID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingAveragePrice FROM Products; 
--12
  SELECT EmployeeID, FirstName, LastName, Salary, LEAD(Salary) OVER (ORDER BY EmployeeID) AS NextSalary FROM Employees; 
--13
 SELECT SaleID, ProductID, SalesAmount, SUM(SalesAmount) OVER (ORDER BY SaleID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS CumulativeSales FROM Sales; 
--14
 WITH RankedProducts AS (SELECT ProductID, ProductName, Price, ROW_NUMBER() OVER (ORDER BY Price DESC) AS PriceRank FROM Products) SELECT ProductID, ProductName, Price, PriceRank FROM RankedProducts WHERE PriceRank <= 5; 
--15
  SELECT OrderID, CustomerID, OrderAmount, SUM(OrderAmount) OVER (PARTITION BY CustomerID) AS TotalOrderAmountPerCustomer FROM Orders; 
--16
  SELECT OrderID, CustomerID, OrderAmount, RANK() OVER (ORDER BY OrderAmount DESC) AS OrderRank FROM Orders; 
--17
  SELECT ProductCategory, SalesAmount, (SalesAmount * 100.0 / SUM(SalesAmount) OVER ()) AS PercentageContribution FROM Sales; 
--18
  SELECT OrderID, CustomerID, OrderDate, LEAD(OrderDate) OVER (ORDER BY OrderDate) AS NextOrderDate FROM Orders; 
--19
  SELECT EmployeeID, FirstName, LastName, Age, NTILE(3) OVER (ORDER BY Age) AS AgeGroup FROM Employees; 
--20
  SELECT EmployeeID, FirstName, LastName, HireDate, ROW_NUMBER() OVER (ORDER BY HireDate DESC) AS HireRank FROM Employees;

--MEDIUM:
ALTER TABLE Products ADD StockQuantity INT;

UPDATE Products SET StockQuantity = 50 WHERE ProductID = 1;
UPDATE Products SET StockQuantity = 30 WHERE ProductID = 2;
UPDATE Products SET StockQuantity = 20 WHERE ProductID = 3;
UPDATE Products SET StockQuantity = 40 WHERE ProductID = 4;
UPDATE Products SET StockQuantity = 10 WHERE ProductID = 5;

--1. 
SELECT EmployeeID, FirstName, LastName, Salary, AVG(Salary) OVER (ORDER BY Salary ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS CumulativeAvgSalary FROM Employees;

--2. 
SELECT p.ProductID, p.ProductName, SUM(s.SalesAmount) AS TotalSales, RANK() OVER (ORDER BY SUM(s.SalesAmount) DESC) AS SalesRank FROM Products p JOIN Sales s ON p.ProductID = s.ProductID GROUP BY p.ProductID, p.ProductName;

--3. 
SELECT OrderID, CustomerID, OrderDate, LAG(OrderDate) OVER (ORDER BY OrderDate) AS PreviousOrderDate FROM Orders;

--4. 
SELECT ProductID, ProductName, Price, SUM(Price) OVER (ORDER BY ProductID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingSumPrice FROM Products;

--5. 
SELECT EmployeeID, FirstName, LastName, Salary, NTILE(4) OVER (ORDER BY Salary) AS SalaryRange FROM Employees;

--6. 
SELECT SaleID, ProductID, SalesAmount, SUM(SalesAmount) OVER (PARTITION BY ProductID) AS TotalSalesPerProduct FROM Sales;

--7. 
SELECT ProductID, ProductName, StockQuantity, DENSE_RANK() OVER (ORDER BY StockQuantity) AS StockRank FROM Products;

--8. 
WITH RankedSalaries AS (SELECT EmployeeID, FirstName, LastName, DepartmentID, Salary, ROW_NUMBER() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS SalaryRank FROM Employees) SELECT EmployeeID, FirstName, LastName, DepartmentID, Salary FROM RankedSalaries WHERE SalaryRank = 2;

--9. 
SELECT SaleID, ProductID, SalesAmount, SUM(SalesAmount) OVER (ORDER BY SaleID) AS RunningTotalSales FROM Sales;

--10. 
SELECT SaleID, ProductID, SalesAmount, LEAD(SalesAmount) OVER (ORDER BY SaleID) AS NextSalesAmount FROM Sales;

--11. 
WITH RankedEarners AS (SELECT EmployeeID, FirstName, LastName, DepartmentID, Salary, RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS SalaryRank FROM Employees) SELECT EmployeeID, FirstName, LastName, DepartmentID, Salary FROM RankedEarners WHERE SalaryRank = 1;

--12. 
SELECT EmployeeID, FirstName, LastName, DepartmentID, Salary, RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary) AS SalaryRank FROM Employees;

--13. 
SELECT ProductID, ProductName, Price, NTILE(5) OVER (ORDER BY Price) AS PriceGroup FROM Products;

--14. 
SELECT EmployeeID, FirstName, LastName, DepartmentID, Salary, (MAX(Salary) OVER (PARTITION BY DepartmentID) - Salary) AS SalaryDifference FROM Employees;

--15. 
SELECT SaleID, ProductID, SalesAmount, LAG(SalesAmount) OVER (ORDER BY SaleID) AS PreviousSalesAmount FROM Sales;

--16. 
SELECT OrderID, CustomerID, OrderAmount, SUM(OrderAmount) OVER (PARTITION BY CustomerID ORDER BY OrderDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS CumulativeOrderAmount FROM Orders;

--17. 
WITH RankedOrders AS (SELECT OrderID, CustomerID, OrderDate, ROW_NUMBER() OVER (ORDER BY OrderDate DESC) AS OrderRank FROM Orders) SELECT OrderID, CustomerID, OrderDate FROM RankedOrders WHERE OrderRank = 3;

--18. 
SELECT EmployeeID, FirstName, LastName, DepartmentID, HireDate, RANK() OVER (PARTITION BY DepartmentID ORDER BY HireDate) AS HireRank FROM Employees;

--19. 
WITH RankedSalaries AS (SELECT EmployeeID, FirstName, LastName, DepartmentID, Salary, DENSE_RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS SalaryRank FROM Employees) SELECT EmployeeID, FirstName, LastName, DepartmentID, Salary FROM RankedSalaries WHERE SalaryRank = 3;

--20. 
SELECT OrderID, CustomerID, OrderDate, LEAD(OrderDate) OVER (ORDER BY OrderDate) AS NextOrderDate, DATEDIFF(DAY, OrderDate, LEAD(OrderDate) OVER (ORDER BY OrderDate)) AS DateDifference FROM Orders;

--DIFFICULT:
ALTER TABLE Employees ADD PerformanceScore INT;

UPDATE Employees SET PerformanceScore = 85 WHERE EmployeeID = 1;
UPDATE Employees SET PerformanceScore = 92 WHERE EmployeeID = 2;
UPDATE Employees SET PerformanceScore = 78 WHERE EmployeeID = 3;
UPDATE Employees SET PerformanceScore = 95 WHERE EmployeeID = 4;
UPDATE Employees SET PerformanceScore = 88 WHERE EmployeeID = 5;

--1. 
WITH SalesRank AS (SELECT p.ProductID, p.ProductName, SUM(s.SalesAmount) AS TotalSales, RANK() OVER (ORDER BY SUM(s.SalesAmount) DESC) AS SalesRank, NTILE(10) OVER (ORDER BY SUM(s.SalesAmount) DESC) AS Percentile FROM Products p JOIN Sales s ON p.ProductID = s.ProductID GROUP BY p.ProductID, p.ProductName) SELECT ProductID, ProductName, TotalSales, SalesRank FROM SalesRank WHERE Percentile > 1;
--2. 
SELECT EmployeeID, FirstName, LastName, HireDate, ROW_NUMBER() OVER (ORDER BY HireDate) AS ServiceRank FROM Employees WHERE DATEDIFF(YEAR, HireDate, GETDATE()) > 5;
--3. 
SELECT EmployeeID, FirstName, LastName, Salary, NTILE(10) OVER (ORDER BY Salary) AS SalaryGroup FROM Employees;
--4. 
SELECT SaleID, ProductID, SalesAmount, LEAD(SalesAmount) OVER (ORDER BY SaleID) AS NextSale, (LEAD(SalesAmount) OVER (ORDER BY SaleID) - SalesAmount) AS SaleDifference FROM Sales;
--5. 
SELECT ProductID, ProductName, Price, AVG(Price) OVER (PARTITION BY (SELECT ProductCategory FROM Sales WHERE Sales.ProductID = Products.ProductID)) AS AvgPricePerCategory FROM Products;
--6.
 WITH ProductSales AS (SELECT p.ProductID, p.ProductName, SUM(s.SalesAmount) AS TotalSales, RANK() OVER (ORDER BY SUM(s.SalesAmount) DESC) AS SalesRank FROM Products p JOIN Sales s ON p.ProductID = s.ProductID GROUP BY p.ProductID, p.ProductName) SELECT ProductID, ProductName, TotalSales, SalesRank FROM ProductSales WHERE SalesRank <= 3;
--7. 
WITH RankedEmployees AS (SELECT EmployeeID, FirstName, LastName, DepartmentID, Salary, ROW_NUMBER() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS SalaryRank FROM Employees) SELECT EmployeeID, FirstName, LastName, DepartmentID, Salary FROM RankedEmployees WHERE SalaryRank <= 5;
--8. 
SELECT SaleID, ProductID, SalesAmount, AVG(SalesAmount) OVER (ORDER BY SaleID ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING) AS MovingAvgSales FROM Sales;
--9. 
WITH ProductSales AS (SELECT p.ProductID, p.ProductName, SUM(s.SalesAmount) AS TotalSales, DENSE_RANK() OVER (ORDER BY SUM(s.SalesAmount) DESC) AS SalesRank FROM Products p JOIN Sales s ON p.ProductID = s.ProductID GROUP BY p.ProductID, p.ProductName) SELECT ProductID, ProductName, TotalSales, SalesRank FROM ProductSales WHERE SalesRank <= 5;
--10. 
SELECT OrderID, CustomerID, OrderAmount, NTILE(4) OVER (ORDER BY OrderAmount) AS OrderQuartile FROM Orders;
--11.
 SELECT OrderID, CustomerID, OrderDate, ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS OrderRank FROM Orders;
--12. 
SELECT EmployeeID, FirstName, LastName, DepartmentID, COUNT(*) OVER (PARTITION BY DepartmentID) AS TotalEmployeesInDept FROM Employees;
--13. 
WITH SalaryRanks AS (SELECT EmployeeID, FirstName, LastName, DepartmentID, Salary, RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS HighRank, RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary ASC) AS LowRank FROM Employees) SELECT EmployeeID, FirstName, LastName, DepartmentID, Salary FROM SalaryRanks WHERE HighRank <= 3 OR LowRank <= 3;
--14. 
SELECT SaleID, ProductID, SalesAmount, LAG(SalesAmount) OVER (ORDER BY SaleID) AS PrevSale, CASE WHEN LAG(SalesAmount) OVER (ORDER BY SaleID) IS NOT NULL THEN ((SalesAmount - LAG(SalesAmount) OVER (ORDER BY SaleID)) * 100.0 / LAG(SalesAmount) OVER (ORDER BY SaleID)) ELSE NULL END AS PercentChange FROM Sales;
--15. 
SELECT SaleID, ProductID, SalesAmount, SUM(SalesAmount) OVER (PARTITION BY ProductID ORDER BY SaleID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS CumulativeSum, AVG(SalesAmount) OVER (PARTITION BY ProductID ORDER BY SaleID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS CumulativeAvg FROM Sales;
--16. 
SELECT EmployeeID, FirstName, LastName, Age, NTILE(3) OVER (ORDER BY Age) AS AgeGroup FROM Employees;
--17. 
WITH EmployeeSales AS (SELECT e.EmployeeID, e.FirstName, e.LastName, SUM(s.SalesAmount) AS TotalSales, ROW_NUMBER() OVER (ORDER BY SUM(s.SalesAmount) DESC) AS SalesRank FROM Employees e JOIN Sales s ON e.EmployeeID = s.ProductID GROUP BY e.EmployeeID, e.FirstName, e.LastName) SELECT EmployeeID, FirstName, LastName, TotalSales, SalesRank FROM EmployeeSales WHERE SalesRank <= 10;
--18. 
SELECT ProductID, ProductName, Price, LEAD(Price) OVER (ORDER BY ProductID) AS NextPrice, (LEAD(Price) OVER (ORDER BY ProductID) - Price) AS PriceDifference FROM Products;
--19. 
SELECT EmployeeID, FirstName, LastName, PerformanceScore, DENSE_RANK() OVER (ORDER BY PerformanceScore DESC) AS PerformanceRank FROM Employees;
--20. 
SELECT OrderID, CustomerID, OrderAmount, LAG(OrderAmount) OVER (ORDER BY OrderID) AS PrevOrderAmount, LEAD(OrderAmount) OVER (ORDER BY OrderID) AS NextOrderAmount, (OrderAmount - LAG(OrderAmount) OVER (ORDER BY OrderID)) AS DiffFromPrev, (LEAD(OrderAmount) OVER (ORDER BY OrderID) - OrderAmount) AS DiffFromNext FROM Orders;


