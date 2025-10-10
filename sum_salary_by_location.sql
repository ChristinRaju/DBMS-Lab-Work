--P8:Write a PL/SQL Procedure to find sum of salaries of all employee working in a particular location

-- Turn off substitution variables
SET DEFINE OFF;

-- Create or replace procedure
CREATE OR REPLACE PROCEDURE sum_salary_by_location (
    p_location IN VARCHAR2,
    p_total_salary OUT NUMBER
) AS
BEGIN
    -- Calculate total salary for the given location
    SELECT NVL(SUM(e.salary),0)
    INTO p_total_salary
    FROM employee e
    JOIN department d ON e.deptid = d.deptid
    WHERE d.deptloc = p_location;
END sum_salary_by_location;
/

-- Anonymous block to call the procedure
DECLARE
    total_salary NUMBER;
    loc VARCHAR2(20) := 'Chennai';  -- <-- change location here
BEGIN
    -- Call the procedure
    sum_salary_by_location(loc, total_salary);

    -- Display the result
    DBMS_OUTPUT.PUT_LINE('Total Salary for ' || loc || ' is: ' || total_salary);
END;
/

  
-- OUTPUT:
-- Total Salary for Chennai is: 38000
