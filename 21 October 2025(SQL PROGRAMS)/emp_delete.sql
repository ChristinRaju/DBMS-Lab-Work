-- Q13: Write a PL/SQL Trigger not to delete more than 2 employees at a time

CREATE OR REPLACE TRIGGER emp_delete
BEFORE DELETE ON employee
DECLARE
    emp_count NUMBER;
BEGIN
    -- Count number of rows deleted
    SELECT COUNT(*) INTO emp_count FROM employee
    WHERE empid IN (SELECT empid FROM deleted_rows); -- Note: 'deleted_rows' is non-standard and should be a temporary or external mechanism for a 'BEFORE' statement trigger to count rows being acted upon.
                                                     -- A standard approach for 'BEFORE DELETE' statement triggers to count rows is typically not possible without a view or other mechanism.
    
    -- If more than 2 rows are being deleted, raise an error
    IF emp_count > 2 THEN
        RAISE_APPLICATION_ERROR(-20001, 'You cannot delete more than 2 employees at a time.');
    END IF;
END;
/
