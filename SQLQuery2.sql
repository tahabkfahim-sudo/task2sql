CREATE DATABASE TaskDB;
GO
USE TaskDB;
GO

-- 1) Create Employees table
CREATE TABLE Employees (
    ID      INT NOT NULL,
    Name    VARCHAR(100),
    Salary  DECIMAL(10,2)
);
GO

-- 2) Add Department column
ALTER TABLE Employees
ADD Department VARCHAR(50);
GO

-- 3) Remove Salary column
ALTER TABLE Employees
DROP COLUMN Salary;
GO

-- 4) Rename Department to DeptName
EXEC sp_rename 'Employees.Department', 'DeptName', 'COLUMN';
GO

-- 5) Create Projects table
CREATE TABLE Projects (
    ProjectID    INT NOT NULL,
    ProjectName  VARCHAR(100)
);
GO

-- 6) Add primary key to Employees (ID)
ALTER TABLE Employees
ADD CONSTRAINT PK_Employees PRIMARY KEY (ID);
GO


ALTER TABLE Projects
ADD CONSTRAINT PK_Projects PRIMARY KEY (ProjectID);
GO

-- 7) Foreign key: Employees (ID) references Projects (ProjectID)
ALTER TABLE Employees
ADD CONSTRAINT FK_Employees_Projects
FOREIGN KEY (ID) REFERENCES Projects(ProjectID);
GO

-- 8) Remove the foreign key
ALTER TABLE Employees
DROP CONSTRAINT FK_Employees_Projects;
GO

-- 9) Unique constraint on Name
ALTER TABLE Employees
ADD CONSTRAINT UQ_Employees_Name UNIQUE (Name);
GO

-- 10) Create Customers table
CREATE TABLE Customers (
    CustomerID  INT NOT NULL,
    FirstName   VARCHAR(50),
    LastName    VARCHAR(50),
    Email       VARCHAR(100),
    Status      VARCHAR(20)
);
GO

-- 11) Unique constraint on FirstName + LastName
ALTER TABLE Customers
ADD CONSTRAINT UQ_Customers_FullName UNIQUE (FirstName, LastName);
GO

-- 12) Default value 'Active' for Status
ALTER TABLE Customers
ADD CONSTRAINT DF_Customers_Status DEFAULT 'Active' FOR Status;

-- 13) Create Orders table
CREATE TABLE Orders (
    OrderID      INT NOT NULL,
    CustomerID   INT,
    OrderDate    DATETIME,
    TotalAmount  DECIMAL(10,2)
);
GO

-- 14) Check constraint: TotalAmount > 0
ALTER TABLE Orders
ADD CONSTRAINT CK_Orders_TotalAmount CHECK (TotalAmount > 0);
GO

-- 15) Create schema Sales and move Orders into it
CREATE SCHEMA Sales;
GO

ALTER SCHEMA Sales TRANSFER dbo.Orders;
GO

-- 16) Rename Orders to SalesOrders
EXEC sp_rename 'Sales.Orders', 'SalesOrders';
GO