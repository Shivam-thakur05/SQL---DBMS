sql basics:

SELECT * FROM SCHOOL; -- Table contains school name and other school details.
SELECT * FROM SUBJECTS; -- Contains all subjects thought in this school.
SELECT * FROM STAFF; -- All teaching and non teaching staff details are present here.
SELECT * FROM STAFF_SALARY; -- Staff salary can be found in this table.
SELECT * FROM CLASSES; -- Total classes in the school (from Grade 1 to Grade 10) along with subjects thought in each class and the teachers teaching these subjects.
SELECT * FROM STUDENTS; -- Student details including their name, age, gender etc.
SELECT * FROM PARENTS; -- Parents details including their name, address etc.
SELECT * FROM STUDENT_CLASSES; -- Students present in each class (or grade).
SELECT * FROM STUDENT_PARENT; -- Parent of each student can be found here.
SELECT * FROM ADDRESS; -- Address of all staff and students.

/* Different SQL Operators:::    = , <, >, >=, <=, <>, !=, BETWEEN, ORDER BY, IN, NOT IN, LIKE, ALIASE, DISTINCT, LIMIT, CASE:
Comparison Operators: =, <>, != , >, <, >=, <=
Arithmetic Operators: +, -, *, /, %
Logical Operators: AND, OR, NOT, IN, BETWEEN, LIKE etc.    */

-- Basic queries
SELECT * FROM STUDENTS;   -- Fetch all columns and all records (rows) from table.
SELECT ID, FIRST_NAME FROM STUDENTS; -- Fetch only ID and FIRST_NAME columns from students table.
-- Comparison Operators
SELECT * FROM SUBJECTS WHERE SUBJECT_NAME = 'Mathematics'; -- Fetch all records where subject name is Mathematics.
SELECT * FROM SUBJECTS WHERE SUBJECT_NAME <> 'Mathematics'; -- Fetch all records where subject name is not Mathematics.
SELECT * FROM SUBJECTS WHERE SUBJECT_NAME != 'Mathematics'; -- same as above. Both "<>" and "!=" are NOT EQUAL TO operator in SQL.
SELECT * FROM STAFF_SALARY WHERE SALARY > 10000; -- All records where salary is greater than 10000.
SELECT * FROM STAFF_SALARY WHERE SALARY < 10000; -- All records where salary is less than 10000.
SELECT * FROM STAFF_SALARY WHERE SALARY < 10000 ORDER BY SALARY; -- All records where salary is less than 10000 and the output is sorted in ascending order of salary.
SELECT * FROM STAFF_SALARY WHERE SALARY < 10000 ORDER BY SALARY DESC; -- All records where salary is less than 10000 and the output is sorted in descending order of salary.
SELECT * FROM STAFF_SALARY WHERE SALARY >= 10000; -- All records where salary is greater than or equal to 10000.
SELECT * FROM STAFF_SALARY WHERE SALARY <= 10000; -- All records where salary is less than or equal to 10000.
-- Logical Operators
SELECT * FROM STAFF_SALARY WHERE SALARY BETWEEN 5000 AND 10000; -- Fetch all records where salary is between 5000 and 10000.

SELECT * FROM SUBJECTS WHERE SUBJECT_NAME IN ('Mathematics', 'Science', 'Arts'); -- All records where subjects is either Mathematics, Science or Arts.

SELECT * FROM SUBJECTS WHERE SUBJECT_NAME NOT IN ('Mathematics', 'Science', 'Arts'); -- All records where subjects is not Mathematics, Science or Arts.

SELECT * FROM SUBJECTS WHERE SUBJECT_NAME LIKE 'Computer%'; -- Fetch records where subject name has Computer as prefixed. % matches all characters.

SELECT * FROM SUBJECTS WHERE SUBJECT_NAME NOT LIKE 'Computer%'; -- Fetch records where subject name does not have Computer as prefixed. % matches all characters.

SELECT * FROM STAFF WHERE AGE > 50 AND GENDER = 'F'; -- Fetch records where staff is female and is over 50 years of age. AND operator fetches result only if the condition mentioned both on left side and right side of AND operator holds true. In OR operator, atleast any one of the conditions needs to hold true to fetch result.

SELECT * FROM STAFF WHERE FIRST_NAME LIKE 'A%' AND LAST_NAME LIKE 'S%'; -- Fetch record where first name of staff starts with "A" AND last name starts with "S".

SELECT * FROM STAFF WHERE FIRST_NAME LIKE 'A%' OR LAST_NAME LIKE 'S%'; -- Fetch record where first name of staff starts with "A" OR last name starts with "S". Meaning either the first name or the last name condition needs to match for query to return data.

