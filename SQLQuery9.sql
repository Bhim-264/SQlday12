-- Creating Department table 
DROP TABLE IF EXISTS Department;
DROP TABLE IF EXISTS Employee;


create TABLE Department(
DeptID int primary KEY,
DeptName varchar(50)
);

-- creating a Employee table 
create TABLE Employee(
EmpID INT primary KEY,
EmpName  varchar(100),
Salary decimal(10,2),
DeptID INT,
ManagerID INT,
DateOfJoining date
);

INSERT INTO Department VALUES(1,'HR'),(2,'Finance'),(3,'IT'),(4,'Customer Support');

Select * from Department;
INSERT INTO Employee VALUES
(101,'Raj', 70000.45,3,null,'2024-01-15'),
(102,'Rajiv', 35000,2,101,'2025-01-15'),
(103,'Rajesh', 40000.75,3,101,'2021-01-15'),
(104,'Rajni', 50000,3,102,'2022-01-15'),
(105,'Rani', 70000,1,null,'2020-01-15'),
(106,'Kishor', 80000,4,null,'2018-01-15'),
(107,'Bhim', 80000,5,null,'2018-01-16');


Select * from Employee;

-- implementing built-in Scalar function

SELECT EmpName,Len(EmpName) As NameLength FROM Employee;

select EmpName, round(Salary,-3) AS RoundedSalary FROM Employee;
--positive value rounds  to decimal place (Round(123.456,2) -> 123.46)
--negative Vlaue rounds to power of 10 o the left( Round(12345,-2)-> 12300)

select GETDATE() AS CurrentDate;

-- Aggregate Functions 

select Count(*) AS TotalEmployees FROM Employee;
SELECT round(avg(Salary),-2) AS AverageSalary FROM Employee;
Select max(Salary) AS MaxSalary FROM Employee;

-- Joins 
--Inner Joins : Returns only matching rows from both table 

Select E.EmpName, D.DeptName
FROM Employee E
INNER JOIN Department D ON E.DeptID = D.DeptID;
-- Left Joins : returns all rows from the left table and matched rows from the right table 

Select E.EmpName, D.DeptName
FROM Employee E 
LEFT JOIN  Department D ON E.DeptID = D.DeptID; 
-- Right Joins: returns alll rows from the right table  and matched rows from the left

Select E.EmpName , D.DeptName
FROM Employee E
right JOIN Department D ON E.DeptID = D.DeptID;
-- Full Joins : Returns all rows where there is a match in one of the table 

Select E.EmpName , D.DeptName
FROM Employee E
FUll OUTER JOIN Department D ON E.DeptID = D.DeptID;

-- Self join : a table is joined with itself, ofthe using aliases.
-- Here we are returning Emp- > Manager mapping 
Select E1.EmpName AS Employee, E2.EmpName AS Manager
FROM Employee E1
LEFT JOIN  Employee E2  ON E1.ManagerID = E2.EmpID;
-- cross join : returns the cartsian product of two table(All possible combination)
SELECT EmpName, 'DeptName' FROM Employee cross join "Department"
