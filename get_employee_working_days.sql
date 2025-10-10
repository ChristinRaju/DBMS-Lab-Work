-- Q7: Write a PL/SQL Functions to return number of days an employee working using EmpId

CREATE OR REPLACE FUNCTION get_employee_working_days(p_empid IN NUMBER)
RETURN NUMBER
IS
    v_start_date   DATE;
    v_working_days NUMBER;
BEGIN
    -- Retrieve the start date of the employee based on empid
    SELECT doj
    INTO v_start_date
    FROM employee
    WHERE empid = p_empid;

    -- Calculate the number of days the employee has been working
    v_working_days := TRUNC(SYSDATE - v_start_date);

    -- Return the number of working days
    RETURN v_working_days;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- Handle case when the employee ID is not found
        RAISE_APPLICATION_ERROR(-20001, 'Employee not found');
    WHEN OTHERS THEN
        -- Handle any other unexpected errors
        RAISE_APPLICATION_ERROR(-20002, 'An error occurred: ' || SQLERRM);
END;
/
SELECT get_employee_working_days(101) AS working_days FROM dual;


-- OUTPUT:
-- WORKING_DAYS 
-- ------------ 
-- 2049 
