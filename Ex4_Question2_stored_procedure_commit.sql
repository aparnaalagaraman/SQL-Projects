--#SET TERMINATOR @
CREATE OR REPLACE PROCEDURE UPDATE_LEADERS_SCORE_NEW(IN in_School_ID INT,IN in_Leaders_Score INT)  -- Name of this stored procedure routine
LANGUAGE SQL      -- Language used in this routine 
MODIFIES SQL DATA                                          
BEGIN
    DECLARE SQLCODE INTEGER DEFAULT 0;                  -- Host variable SQLCODE declared and assigned 0
    DECLARE retcode INTEGER DEFAULT 0;                  -- Local variable retcode with declared and assigned 0
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION           -- Handler tell the routine what to do when an error or warning occurs
    SET retcode = SQLCODE;                              -- Value of SQLCODE assigned to local variable retcode
--Operations to be performed by stored procedure 
--Updating LEADERS_SCORE based on SCHOOL_ID in CHICAGO_PUBLIC_SCHOOLS   
	UPDATE CHICAGO_PUBLIC_SCHOOLS SET LEADERS_SCORE = in_Leaders_Score
	WHERE SCHOOL_ID = in_School_ID;
----Updating LEADERS_ICON = 'Weak' based on input leader_score (0 - 19) in CHICAGO_PUBLIC_SCHOOLS	
 IF in_Leaders_Score >= 0 AND in_Leaders_Score <= 19 THEN 
 	UPDATE CHICAGO_PUBLIC_SCHOOLS SET LEADERS_ICON = 'Very Weak'
 	WHERE SCHOOL_ID = in_School_ID;
----Updating LEADERS_ICON = 'Weak' based on input leader_score (20 - 39) in CHICAGO_PUBLIC_SCHOOLS	 	
 ELSEIF in_Leaders_Score >= 20 AND in_Leaders_Score <= 39 THEN 
 	UPDATE CHICAGO_PUBLIC_SCHOOLS SET LEADERS_ICON = 'Weak'
 	WHERE SCHOOL_ID = in_School_ID;
 ----Updating LEADERS_ICON = 'Average' based on input leader_score (40 - 59) in CHICAGO_PUBLIC_SCHOOLS	
 ELSEIF in_Leaders_Score >= 40 AND in_Leaders_Score <= 59 THEN 
 	UPDATE CHICAGO_PUBLIC_SCHOOLS SET LEADERS_ICON = 'Average'
 	WHERE SCHOOL_ID = in_School_ID;
  ----Updating LEADERS_ICON = 'Strong' based on input leader_score (60 - 79) in CHICAGO_PUBLIC_SCHOOLS	
 ELSEIF in_Leaders_Score >= 60 AND in_Leaders_Score <= 79 THEN 
 	UPDATE CHICAGO_PUBLIC_SCHOOLS SET LEADERS_ICON = 'Strong'
 	WHERE SCHOOL_ID = in_School_ID;	
 ----Updating LEADERS_ICON = 'Very Strong' based on input leader_score (80 - 99) in CHICAGO_PUBLIC_SCHOOLS	
 ELSEIF in_Leaders_Score >= 80 AND in_Leaders_Score <= 99 THEN 
 	UPDATE CHICAGO_PUBLIC_SCHOOLS SET LEADERS_ICON = 'Very Strong'
 	WHERE SCHOOL_ID = in_School_ID;
 ELSE 
    ROLLBACK WORK;
 END IF;         
 IF retcode < 0 THEN                                  --  SQLCODE returns negative value for error, zero for success, positive value for warning
      ROLLBACK WORK;
 ELSE
    COMMIT WORK;  
  END IF;
END
@                                                            -- Routine terminated