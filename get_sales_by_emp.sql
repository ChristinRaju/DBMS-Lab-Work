--Q-10. Write a PL/SQL Function to return sum of sales by EmpId

-- 1. Create the function
CREATE OR REPLACE FUNCTION get_sales_by_emp(emp_id IN NUMBER)  
RETURN NUMBER IS 
    total_sales NUMBER; 
BEGIN 
    -- Calculate the sum of sales for the given EmpId
    SELECT SUM(Quantity) 
    INTO total_sales 
    FROM Sales 
    WHERE EmpId = emp_id; 

    -- If there are no sales, SUM returns NULL, so return 0 instead
    IF total_sales IS NULL THEN
        RETURN 0;
    ELSE
        RETURN total_sales;
    END IF;
END;
/
-- The "/" is required to compile the function in Oracle

-- 2. Test the function for EmpId = 101
SELECT get_sales_by_emp(101) AS total_sales FROM dual;


-- OUTPUT:
-- TOTAL_SALES 
-- ----------- 
-- 10  
