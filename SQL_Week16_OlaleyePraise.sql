


-- Original UNNORMALIZED table (before normalization)
CREATE TABLE Orders_Unnormalized (
    OrderID        INT,
    CustomerName   VARCHAR(100),
    CustomerEmail  VARCHAR(100),
    CustomerCity   VARCHAR(50),
    ProductName    VARCHAR(100),
    CategoryName   VARCHAR(50),
    Quantity       INT,
    UnitPrice      DECIMAL(10,2),
    OrderDate      DATE
);


-- Insert sample data into the unnormalized table
INSERT INTO Orders_Unnormalized VALUES
(1, 'Ada Eze',      'ada@email.com',   'Lagos',   'Laptop',    'Electronics', 1, 350000.00, '2026-01-10'),
(2, 'Ada Eze',      'ada@email.com',   'Lagos',   'Mouse',     'Electronics', 2,   5000.00, '2026-01-15'),
(3, 'Tunde Bello',  'tunde@email.com', 'Abuja',   'Desk',      'Furniture',   1,  45000.00, '2026-01-20'),
(4, 'Ngozi Obi',    'ngozi@email.com', 'PH',      'Laptop',    'Electronics', 1, 350000.00, '2026-02-05'),
(5, 'Tunde Bello',  'tunde@email.com', 'Abuja',   'Chair',     'Furniture',   4,  15000.00, '2026-02-10'),
(6, 'Emeka Chukwu', 'emeka@email.com', 'Enugu',   'Keyboard',  'Electronics', 3,   8000.00, '2026-02-18'),
(7, 'Ada Eze',      'ada@email.com',   'Lagos',   'Monitor',   'Electronics', 1,  80000.00, '2026-03-01'),
(8, 'Ngozi Obi',    'ngozi@email.com', 'PH',      'Bookshelf', 'Furniture',   1,  25000.00, '2026-03-05');


--Eliminate redundancy, split into related tables

-- ----  Categories Table (lookup table) ----
CREATE TABLE Categories (
    CategoryID   INT PRIMARY KEY IDENTITY(1,1),
    CategoryName VARCHAR(50) NOT NULL
);


INSERT INTO Categories (CategoryName) VALUES
('Electronics'),
('Furniture');


-- ---- 2B: Customers Table ----
CREATE TABLE Customers_2 (
    CustomerID    INT PRIMARY KEY IDENTITY(1,1),
    CustomerName  VARCHAR(100) NOT NULL,
    CustomerEmail VARCHAR(100) NOT NULL,
    CustomerCity  VARCHAR(50)
);

INSERT INTO Customers_2(CustomerName, CustomerEmail, CustomerCity) VALUES
('Ada Eze',      'ada@email.com',   'Lagos'),
('Tunde Bello',  'tunde@email.com', 'Abuja'),
('Ngozi Obi',    'ngozi@email.com', 'PH'),
('Emeka Chukwu', 'emeka@email.com', 'Enugu');



-- ---- Products Table ----
CREATE TABLE Products (
    ProductID    INT PRIMARY KEY IDENTITY(1,1),
    ProductName  VARCHAR(100) NOT NULL,
    CategoryID   INT NOT NULL,
    UnitPrice    DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_Products_Category FOREIGN KEY (CategoryID)
        REFERENCES Categories(CategoryID)
);


INSERT INTO Products (ProductName, CategoryID, UnitPrice) VALUES
('Laptop',    1, 350000.00),
('Mouse',     1,   5000.00),
('Desk',      2,  45000.00),
('Chair',     2,  15000.00),
('Keyboard',  1,   8000.00),
('Monitor',   1,  80000.00),
('Bookshelf', 2,  25000.00);



-- ----  Orders Table (Normalized) ----
CREATE TABLE Orders_2 (
    OrderID    INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT NOT NULL,
    OrderDate  DATE NOT NULL,
    CONSTRAINT FK_Orders_Customer FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
);


INSERT INTO Orders_2 (CustomerID, OrderDate) VALUES
(1, '2026-01-10'),
(1, '2026-01-15'),
(2, '2026-01-20'),
(3, '2026-02-05'),
(2, '2026-02-10'),
(4, '2026-02-18'),
(1, '2026-03-01'),
(3, '2026-03-05');



-- ----  OrderItems Table (bridge table for Order <-> Product) ----
CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY IDENTITY(1,1),
    OrderID     INT NOT NULL,
    ProductID   INT NOT NULL,
    Quantity    INT NOT NULL,
    CONSTRAINT FK_OrderItems_Order   FOREIGN KEY (OrderID)   REFERENCES Orders(OrderID),
    CONSTRAINT FK_OrderItems_Product FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO OrderItems (OrderID, ProductID, Quantity) VALUES
