-- Q13: Write a PL/SQL Trigger not to delete more than 2 employees at a time

CREATE OR REPLACE TRIGGER check_salary_limit
BEFORE UPDATE OF salary ON employee
FOR EACH ROW
BEGIN
    IF :NEW.salary > 67000 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Salary cannot be updated to a value greater than 67000.');
    END IF;
END;
/
