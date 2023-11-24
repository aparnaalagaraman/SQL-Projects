--Using Joins
--Question 1
--Write and execute a SQL query to list the school names, community names and average attendance for communities with a hardship index of 98.

SELECT S.NAME_OF_SCHOOL,S.AVERAGE_STUDENT_ATTENDANCE,CS.COMMUNITY_AREA_NAME,CS.HARDSHIP_INDEX
FROM CHICAGO_PUBLIC_SCHOOLS S 
INNER JOIN CENSUS_DATA CS 
ON S.COMMUNITY_AREA_NUMBER = CS.COMMUNITY_AREA_NUMBER AND CS.HARDSHIP_INDEX = 98;