(1, 1, 1),   -- Order 1: Laptop x1
(2, 2, 2),   -- Order 2: Mouse x2
(3, 3, 1),   -- Order 3: Desk x1
(4, 1, 1),   -- Order 4: Laptop x1
(5, 4, 4),   -- Order 5: Chair x4
(6, 5, 3),   -- Order 6: Keyboard x3
(7, 6, 1),   -- Order 7: Monitor x1
(8, 7, 1);   -- Order 8: Bookshelf x1



-- ============================================================
-- INDEXING


-- Index on CustomerEmail for fast customer lookup
CREATE INDEX IX_Customers_Email
    ON Customers_2(CustomerEmail);

-- Index on Orders.CustomerID for faster JOIN performance
CREATE INDEX IX_Orders_CustomerID
    ON Orders_2(CustomerID);

-- Index on Orders.OrderDate for date-range queries
CREATE INDEX IX_Orders_OrderDate
    ON Orders_2(OrderDate);

-- Index on OrderItems.OrderID for faster JOIN with Orders
CREATE INDEX IX_OrderItems_OrderID
    ON OrderItems(OrderID);

-- Composite index on Products: CategoryID + UnitPrice
CREATE INDEX IX_Products_Category_Price
    ON Products(CategoryID, UnitPrice);



-- ============================================================
-- SECTION 4: OPTIMIZED QUERIES
-- Rewrite queries using proper JOINs, avoid SELECT *,
--       and leverage indexes created above
-- ============================================================

-- ---- Query 1: All orders with customer & product details ----
SELECT
    o.OrderID,
    c.CustomerName,
    c.CustomerCity,
    p.ProductName,
    cat.CategoryName,
    oi.Quantity,
    p.UnitPrice,
    (oi.Quantity * p.UnitPrice)  AS TotalAmount,
    o.OrderDate
FROM Orders_2 AS o
    INNER JOIN Customers_2  AS c   ON o.CustomerID = c.CustomerID
    INNER JOIN OrderItems  AS oi  ON o.OrderID    = oi.OrderID
    INNER JOIN Products    AS p   ON oi.ProductID = p.ProductID
    INNER JOIN Categories  AS cat ON p.CategoryID = cat.CategoryID
ORDER BY o.OrderDate;



-- ---- Query 2: Total revenue per customer ----
SELECT
    c.CustomerName,
    c.CustomerCity,
    COUNT(DISTINCT o.OrderID)          AS TotalOrders,
    SUM(oi.Quantity * p.UnitPrice)     AS TotalRevenue
FROM Customers_2 AS c
    INNER JOIN Orders_2    AS o  ON c.CustomerID = o.CustomerID
    INNER JOIN OrderItems AS oi ON o.OrderID    = oi.OrderID
    INNER JOIN Products   AS p  ON oi.ProductID = p.ProductID
GROUP BY c.CustomerName, c.CustomerCity
ORDER BY TotalRevenue DESC;



-- ---- Query 3: Sales by product category ----
SELECT
    cat.CategoryName,
    COUNT(oi.OrderItemID)              AS TotalItemsSold,
    SUM(oi.Quantity * p.UnitPrice)     AS CategoryRevenue
FROM Categories  AS cat
    INNER JOIN Products   AS p  ON cat.CategoryID = p.CategoryID
    INNER JOIN OrderItems AS oi ON p.ProductID    = oi.ProductID
GROUP BY cat.CategoryName
ORDER BY CategoryRevenue DESC;


-- ---- Query 4: Orders within a specific date range ----
SELECT
    o.OrderID,
    c.CustomerName,
    p.ProductName,
    oi.Quantity,
    o.OrderDate
FROM Orders_2 AS o
    INNER JOIN Customers_2   AS c  ON o.CustomerID = c.CustomerID
    INNER JOIN OrderItems  AS oi ON o.OrderID    = oi.OrderID
    INNER JOIN Products    AS p  ON oi.ProductID = p.ProductID
WHERE o.OrderDate BETWEEN '2026-01-01' AND '2026-02-28'
ORDER BY o.OrderDate;



-- ---- Query 5: Customers who ordered Electronics ----
SELECT DISTINCT
    c.CustomerName,
    c.CustomerEmail
FROM Customers_2 AS c
    INNER JOIN Orders_2     AS o   ON c.CustomerID = o.CustomerID
    INNER JOIN OrderItems AS oi  ON o.OrderID    = oi.OrderID
    INNER JOIN Products   AS p   ON oi.ProductID = p.ProductID
    INNER JOIN Categories AS cat ON p.CategoryID = cat.CategoryID
WHERE cat.CategoryName = 'Electronics';







