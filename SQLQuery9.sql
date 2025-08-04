use collegeDB;
-- DDL: Create Tables with Constraints

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Age INT CHECK (Age >= 18)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE NOT NULL,
    Amount DECIMAL(10, 2) CHECK (Amount > 0),
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Insert Initial Data


INSERT INTO Customers VALUES (1, 'Alice Smith', 'alice@example.com', 28);
INSERT INTO Customers VALUES (2, 'Bob Johnson', 'bob@example.com', 35);

INSERT INTO Orders VALUES (101, '2025-08-01', 250.00, 1);
INSERT INTO Orders VALUES (102, '2025-08-02', 180.50, 2);


-- Commit Initial Data

COMMIT;


-- View Initial Data

SELECT * FROM Customers;
SELECT * FROM Orders;

-- ==============================
-- DCL: Grant Permissions
-- ==============================
GRANT SELECT ON Customers TO PUBLIC;
GRANT SELECT ON Orders TO PUBLIC;

-- ==============================
-- Scenario 1: Successful Transaction with COMMIT
-- ==============================
BEGIN TRANSACTION;

INSERT INTO Customers VALUES (3, 'Charlie Brown', 'charlie@example.com', 30);
INSERT INTO Orders VALUES (103, '2025-08-03', 300.00, 3);

COMMIT;

SELECT * FROM Customers WHERE CustomerID = 3;
SELECT * FROM Orders WHERE OrderID = 103;

-- View after Scenario 1
SELECT * FROM Customers;
SELECT * FROM Orders;

-- ==============================
-- Scenario 2: Failed Transaction with ROLLBACK
-- ==============================
BEGIN TRANSACTION;

-- This will violate the CHECK constraint (Age < 18)
INSERT INTO Customers VALUES (4, 'Danny Danger', 'danny@example.com', 16);

-- Attempt to insert related order (won't happen due to failure above)
INSERT INTO Orders VALUES (104, '2025-08-04', 150.00, 4);

-- Rollback the transaction
ROLLBACK;

-- View after Scenario 2 (Danny should NOT appear)
SELECT * FROM Customers;
SELECT * FROM Orders;

-- ==============================
-- DCL: Revoke Permissions
-- ==============================
REVOKE SELECT ON Customers FROM PUBLIC;
REVOKE SELECT ON Orders FROM PUBLIC;
;
