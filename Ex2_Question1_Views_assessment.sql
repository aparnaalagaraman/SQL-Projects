--Exercise 2: Creating a View
--Question 1
--Write and execute a SQL statement to create a view showing the columns listed in the following table, with new column names as shown in the second column.
CREATE VIEW CHICAGO_SCHOOL_RATING(SCHOOL_NAME,SAFETY_RATING,FAMILY_RATING,ENVIRONMENT_RATING,INSTRUCTION_RATING,LEADERS_RATING,TEACHERS_RATING)
AS SELECT NAME_OF_SCHOOL,SAFETY_ICON,FAMILY_INVOLVEMENT_ICON,ENVIRONMENT_ICON,
	   INSTRUCTION_ICON,LEADERS_ICON,TEACHERS_ICON
FROM CHICAGO_PUBLIC_SCHOOLS;


--Write and execute a SQL statement to create a view showing the columns listed in the following table, with new column names as shown in the second column.
SELECT * FROM CHICAGO_SCHOOL_RATING;

SELECT SCHOOL_NAME,LEADERS_RATING
FROM CHICAGO_SCHOOL_RATING;