SELECT * FROM STAFF WHERE (FIRST_NAME LIKE 'A%' OR LAST_NAME LIKE 'S%') AND AGE > 50; -- Fetch record where staff is over 50 years of age AND has his first name starting with "A" OR his last name starting with "S".

-- Arithmetic Operators

SELECT (5+2) AS ADDITION;   -- Sum of two numbers. PostgreSQL does not need FROM clause to execute such queries.

SELECT (5-2) AS SUBTRACT;   -- Oracle & MySQL equivalent query would be -->  select (5+2) as Addition FROM DUAL; --> Where dual is a dummy table.

SELECT (5*2) AS MULTIPLY;

SELECT (5/2) AS DIVIDE;   -- Divides 2 numbers and returns whole number.

SELECT (5%2) AS MODULUS;  -- Divides 2 numbers and returns the remainder

SELECT STAFF_TYPE FROM STAFF ; -- Returns lot of duplicate data.

SELECT DISTINCT STAFF_TYPE FROM STAFF ; -- Returns unique values only.

SELECT STAFF_TYPE FROM STAFF LIMIT 5; -- Fetches only the first 5 records from the result.

-- CASE statement:  (IF 1 then print True ; IF 0 then print FALSE ; ELSE print -1)

SELECT STAFF_ID, SALARY
, CASE WHEN SALARY >= 10000 THEN 'High Salary'
       WHEN SALARY BETWEEN 5000 AND 10000 THEN 'Average Salary'
       WHEN SALARY < 5000 THEN 'Too Low'
  END AS RANGE
FROM STAFF_SALARY

ORDER BY 2 DESC;

-- TO_CHAR / TO_DATE:

SELECT * FROM STUDENTS WHERE TO_CHAR(DOB,'YYYY') = '2014';

SELECT * FROM STUDENTS WHERE DOB = TO_DATE('13-JAN-2014','DD-MON-YYYY');

-- JOINS (Two ways to write SQL queries):
-- #1. Using JOIN keyword between tables in FROM clause.

SELECT  T1.COLUMN1 AS C1, T1.COLUMN2 C2, T2.COLUMN3 AS C3    -- C1, C2, C3 are aliase to the column

  FROM  TABLE1    T1

  JOIN  TABLE2 AS T2 ON T1.C1 = T2.C1 AND T1.C2 = T2.C2;    -- T1, T2 are aliases for table names.

-- #2. Using comma "," between tables in FROM clause.

SELECT  T1.COLUMN1 AS C1, T1.COLUMN2 AS C2, T2.COLUMN3 C3

  FROM  TABLE1 AS T1, TABLE2 AS T2

 WHERE  T1.C1 = T2.C1

   AND  T1.C2 = T2.C2;

-- Fetch all the class name where Music is thought as a subject.

SELECT CLASS_NAME

FROM SUBJECTS SUB

JOIN CLASSES CLS ON SUB.SUBJECT_ID = CLS.SUBJECT_ID

WHERE SUBJECT_NAME = 'Music';

-- Fetch the full name of all staff who teach Mathematics.

SELECT DISTINCT (STF.FIRST_NAME||' '||STF.LAST_NAME) AS FULL_NAME --, CLS.CLASS_NAME

FROM SUBJECTS SUB

JOIN CLASSES CLS ON CLS.SUBJECT_ID = SUB.SUBJECT_ID

JOIN STAFF STF ON CLS.TEACHER_ID = STF.STAFF_ID

WHERE SUB.SUBJECT_NAME = 'Mathematics';

-- Fetch all staff who teach grade 8, 9, 10 and also fetch all the non-teaching staff

-- UNION can be used to merge two differnt queries. UNION returns always unique records so any duplicate data while merging these queries will be eliminated.

-- UNION ALL displays all records including the duplicate records.

-- When using both UNION, UNION ALL operators, rememeber that noo of columns and their data type must match among the different queries.

SELECT STF.STAFF_TYPE

,    (STF.FIRST_NAME||' '||STF.LAST_NAME) AS FULL_NAME

,    STF.AGE

,    (CASE WHEN STF.GENDER = 'M' THEN 'Male'

           WHEN STF.GENDER = 'F' THEN 'Female'

      END) AS GENDER

,    STF.JOIN_DATE

FROM STAFF STF

JOIN CLASSES CLS ON STF.STAFF_ID = CLS.TEACHER_ID

WHERE STF.STAFF_TYPE = 'Teaching'

AND   CLS.CLASS_NAME IN ('Grade 8', 'Grade 9', 'Grade 10')

UNION ALL

SELECT STAFF_TYPE

,    (FIRST_NAME||' '||LAST_NAME) AS FULL_NAME, AGE

,    (CASE WHEN GENDER = 'M' THEN 'Male'

           WHEN GENDER = 'F' THEN 'Female'

      END) AS GENDER

,    JOIN_DATE

