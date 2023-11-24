--Exercise 3: Creating a Stored Procedure
--Question 1
--Write the structure of a query to create or replace a stored procedure called UPDATE_LEADERS_SCORE that takes a in_School_ID parameter as an integer and a in_Leader_Score parameter as an integer. Don’t forget to use the #SET TERMINATOR statement to use the @ for the CREATE statement terminator.
--#SET TERMINATOR @
CREATE OR REPLACE PROCEDURE UPDATE_LEADERS_SCORE(IN in_School_ID INT,IN in_Leaders_Score INT)  -- Name of this stored procedure routine
LANGUAGE SQL                                                -- Language used in this routine 
BEGIN
--Operations to be performed by stored procedure        
        
END
@                                                            -- Routine termi