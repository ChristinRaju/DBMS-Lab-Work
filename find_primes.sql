-- 6. Write a PL/SQL Procedure to find prime number from 1 to n, n is a user input or Parameter

CREATE OR REPLACE PROCEDURE find_primes(n IN NUMBER) AS
    is_prime BOOLEAN;
BEGIN
    FOR i IN 2..n LOOP
        is_prime := TRUE;
        -- Check if i is prime
        FOR j IN 2..TRUNC(SQRT(i)) LOOP
            IF MOD(i, j) = 0 THEN
                is_prime := FALSE;
                EXIT;
            END IF;
        END LOOP;

        IF is_prime THEN
            DBMS_OUTPUT.PUT_LINE(i || ' is a prime number');
        END IF;
    END LOOP;
END;
/

BEGIN
    find_primes(30); -- List primes up to 30
END;
/

-- OUTPUT:
-- 2 is a prime number
-- 3 is a prime number
-- 5 is a prime number
-- 7 is a prime number
-- 11 is a prime number
-- 13 is a prime number
-- 17 is a prime number
-- 19 is a prime number
-- 23 is a prime number
-- 29 is a prime number