FROM STAFF

WHERE STAFF_TYPE = 'Non-Teaching';

-- Count no of students in each class

SELECT SC.CLASS_ID, COUNT(1) AS "no_of_students"

FROM STUDENT_CLASSES SC

GROUP BY SC.CLASS_ID

ORDER BY SC.CLASS_ID;

-- Return only the records where there are more than 100 students in each class

SELECT SC.CLASS_ID, COUNT(1) AS "no_of_students"

FROM STUDENT_CLASSES SC

GROUP BY SC.CLASS_ID

HAVING COUNT(1) > 100

ORDER BY SC.CLASS_ID;

-- Parents with more than 1 kid in school.

SELECT PARENT_ID, COUNT(1) AS "no_of_kids"

FROM STUDENT_PARENT SP

GROUP BY PARENT_ID

HAVING COUNT(1) > 1;

--SUBQUERY: Query written inside a query is called subquery.

-- Fetch the details of parents having more than 1 kids going to this school. Also display student details.

SELECT (P.FIRST_NAME||' '||P.LAST_NAME) AS PARENT_NAME
,    (S.FIRST_NAME||' '||S.LAST_NAME) AS STUDENT_NAME
,    S.AGE AS STUDENT_AGE
,    S.GENDER AS STUDENT_GENDER
,    (ADR.STREET||', '||ADR.CITY||', '||ADR.STATE||', '||ADR.COUNTRY) AS ADDRESS
FROM PARENTS P
JOIN STUDENT_PARENT SP ON P.ID = SP.PARENT_ID
JOIN STUDENTS S ON S.ID = SP.STUDENT_ID
JOIN ADDRESS ADR ON P.ADDRESS_ID = ADR.ADDRESS_ID
WHERE P.ID IN (  SELECT PARENT_ID
                   FROM STUDENT_PARENT SP
               GROUP BY PARENT_ID
                 HAVING COUNT(1) > 1)
ORDER BY 1;

-- Staff details who’s salary is less than 5000
SELECT STAFF_TYPE, FIRST_NAME, LAST_NAME
FROM  STAFF
WHERE STAFF_ID IN (SELECT STAFF_ID
                     FROM STAFF_SALARY
                    WHERE SALARY < 5000);

--Aggregate Functions (AVG, MIN, MAX, SUM, COUNT): Aggregate functions are used to perform calculations on a set of values.
-- AVG: Calculates the average of the given values.
SELECT AVG(SS.SALARY)::NUMERIC(10,2) AS AVG_SALARY
FROM STAFF_SALARY SS
JOIN STAFF STF ON STF.STAFF_ID = SS.STAFF_ID
WHERE STF.STAFF_TYPE = 'Teaching';
SELECT STF.STAFF_TYPE, AVG(SS.SALARY)::NUMERIC(10,2) AS AVG_SALARY
FROM STAFF_SALARY SS
JOIN STAFF STF ON STF.STAFF_ID = SS.STAFF_ID
GROUP BY STF.STAFF_TYPE;




select * from employee;
select * from department;

-- subquery
-- Q.find the employees who's salary is more than the average salary earned by all employees

select avg(salary) from employee;	--44166.666666666667

select *
from employee
where salary > 44166.666666666667;

-- the above methd is not right way to find the average because if the salary chnge then values will be wrong so here we are using the subquery
select  * from employee where -- outer query
salary > (select avg(salary) from employee); --subquery (inner query)


-- scalar subquery :- it always return 1 row and 1 column
select e.* from employee e
join (select avg(salary) sal from employee) avg_sal
on e.salary > avg_sal.sal;

-- multiple row subquery:- multiple rows and multiple column
-- Q.find the employees who earn the highest salary in each department
select emp_name, max(salary)
from employee
group by emp_name;

select * 
from employee
where (emp_name, salary) in (select emp_name,max(salary)
							from employee
							group by emp_name);
							
-- single column subquery 




-- HAVING CLAUSE AND GROUP BY CLAUSE
-- find the stores who have sold more units than the avg 
select store_name,sum(quantity)
from sales
group by store_name
having sum(quantity) > (select avg(quantity) from sales);


subquery :- select avg(quantity) from sales;

update employee
set dept_name  = 'admin' where emp_name = 'sagar';
update employee
set dept_name  = 'admin' where emp_name = 'sagar';
update employee
set dept_name  = 'admin' where emp_name = 'sagar';
update employee
set dept_name  = 'admin' where emp_name = 'sagar';



--subquery using update commmand 
update employee e
set salary = (select max(salary) + (max(salary) * 0.1)
			  from employee_history eh
			 where eh.dept_name = e.dept_name) 
where e.dept_name in (select dept_name
					  from department
					  where location = 'Banglore')
and e.emp_id in (select emp_id from employee_history);