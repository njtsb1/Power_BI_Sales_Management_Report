USE company_constraints;

INSERT INTO employee VALUES 
('John', 'B', 'Smith', 123456789, '1965-01-09', '731-Fondren-Houston-TX', 'M', 30000, 333445555, 5),
('Franklin', 'T', 'Wong', 333445555, '1955-12-08', '638-Voss-Houston-TX', 'M', 40000, 888665555, 5),
('Alicia', 'J', 'Zelaya', 999887777, '1968-01-19', '3321-Castle-Spring-TX', 'F', 25000, 987654321, 4),
('Jennifer', 'S', 'Wallace', 987654321, '1941-06-20', '291-Berry-Bellaire-TX', 'F', 43000, 888665555, 4),
('Ramesh', 'K', 'Narayan', 666884444, '1962-09-15', '975-Fire-Oak-Humble-TX', 'M', 38000, 333445555, 5),
('Joyce', 'A', 'English', 453453453, '1972-07-31', '5631-Rice-Houston-TX', 'F', 25000, 333445555, 5),
('Ahmad', 'V', 'Jabbar', 987987987, '1969-03-29', '980-Dallas-Houston-TX', 'M', 25000, 987654321, 4),
('James', 'E', 'Borg', 888665555, '1937-11-10', '450-Stone-Houston-TX', 'M', 55000, NULL, 1);

INSERT INTO dependent VALUES 
(333445555, 'Alice', 'F', '1986-04-05', 'Daughter'),
(333445555, 'Theodore', 'M', '1983-10-25', 'Son'),
(333445555, 'Joy', 'F', '1958-05-03', 'Spouse'),
(987654321, 'Abner', 'M', '1942-02-28', 'Spouse'),
(123456789, 'Michael', 'M', '1988-01-04', 'Son'),
(123456789, 'Alice', 'F', '1988-12-30', 'Daughter'),
(123456789, 'Elizabeth', 'F', '1967-05-05', 'Spouse');

INSERT INTO departament VALUES 
('Research', 5, 333445555, '1988-05-22','1986-05-22'),
('Administration', 4, 987654321, '1995-01-01','1994-01-01'),
('Headquarters', 1, 888665555,'1981-06-19','1980-06-19');

INSERT INTO dept_locations VALUES 
(1, 'Houston'),
(4, 'Stafford'),
(5, 'Bellaire'),
(5, 'Sugarland'),
(5, 'Houston');

INSERT INTO project VALUES 
('ProductX', 1, 'Bellaire', 5),
('ProductY', 2, 'Sugarland', 5),
('ProductZ', 3, 'Houston', 5),
('Computerization', 10, 'Stafford', 4),
('Reorganization', 20, 'Houston', 1),
('Newbenefits', 30, 'Stafford', 4);

INSERT INTO works_on VALUES 
(123456789, 1, 32.5),
(123456789, 2, 7.5),
(666884444, 3, 40.0),
(453453453, 1, 20.0),
(453453453, 2, 20.0),
(333445555, 2, 10.0),
(333445555, 3, 10.0),
(333445555, 10, 10.0),
(333445555, 20, 10.0),
(999887777, 30, 30.0),
(999887777, 10, 10.0),
(987987987, 10, 35.0),
(987987987, 30, 5.0),
(987654321, 30, 20.0),
(987654321, 20, 15.0),
(888665555, 20, 0.0);

-- SQL Queries

SELECT * FROM employee;
SELECT Ssn, COUNT(Essn) FROM employee e, dependent d WHERE (e.Ssn = d.Essn);
SELECT * FROM dependent;

SELECT Bdate, Address FROM employee
WHERE Fname = 'John' AND Minit = 'B' AND Lname = 'Smith';

SELECT * FROM departament WHERE Dname = 'Research';

SELECT Fname, Lname, Address
FROM employee, departament
WHERE Dname = 'Research' AND Dnumber = Dno;

SELECT * FROM project;

--
-- Expressions and string concatenation
--

-- retrieving information for departments located in Stafford
SELECT Dname AS Department, Mgr_ssn AS Manager 
FROM departament d, dept_locations l
WHERE d.Dnumber = l.Dnumber;

-- SQL standard uses || ; in MySQL use the concat() function
SELECT Dname AS Department, CONCAT(Fname, ' ', Lname) 
FROM departament d, dept_locations l, employee e
WHERE d.Dnumber = l.Dnumber AND Mgr_ssn = e.Ssn;

-- retrieving project info in Stafford
SELECT * FROM project, departament WHERE Dnum = Dnumber AND Plocation = 'Stafford';

-- retrieving info about departments and projects located in Stafford
SELECT Pnumber, Dnum, Lname, Address, Bdate
FROM project, departament, employee
WHERE Dnum = Dnumber AND Mgr_ssn = Ssn AND Plocation = 'Stafford';

SELECT * FROM employee WHERE Dno IN (3,6,9);

--
-- Logical operators
--

SELECT Bdate, Address
FROM employee
WHERE Fname = 'John' AND Minit = 'B' AND Lname = 'Smith';

SELECT Fname, Lname, Address
FROM employee, departament
WHERE Dname = 'Research' AND Dnumber = Dno;

--
-- Expressions and aliases
--

-- calculating the INSS value
SELECT Fname, Lname, Salary, Salary * 0.011 FROM employee;
SELECT Fname, Lname, Salary, Salary * 0.011 AS INSS FROM employee;
SELECT Fname, Lname, Salary, ROUND(Salary * 0.011, 2) AS INSS FROM employee;

-- define a salary increase for managers who work on the project associated with ProductX
SELECT e.Fname, e.Lname, 1.1 * e.Salary AS increased_sal
FROM employee AS e, works_on AS w, project AS p
WHERE e.Ssn = w.Essn AND w.Pno = p.Pnumber AND p.Pname = 'ProductX';

-- concatenating and providing alias
SELECT Dname AS Department, CONCAT(Fname, ' ', Lname) AS Manager
FROM departament d, dept_locations l, employee e
WHERE d.Dnumber = l.Dnumber AND Mgr_ssn = e.Ssn;

-- retrieving employees who work for the Research department
SELECT Fname, Lname, Address
FROM employee, departament
WHERE Dname = 'Research' AND Dnumber = Dno;

-- using aliases for query readability
SELECT e.Fname, e.Lname, e.Address
FROM employee e, departament d
WHERE d.Dname = 'Research' AND d.Dnumber = e.Dno;
