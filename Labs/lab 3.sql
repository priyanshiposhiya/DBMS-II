--	Part – A 

--1.	Create a stored procedure that accepts a date and returns all faculty members who joined on that date.
		CREATE OR ALTER PROC PR_GET_MEMBER_WITH_JOINING_DATE
		@FacultyJoiningDate DATE
		AS
		BEGIN
			SELECT * 
			FROM FACULTY
			WHERE FacultyJoiningDate = @FacultyJoiningDate
		END

		EXEC PR_GET_MEMBER_WITH_JOINING_DATE '2019-07-20'

--2.	Create a stored procedure for ENROLLMENT table where user enters either StudentID and returns EnrollmentID, EnrollmentDate, Grade, and Status.
		CREATE OR ALTER PROC PR_GET_STUDENT_WITH_ENROLLMENT_INFO
		@STUDENTID INT
		AS
		BEGIN
			SELECT EnrollmentID,EnrollmentDate, Grade, EnrollmentStatus
			FROM ENROLLMENT
			WHERE StudentID=@STUDENTID
		END

		EXEC PR_GET_STUDENT_WITH_ENROLLMENT_INFO 5

--3.	Create a stored procedure that accepts two integers (min and max credits) and returns all courses whose credits fall between these values.
		CREATE OR ALTER PROC PR_GET_COURCES_WITH_MIN_MAX_CREDITS
		@MAX_CREDITS INT,
		@MIN_CREDITS INT
		AS
		BEGIN
			SELECT COURSENAME,CourseCredits
			FROM COURSE
			WHERE CourseCredits BETWEEN @MAX_CREDITS AND @MIN_CREDITS 
		END

		EXEC PR_GET_COURCES_WITH_MIN_MAX_CREDITS 1,3

--4.	Create a stored procedure that accepts Course Name and returns the list of students enrolled in that course.
		CREATE OR ALTER PROC PR_GET_STUDENT_LIST
		@COURSENAME VARCHAR(50)
		AS
		BEGIN
			SELECT STUDENT.StuName,
				   COURSE.CourseName
			FROM STUDENT
			JOIN ENROLLMENT
			ON STUDENT.StudentID = ENROLLMENT.StudentID
			JOIN COURSE
			ON COURSE.CourseID = ENROLLMENT.CourseID
			WHERE CourseName = @COURSENAME
		END

		EXEC PR_GET_STUDENT_LIST @COURSENAME= 'Programming Fundamentals'

--5.	Create a stored procedure that accepts Faculty Name and returns all course assignments.
		CREATE OR ALTER PROC PR_GET_FACULTY_LIST
		@FACULTYNAME VARCHAR(100)
		AS
		BEGIN
			SELECT COURSE.CourseName,
				   FACULTY.FacultyName
			FROM COURSE_ASSIGNMENT
			JOIN FACULTY
			ON FACULTY.FacultyID=COURSE_ASSIGNMENT.FacultyID
			JOIN COURSE
			ON COURSE.CourseID = COURSE_ASSIGNMENT.CourseID
			WHERE FacultyName=@FACULTYNAME
		END

		EXEC PR_GET_FACULTY_LIST @FACULTYNAME='Dr. Sheth'

--6.	Create a stored procedure that accepts Semester number and Year, and returns all course assignments with faculty and classroom details.
		CREATE OR ALTER PROC PR_GET_FACULTY_DATA
		@SEMESTER INT,
		@YEAR INT
		AS
		BEGIN
			SELECT FACULTY.FacultyName,
				   COURSE_ASSIGNMENT.ClassRoom
			FROM COURSE_ASSIGNMENT
			JOIN FACULTY
			ON FACULTY.FacultyID=COURSE_ASSIGNMENT.FacultyID
			WHERE Semester=@SEMESTER AND Year = @YEAR
		END

		EXEC PR_GET_FACULTY_DATA @SEMESTER = 3 , @YEAR=2024

--Part – B 

--7.	Create a stored procedure that accepts the first letter of Status ('A', 'C', 'D') and returns enrollment details.
		CREATE OR ALTER PROC PR_ENROLLMENT_DETAILS
		@LETTER VARCHAR(1)
		AS
		BEGIN
			SELECT ENROLLMENTSTATUS
			FROM ENROLLMENT
			WHERE ENROLLMENTSTATUS LIKE @LETTER + '%'
		END

		EXEC PR_ENROLLMENT_DETAILS @LETTER

