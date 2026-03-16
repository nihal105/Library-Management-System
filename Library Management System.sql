
CREATE DATABASE librery;
USE librery;

CREATE TABLE Branch (
Branch_no INT PRIMARY KEY,
Manager_Id INT,
Branch_address VARCHAR(200),
Contact_no VARCHAR(15)
);

INSERT INTO Branch VALUES
(1, 101, 'Kochi Main Branch', '9876543210'),
(2, 102, 'Calicut Branch', '9876543211'),
(3, 103, 'Trivandrum Branch', '9876543212'); 

CREATE TABLE Employee (
Emp_Id INT PRIMARY KEY,
Emp_name VARCHAR(100),
Position VARCHAR(50),
Salary DECIMAL(10,2),
Branch_no INT,
FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);

INSERT INTO Employee VALUES
(101, 'Rahul', 'Manager', 60000, 1),
(102, 'Anu', 'Manager', 55000, 2),
(103, 'David', 'Manager', 65000, 3),
(104, 'Riya', 'Assistant', 30000, 1),
(105, 'Akhil', 'Clerk', 25000, 2),
(106, 'Neha', 'Assistant', 52000, 1),
(107, 'Vishnu', 'Clerk', 27000, 3);

CREATE TABLE Books (
ISBN INT PRIMARY KEY,
Book_title VARCHAR(200),
Category VARCHAR(100),
Rental_Price DECIMAL(10,2),
Status VARCHAR(10),
Author VARCHAR(100),
Publisher VARCHAR(100)
);

INSERT INTO Books VALUES
(1111,'History of India','History',30,'yes','Ramesh','ABC'),
(1112,'World War','History',40,'no','John','XYZ'),
(1113,'Science Basics','Science',25,'yes','Albert','Pearson'),
(1114,'Math Fundamentals','Education',20,'yes','Arun','McGraw'),
(1115,'Indian Culture','History',35,'no','Suresh','ABC'),
(1116,'Computer Networks','Technology',50,'yes','Andrew','TechPub');

CREATE TABLE Customer (
Customer_Id INT PRIMARY KEY,
Customer_name VARCHAR(100),
Customer_address VARCHAR(200),
Reg_date DATE
);

INSERT INTO Customer VALUES
(1,'Arjun','Kochi','2021-05-10'),
(2,'Meera','Calicut','2023-02-15'),
(3,'Sanjay','Trivandrum','2020-11-20'),
(4,'Anjali','Kochi','2022-07-01');

CREATE TABLE IssueStatus (
Issue_Id INT PRIMARY KEY,
Issued_cust INT,
Issued_book_name VARCHAR(200),
Issue_date DATE,
Isbn_book INT,
FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);

INSERT INTO IssueStatus VALUES
(1,1,'History of India','2023-06-10',1111),
(2,2,'Science Basics','2023-05-15',1113),
(3,3,'Computer Networks','2023-06-20',1116);

CREATE TABLE ReturnStatus (
Return_Id INT PRIMARY KEY,
Return_cust INT,
Return_book_name VARCHAR(200),
Return_date DATE,
Isbn_book2 INT,
FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);

INSERT INTO ReturnStatus VALUES
(1,1,'History of India','2023-06-25',1111),
(2,2,'Science Basics','2023-06-01',1113);

SHOW TABLES;

SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'yes';

SELECT Emp_name, Salary
FROM Employee
ORDER BY Salary DESC;

SELECT Books.Book_title, Customer.Customer_name
FROM IssueStatus
JOIN Books ON IssueStatus.Isbn_book = Books.ISBN
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id;

SELECT Category, COUNT(*) AS Total_Books
FROM Books
GROUP BY Category;

SELECT Emp_name, Position
FROM Employee
WHERE Salary > 50000;

SELECT Customer_name
FROM Customer
WHERE Reg_date < '2022-01-01'
AND Customer_Id NOT IN (
SELECT Issued_cust FROM IssueStatus
);

SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no;

SELECT Customer.Customer_name
FROM IssueStatus
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id
WHERE MONTH(Issue_date) = 6 AND YEAR(Issue_date) = 2023;

SELECT Book_title
FROM Books
WHERE Book_title LIKE '%history%';

SELECT Branch_no, COUNT(*) AS Employee_Count
FROM Employee
GROUP BY Branch_no
HAVING COUNT(*) > 5;

SELECT Employee.Emp_name, Branch.Branch_address
FROM Employee
JOIN Branch ON Employee.Emp_Id = Branch.Manager_Id;

SELECT Customer.Customer_name
FROM IssueStatus
JOIN Books ON IssueStatus.Isbn_book = Books.ISBN
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id
WHERE Books.Rental_Price > 25;