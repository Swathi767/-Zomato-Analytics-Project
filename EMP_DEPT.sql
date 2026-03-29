CREATE DATABASE EMPLOYEE;

USE EMPLOYEE;

-- 2.	  Create the Dept Table as below -- 
CREATE TABLE dept (
    deptno INT PRIMARY KEY,
    dname  VARCHAR(20),
    loc    VARCHAR(20)
);

INSERT INTO dept VALUES
(10, 'OPERATIONS', 'BOSTON'),
(20, 'RESEARCH', 'DALLAS'),
(30, 'SALES', 'CHICAGO'),
(40, 'ACCOUNTING', 'NEW YORK');

SELECT * FROM dept;

-- 1.	Create the Employee Table as per the Below Data Provided
	CREATE TABLE emp (
    empno INT PRIMARY KEY,
    ename VARCHAR(20),
    job   VARCHAR(20) DEFAULT 'CLERK',
    mgr   INT,
    hiredate DATE,
    sal   DECIMAL(10,2) NOT NULL,
    comm  DECIMAL(10,2),
    deptno INT,
    CONSTRAINT chk_sal CHECK (sal > 0),
    CONSTRAINT fk_dept FOREIGN KEY (deptno)
        REFERENCES dept(deptno)
);

INSERT INTO emp VALUES
(7369,'SMITH','CLERK',7902,'1890-12-17',800.00,NULL,20),
(7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600.00,300.00,30),
(7521,'WARD','SALESMAN',7698,'1981-02-22',1250.00,500.00,30),
(7566,'JONES','MANAGER',7839,'1981-04-02',2975.00,NULL,20),
(7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250.00,1400.00,30),
(7698,'BLAKE','MANAGER',7839,'1981-05-01',2850.00,NULL,30),
(7782,'CLARK','MANAGER',7839,'1981-06-09',2450.00,NULL,10),
(7788,'SCOTT','ANALYST',7566,'1987-04-19',3000.00,NULL,20),
(7839,'KING','PRESIDENT',NULL,'1981-11-17',5000.00,NULL,10),
(7844,'TURNER','SALESMAN',7698,'1981-09-08',1500.00,0.00,30),
(7876,'ADAMS','CLERK',7788,'1987-05-23',1100.00,NULL,20),
(7900,'JAMES','CLERK',7698,'1981-12-03',950.00,NULL,30),
(7902,'FORD','ANALYST',7566,'1981-12-03',3000.00,NULL,20),
(7934,'MILLER','CLERK',7782,'1982-01-23',1300.00,NULL,10);

SELECT * from emp;

-- 3.	List the Names and salary of the employee whose salary is greater than 1000
SELECT ename, sal
FROM emp
WHERE sal > 1000;

-- 4.	List the details of the employees who have joined before end of September 81.
SELECT *
FROM emp
WHERE hiredate < '1981-09-30';

-- 5.	List Employee Names having I as second character.
SELECT ename
FROM emp
WHERE ename LIKE '_I%';

-- 6.	List Employee Name, Salary, Allowances (40% of Sal), P.F. (10 % of Sal) and Net Salary. Also assign the alias name for the columns
SELECT 
    ename AS Employee_Name,
    sal   AS Salary,
    sal * 0.40 AS Allowances,
    sal * 0.10 AS PF,
    sal + (sal * 0.40) - (sal * 0.10) AS Net_Salary
FROM emp;

-- 7. List Employee Names with designations who does not report to anybody
SELECT ename, job
FROM emp
WHERE mgr IS NULL;

-- 8.	List Empno, Ename and Salary in the ascending order of salary.
SELECT empno, ename, sal
FROM emp
ORDER BY sal ASC;

-- 9.	How many jobs are available in the Organization ?
SELECT COUNT(DISTINCT job) AS Total_Jobs
FROM emp;

-- 10.	Determine total payable salary of salesman category
SELECT SUM(sal) AS Total_Payable_Salary
FROM emp
WHERE job = 'SALESMAN';

-- 11.	List average monthly salary for each job within each department  
SELECT 
    deptno,
    job,
    AVG(sal) AS Avg_Monthly_Salary
FROM emp
GROUP BY deptno, job;

-- 12.	Use the Same EMP and DEPT table used in the Case study to Display EMPNAME, SALARY and DEPTNAME in which the employee is working.
SELECT 
    e.ename AS EmpName,
    e.sal   AS Salary,
    d.dname AS DeptName
FROM emp e
JOIN dept d
ON e.deptno = d.deptno;

-- 13.	  Create the Job Grades Table as below
CREATE TABLE JobGrades (
    grade CHAR(1) PRIMARY KEY,
    lowest_sal INT,
    highest_sal INT
);

INSERT INTO JobGrades (grade, lowest_sal, highest_sal) VALUES
('A', 0, 999),
('B', 1000, 1999),
('C', 2000, 2999),
('D', 3000, 3999),
('E', 4000, 5000);

select * FROM jobGrades;

-- 14.	Display the last name, salary and  Corresponding Grade.
SELECT 
    e.ename,
    e.sal,
    j.grade
FROM 
    Emp e
JOIN 
    JobGrades j
ON 
    e.sal BETWEEN j.lowest_sal AND j.highest_sal;
    
    -- 15.	Display the Emp name and the Manager name under whom the Employee works in the below format .
    SELECT 
    e.ename AS Emp,
    m.ename AS Mgr
FROM 
    Emp e
LEFT JOIN 
    Emp m
ON 
    e.mgr = m.empno;
    
    -- 16.	Display Empname and Total sal where Total Sal (sal + Comm)
   SELECT 
    Ename,
    sal + comm AS Total_Sal
FROM 
    Emp;
    
    -- 17.	Display Empname and Sal whose empno is a odd number
    SELECT 
    Ename,
    Sal
FROM 
    Emp
WHERE 
    MOD(empno, 2) = 1;

-- 18.	Display Empname , Rank of sal in Organisation , Rank of Sal in their department
SELECT
    Ename,
    Sal,
    RANK() OVER (ORDER BY Sal DESC) AS Org_Sal_Rank,
    RANK() OVER (PARTITION BY Deptno ORDER BY Sal DESC) AS Dept_Sal_Rank
FROM
    Emp;

-- 19.	Display Top 3 Empnames based on their Salary
SELECT Ename, Sal
FROM Emp
ORDER BY Sal DESC
LIMIT 3;

-- 20.	 Display Empname who has highest Salary in Each Department.
SELECT Ename, Deptno, Sal
FROM (
    SELECT Ename,
           Deptno,
           Sal,
           RANK() OVER (PARTITION BY Deptno ORDER BY Sal DESC) AS Dept_Sal_Rank
    FROM Emp
) AS RankedEmp
WHERE Dept_Sal_Rank = 1;