--8.	Create a stored procedure that accepts either Student Name OR Department Name and returns student data accordingly.
		CREATE OR ALTER PROC PR_STUDENT_DETAILS
		@STUNAME VARCHAR(100) = NULL,
		@STUDEPARTMENT VARCHAR(50) = NULL
		AS
		BEGIN
			SELECT *
			FROM STUDENT
			WHERE StuName = @STUNAME  OR StuDepartment=@STUDEPARTMENT
		END

		EXEC PR_STUDENT_DETAILS 'Raj Patel'

--9.	Create a stored procedure that accepts CourseID and returns all students enrolled grouped by enrollment status with counts.
		CREATE OR ALTER PROC PR_GET_STUDENT_WITH_COUNT
		@COURSEID VARCHAR(10),
		@COUNT INT OUT
		AS
		BEGIN
			SELECT @COUNT = COUNT(*) 
			FROM STUDENT
			JOIN ENROLLMENT
			ON STUDENT.StudentID = ENROLLMENT.EnrollmentID
			JOIN COURSE
			ON COURSE.CourseID = ENROLLMENT.CourseID
			WHERE COURSE.CourseID = @COURSEID
			GROUP BY ENROLLMENT.EnrollmentStatus 
		END

		DECLARE @CNT INT

		EXEC PR_GET_STUDENT_WITH_COUNT 'CS101',@CNT OUTPUT

		SELECT @CNT

--Part – C 

--10.	Create a stored procedure that accepts a year as input and returns all courses assigned to faculty in that year with classroom details.
		CREATE OR ALTER PROC PR_GET_FACULTY_WITH_CLASSROOM
		@YEAR INT
		AS
		BEGIN
			SELECT COURSE.CourseName,
				   FACULTY.FacultyName,
				   COURSE_ASSIGNMENT.YEAR,
				   COURSE_ASSIGNMENT.ClassRoom
			FROM COURSE
			JOIN COURSE_ASSIGNMENT
			ON COURSE.CourseID = COURSE_ASSIGNMENT.CourseID
			JOIN FACULTY
			ON FACULTY.FacultyID = COURSE_ASSIGNMENT.FacultyID
			WHERE COURSE_ASSIGNMENT.YEAR = @YEAR
		END

		EXEC PR_GET_FACULTY_WITH_CLASSROOM 2024
			
--11.	Create a stored procedure that accepts From Date and To Date and returns all enrollments within that range with student and course details.
		CREATE OR ALTER PROC PR_GET_STUDENT_WITH_DATE
		@FROM_DATE DATE,
		@TO_DATE DATE
		AS
		BEGIN
			SELECT STUDENT.StuName,
				   COURSE.CourseName,
				   Enrollment.EnrollmentDate
			FROM STUDENT
			JOIN ENROLLMENT
			ON STUDENT.StudentID = ENROLLMENT.EnrollmentID
			JOIN COURSE
			ON COURSE.CourseID = ENROLLMENT.CourseID
			WHERE EnrollmentDate BETWEEN @FROM_DATE AND @TO_DATE
		END

		EXEC PR_GET_STUDENT_WITH_DATE '2022-01-05','2024-12-31'

		SELECT * FROM STUDENT
		
--12.	Create a stored procedure that accepts FacultyID and calculates their total teaching load (sum of credits of all courses assigned).
	    CREATE OR ALTER PROC PR_GET_FACULTY_WITH_CREDITS
		@FACULTYID  INT
		AS
		BEGIN
			SELECT SUM(CourseCredits) SUM_OF_COUSRE_CREDITS
			FROM COURSE
			JOIN COURSE_ASSIGNMENT
			ON COURSE.CourseID = COURSE_ASSIGNMENT.CourseID
			JOIN FACULTY
			ON FACULTY.FacultyID = COURSE_ASSIGNMENT.FacultyID
			WHERE FACULTY.FacultyID = @FACULTYID
		END

		EXEC PR_GET_FACULTY_WITH_CREDITS 101
