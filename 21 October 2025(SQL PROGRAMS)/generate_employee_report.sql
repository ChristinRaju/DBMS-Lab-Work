-- Q11: Write a PL/SQL Procedure to generate Employee Report department wise as follows
-- DeptName EmpName Job Location Salary Cumulative_Salary

CREATE OR REPLACE PROCEDURE generate_employee_report IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('DeptName | EmpName | Job | Location | Salary | Cumulative_Salary');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------');

    FOR rec IN (
        SELECT 
            d.DeptName,
            e.EmpName,
            e.Job,
            d.DeptLoc AS Location,
            e.Salary,
            SUM(e.Salary) OVER (PARTITION BY d.DeptId ORDER BY e.EmpName) AS Cumulative_Salary
        FROM Employee e
        JOIN Department d ON e.DeptId = d.DeptId
        ORDER BY d.DeptName, e.EmpName
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE(
            rec.DeptName || ' | ' ||
            rec.EmpName || ' | ' ||
            rec.Job || ' | ' ||
            rec.Location || ' | ' ||
            rec.Salary || ' | ' ||
            rec.Cumulative_Salary
        );
    END LOOP;
END;
/
BEGIN
    generate_employee_report();
END;
/
