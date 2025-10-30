-- Q13: Write a PL/SQL Trigger not to delete more than 2 employees at a time

-- CREATE OR REPLACE TRIGGER emp_delete
-- BEFORE DELETE ON employee
-- DECLARE
--     emp_count NUMBER;
-- BEGIN
--     -- Count number of rows deleted
--     SELECT COUNT(*) INTO emp_count FROM employee
--     WHERE empid IN (SELECT empid FROM deleted_rows); -- Note: 'deleted_rows' is non-standard and should be a temporary or external mechanism for a 'BEFORE' statement trigger to count rows being acted upon.
--                                                      -- A standard approach for 'BEFORE DELETE' statement triggers to count rows is typically not possible without a view or other mechanism.
    
--     -- If more than 2 rows are being deleted, raise an error
--     IF emp_count > 2 THEN
--         RAISE_APPLICATION_ERROR(-20001, 'You cannot delete more than 2 employees at a time.');
--     END IF;
-- END;
-- /



-- Step 1: Create or replace the package
CREATE OR REPLACE PACKAGE emp_del_pkg AS
    emp_del_count NUMBER := 0;
END emp_del_pkg;
/

-- Step 2: Before each row trigger – increments count
CREATE OR REPLACE TRIGGER emp_delete_row
BEFORE DELETE ON employee
FOR EACH ROW
BEGIN
    emp_del_pkg.emp_del_count := emp_del_pkg.emp_del_count + 1;
END;
/

-- Step 3: After statement trigger – checks total deleted rows
CREATE OR REPLACE TRIGGER emp_delete_check
AFTER DELETE ON employee
BEGIN
    IF emp_del_pkg.emp_del_count > 2 THEN
        RAISE_APPLICATION_ERROR(-20001, 'You cannot delete more than 2 employees at a time.');
    END IF;
    -- Reset count after every delete statement
    emp_del_pkg.emp_del_count := 0;
END;
/

-- Insert test data if needed
INSERT INTO employee VALUES (106, 'John Deo', DATE '1990-11-01', DATE '2020-01-05', 'Sales Rep', 35000, 2);
INSERT INTO employee VALUES (107, 'Asha Nair', DATE '1989-03-12', DATE '2021-02-01', 'HR Assistant', 32000, 4);
INSERT INTO employee VALUES (108, 'Ravi Kumar', DATE '1993-07-20', DATE '2019-09-15', 'Developer', 40000, 3);
COMMIT;

-- Attempt to delete 3 employees at once
DELETE FROM employee WHERE empid IN (106, 107, 108);

select * from employee;
