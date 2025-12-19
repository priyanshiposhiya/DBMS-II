 --	Part – A 

--1.	INSERT Procedures: Create stored procedures to insert records into STUDENT tables (SP_INSERT_STUDENT)
--StuID	Name	        Email	        Phone	    Department	DOB	        EnrollmentYear
--10	Harsh Parmar	harsh@univ.edu	9876543219	CSE	        2005-09-18	2023
--11	Om Patel	    om@univ.edu	    9876543220	IT	        2002-08-22	2022
		-- Create the procedure
        CREATE OR ALTER PROCEDURE PR_INSERT_STUDENT
        @STUID INT,
        @STUNAME VARCHAR(100),
        @STUEMAIL VARCHAR(100),
        @STUPHONE VARCHAR(15),
        @STUDEPARTMENT VARCHAR(50),
        @STUDATEBIRTH DATE,
        @STUENROLLMENTYEAR INT,
		@STUCGPA DECIMAL(3,2)
        AS
        BEGIN
        INSERT INTO STUDENT 
        VALUES (@STUID, @STUNAME, @STUEMAIL, @STUPHONE, @STUDEPARTMENT, @STUDATEBIRTH, @STUENROLLMENTYEAR,@STUCGPA)
        END

		EXEC PR_INSERT_STUDENT 10,'Harsh Parmar','harsh@univ.edu',9876543219,'CSE','2005-09-18',2023,9.5
		EXEC PR_INSERT_STUDENT 11,'Om Patel','om@univ.edu',9876543220,'IT','2002-08-22',2022,9.38

		SELECT * FROM STUDENT
		
--2.	INSERT Procedures: Create stored procedures to insert records into COURSE tables 
--(SP_INSERT_COURSE)
--CourseID	CourseName	          Credits	Dept	Semester
--CS330	    Computer Networks	  4	        CSE	    5
--EC120	    Electronic Circuits	  3	        ECE	    2
		CREATE OR ALTER PROCEDURE PR_INSERT_COURSE
        @COURSEID VARCHAR(10),
		@COURSENAME VARCHAR(100),
		@COURSECREDITS INT,
		@COURSEDEPARTMENT VARCHAR(50),
		@COURSESEMESTER INT
        AS
        BEGIN
        INSERT INTO COURSE
        VALUES (@COURSEID,@COURSENAME,@COURSECREDITS,@COURSEDEPARTMENT,@COURSESEMESTER)
        END

		EXEC PR_INSERT_COURSE 'CS330','Computer Networks',4,'CSE',5
		EXEC PR_INSERT_COURSE 'EC120','Electronic Circuits',3,'ECE',2

		SELECT * FROM COURSE

--3.	UPDATE Procedures: Create stored procedure SP_UPDATE_STUDENT to update Email and Phone in STUDENT table. (Update using studentID)
		CREATE OR ALTER PROCEDURE SP_UPDATE_STUDENT
        @STUDENTID INT,
        @STUEMAIL VARCHAR(100),
        @STUPHONE VARCHAR(15)
        AS
        BEGIN
        UPDATE STUDENT
        SET STUEMAIL = @STUEMAIL,
            STUPHONE= @STUPHONE
        WHERE STUDENTID = @STUDENTID
        END
		 
		EXEC SP_UPDATE_STUDENT 8,'pooja.p@univ.edu',9876543220 

		SELECT * FROM STUDENT

--4.	DELETE Procedures: Create stored procedure SP_DELETE_STUDENT to delete records from STUDENT where Student Name is Om Patel.
		CREATE OR ALTER PROCEDURE SP_DELETE_STUDENT
        AS
        BEGIN
			DELETE FROM STUDENT
			WHERE StuName = 'Om Patel'
        END

		EXEC SP_DELETE_STUDENT 

		SELECT * FROM STUDENT

--5.	SELECT BY PRIMARY KEY: Create stored procedures to select records by primary key (SP_SELECT_STUDENT_BY_ID) from Student table.
		CREATE OR ALTER PROCEDURE SP_SELECT_STUDENT_BY_ID
		@StudentID INT
		AS
		BEGIN
	    SELECT *
        FROM STUDENT
        WHERE StudentID = @StudentID
        END

		EXEC SP_SELECT_STUDENT_BY_ID 10

--6.	Create a stored procedure that shows details of the first 5 students ordered by EnrollmentYear.
		CREATE OR ALTER PROCEDURE SP_SELECT_TOP5_STUDENTS
		AS
		BEGIN
			SELECT TOP 5 *
			FROM STUDENT
			ORDER BY StuEnrollmentYear
        END

		EXEC SP_SELECT_TOP5_STUDENTS

--Part – B  

--7.	Create a stored procedure which displays faculty designation-wise count.
		CREATE PROCEDURE SP_FACULTY_DESIGNATION_COUNT
		AS
		BEGIN
			SELECT COUNT(*) AS FacultyCount,
							   FacultyDesignation
			FROM FACULTY
			GROUP BY FacultyDesignation
        END

		EXEC SP_FACULTY_DESIGNATION_COUNT 

--8.	Create a stored procedure that takes department name as input and returns all students in that department.
		CREATE PROCEDURE SP_SELECT_STUDENTS_BY_DEPARTMENT
		@StuDepartment VARCHAR(50)
		AS
		BEGIN
			SELECT STUNAME
		    FROM STUDENT
			WHERE StuDepartment=@StuDepartment
        END

		EXEC SP_SELECT_STUDENTS_BY_DEPARTMENT @StuDepartment='CSE'


--Part – C 

--9.	Create a stored procedure which displays department-wise maximum, minimum, and average credits of courses.
		CREATE PROCEDURE SP_DISPLAY_DEPARTMENT_WISE_MAX_MIN_AVG
		AS
		BEGIN
			SELECT MAX(CourseCredits) AS MAXIMUM_CREDIT,
				   MIN(CourseCredits) AS MINIMUM_CREDIT,
				   MAX(CourseCredits) AS AVERAGE_CREDIT,
				   CourseDepartment
		    FROM COURSE
			GROUP BY CourseDepartment
        END

		EXEC SP_DISPLAY_DEPARTMENT_WISE_MAX_MIN_AVG

--10.	Create a stored procedure that accepts StudentID as parameter and returns all courses the student is enrolled in with their grades.
		CREATE PROCEDURE SP_DISPLAY_COURSES_AND_PERAMETER
		@StudentID INT
		AS
		BEGIN
			SELECT STUDENT.StuName,COURSE.CourseName,ENROLLMENT.Grade
		    FROM STUDENT
			JOIN ENROLLMENT
			ON STUDENT.StudentID=ENROLLMENT.StudentID
			JOIN COURSE
			ON COURSE.CourseID=ENROLLMENT.CourseID	
			WHERE STUDENT.StudentID=@StudentID
        END

		EXEC SP_DISPLAY_COURSES_AND_PERAMETER @StudentID=1
