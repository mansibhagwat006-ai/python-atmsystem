USE store_db;
-- 1. write a SQL query to find customers who are either from the city 'New York' 
-- or who do not have a grade greater than 100.
-- Return customer_id, cust_name, city, grade, and salesman_id

SELECT customer_id , cust_name , city, grade, salesman_id FROM customer WHERE city ='New York' 
OR grade <=100;

-- 2. write a SQL query to find all the customers in ‘New York’ city who have a grade value above 100.
-- Return customer_id, cust_name, city, grade, and salesman_id.

SELECT customer_id , cust_name , city, grade, salesman_id FROM customer WHERE city ='NEW YORK' AND grade<=100;

-- 3. Write a SQL query that displays order number, purchase amount, and the achieved
-- and unachieved percentage (%) for those orders that exceed 50% of the target value of 6000.

SELECT purch_amt/6000*100 AS 'achieved percentage',
100-purch_amt/6000*100  AS 'unachieved percentage',
purch_amt,ord_no FROM orders WHERE purch_amt
>  6000/100*50;

-- 4. write a SQL query to calculate the total purchase amount of all orders.
-- Return total purchase amount.

SELECT SUM(purch_amt) FROM orders;

-- 5. write a SQL query to find the highest purchase amount ordered by each customer.
-- Return customer ID, maximum purchase amount.

SELECT MAX(purch_amt) , customer_id FROM orders GROUP BY customer_id;

-- 6. write a SQL query to calculate the average product price. Return average product price.
SELECT AVG(pro_price) FROM item_mast;

-- 7. write a SQL query to find those employees whose department is located at ‘Toronto’.
-- Return first name, last name, employee ID, job ID.

USE hrdb;
SELECT first_name, last_name, employee_id, job_id FROM employees WHERE department_id=
(SELECT department_id FROM departments WHERE location_id IN (SELECT location_id FROM locations WHERE
city = 'TORONTO'));

-- 8. write a SQL query to find those employees whose salary is lower than that of employees whose job title is "MK_MAN".
-- Exclude employees of the Job title ‘MK_MAN’.
-- Return employee ID, first name, last name, job ID.

SELECT employee_id, first_name, last_name, job_id FROM employees 
WHERE salary<
(SELECT MIN(salary) FROM employees WHERE job_id ='MK_MAN');

-- 9. write a SQL query to find all those employees who work in department ID 80 or 40.
-- Return first name, last name, department number and department name.

SELECT first_name, last_name, e.department_id, department_name FROM employees e JOIN departments d
ON e.department_id = d.department_id WHERE e.department_id IN (80,40);

-- 10.write a SQL query to calculate the average salary, the number of employees receiving
-- commissions in that department.Return department name, average salary and number of employees.

SELECT avg(salary), COUNT(employee_id) , department_name
FROM employees e JOIN departments d ON e.department_id =d.department_id GROUP BY e.department_id;

-- 11.write a SQL query to find out which employees have the same 
-- designation as the employee whose ID is 169.
-- Return first name, last name, department ID and job ID.

 SELECT first_name, last_name, department_ID , job_ID FROM employees WHERE
 job_id = (SELECT job_id FROM employees WHERE employee_id =169);

-- 12.write a SQL query to find those employees who earn more than the average salary.
-- Return employee ID, first name, last name.

SELECT  employee_id, first_name, last_name FROM employees 
WHERE salary>(SELECT AVG(salary) FROM employees);

-- 13.write a SQL query to find all those employees who work in the Finance department.
-- Return department ID, name (first), job ID and department name.

SELECT e.department_id, first_name , job_ID, department_name 
FROM employees e JOIN departments d ON e.department_id =d.department_id WHERE department_name='FINANCE';

-- 14. From the following table, write a SQL query to 
-- find the employees who earn less than the employee of ID 182.
-- Return first name, last name and salary.

SELECT first_name, last_name ,salary FROM employees WHERE salary<
(SELECT salary FROM employees WHERE employee_id = 182);

-- 15.Create a stored procedure CountEmployeesByDept
-- that returns the number of employees in each department.
USE hrdb;

DELIMITER //
CREATE PROCEDURE CountEmployeesByDept()
BEGIN 
	SELECT COUNT(employee_id),department_id FROM employees GROUP BY department_id;
END // 
DELIMITER ;
 CALL CountEmployeesByDept();
 
-- 16.Create a stored procedure AddNewEmployee that adds a new employee to the database.
 DELIMITER //
 CREATE PROCEDURE AddNewEmployee(IN emp_id INT , IN f_name VARCHAR(20), IN l_name VARCHAR(20),IN em VARCHAR(10))
 
 BEGIN
 INSERT INTO Employees (employee_id,first_name,last_name,email)
 VALUES (emp_id,f_name,l_name,em);
 END //
 DELIMITER ;
 
 -- 17.Create a stored procedure DeleteEmployeesByDept that removes all employees from a specific department.
 
 DELIMITER //
 CREATE PROCEDURE DeleteEmployeesByDept(IN dept_id INT)
 
 BEGIN
 DELETE FROM employees WHERE department_id = dept_id;
 END //
 DELIMITER ;
 
 -- 18.Create a stored procedure GetTopPaidEmployees that retrieves the highest-paid employee in each department.
 DELIMITER //
 CREATE PROCEDURE GetTopPaidEmployees()
 
 BEGIN
SELECT employee_id , first_name,last_name ,salary,department_id FROM employees WHERE salary IN 
(SELECT MAX(salary) FROM employees GROUP BY department_id);
 END //
 DELIMITER ;
 
SELECT MAX(salary), department_id ,* FROM employees GROUP BY department_id;

-- 19.Create a stored procedure PromoteEmployee that increases an employee’s salary and changes their job role
USE hrdb;
DELIMITER //
 CREATE PROCEDURE PromoteEmployee(IN emp_id INT, IN amt INT , IN job_role VARCHAR(10))
 
 BEGIN
UPDATE employees SET salary =salary+amt , job_id = job_role WHERE employee_id = emp_id;
 END //
 DELIMITER ;

-- 20.Create a stored procedure AssignManagerToDepartment that assigns a new manager to all employees in a specific department.

DELIMITER //
 CREATE PROCEDURE AssignManagerToDepartment(IN manager INT, IN dept_id INT )
 
 BEGIN
UPDATE employees SET manager_id=manager WHERE department_id = dept_id;
UPDATE departments SET manager_id=manager WHERE department_id = dept_id;
 END //
 DELIMITER ;

 