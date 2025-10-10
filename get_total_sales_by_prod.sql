--Q9. Write a PL/SQL Function to return sum of sales by ProdId

CREATE OR REPLACE FUNCTION get_total_sales_by_prod(prod_id IN VARCHAR)  
RETURN NUMBER IS 
    total_sales NUMBER; 
BEGIN 
    -- Calculate the sum of quantities sold for the given ProdId 
    SELECT SUM(Quantity) INTO total_sales 
    FROM Sales  
    WHERE ProdId = prod_id; 
 
    -- Return the total sales 
    RETURN total_sales; 
END;
/ 

SELECT get_total_sales_by_prod('P002') AS total_quantity_sold FROM dual;


-- OUTPUT:
-- TOTAL_QUANTITY_SOLD 
-- ------------------- 
-- 7  
