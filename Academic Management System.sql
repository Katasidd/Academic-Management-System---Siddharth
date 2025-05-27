-- 1. Database Creation: 
-- a) Create the StudentInfo table with columns STU_ ID, STU_NAME, DOB, PHONE_NO, EMAIL_ID,ADDRESS.

CREATE TABLE StudentInfo (
    STU_ID INT PRIMARY KEY AUTO_INCREMENT,
    STU_NAME VARCHAR(100) NOT NULL,
    DOB DATE,
    PHONE_NO VARCHAR(15),
    EMAIL_ID VARCHAR(100),
    ADDRESS VARCHAR(255)
);

--- b) Create the CoursesInfo table with columns COURSE_ID, COURSE_NAME,COURSE_INSTRUCTOR NAME. 

CREATE TABLE CoursesInfo (
    COURSE_ID INT PRIMARY KEY AUTO_INCREMENT,
    COURSE_NAME VARCHAR(100) NOT NULL,
    COURSE_INSTRUCTOR_NAME VARCHAR(100)
);

-- c) Create the EnrollmentInfo with columns ENROLLMENT_ID, STU_ ID, COURSE_ID,ENROLL_STATUS(Enrolled/Not Enrolled). 
-- The FOREIGN KEY constraint in the EnrollmentInfo table references the STU_ID column in the StudentInfo table and the COURSE_ID column in the CoursesInfo table.

CREATE TABLE EnrollmentInfo (
    ENROLLMENT_ID INT PRIMARY KEY AUTO_INCREMENT,
    STU_ID INT,
    COURSE_ID INT,
    ENROLL_STATUS ENUM('Enrolled', 'Not Enrolled') NOT NULL DEFAULT 'Enrolled',
    FOREIGN KEY (STU_ID) REFERENCES StudentInfo(STU_ID),
    FOREIGN KEY (COURSE_ID) REFERENCES CoursesInfo(COURSE_ID)
);


-- 2. Data Creation:
-- StudentInfo - 

INSERT INTO StudentInfo (STU_NAME, DOB, PHONE_NO, EMAIL_ID, ADDRESS) VALUES
('Alice Johnson', '2000-05-12', '1234567890', 'alice@example.com', '123 Elm St'),
('Bob Smith', '1999-08-20', '0987654321', 'bob@example.com', '456 Oak Ave'),
('Carol Davis', '2001-01-15', '5551234567', 'carol@example.com', '789 Pine Rd');

-- CourseInfo - 

-- INSERT INTO CoursesInfo (COURSE_NAME, COURSE_INSTRUCTOR_NAME) VALUES
('Database Systems', 'Dr. Emily Clark'),
('Operating Systems', 'Prof. John Doe'),
('Computer Networks', 'Dr. Sarah Lee');

-- EnrollmentInfo -

INSERT INTO EnrollmentInfo (STU_ID, COURSE_ID, ENROLL_STATUS) VALUES
(1, 1, 'Enrolled'),
(1, 2, 'Enrolled'),
(2, 1, 'Enrolled'),
(2, 3, 'Not Enrolled'),
(3, 2, 'Enrolled'),
(3, 3, 'Enrolled');


-- 3) Retrieve the Student Information
-- a) Write a query to retrieve student details, such as student name, contact informations, and Enrollment status.

SELECT
    s.STU_NAME,
    s.PHONE_NO,
    s.EMAIL_ID,
    s.ADDRESS,
    e.ENROLL_STATUS
FROM
    StudentInfo s
JOIN
    EnrollmentInfo e
ON
    s.STU_ID = e.STU_ID;

-- b) Write a query to retrieve a list of courses in which a specific student is enrolled.

SELECT
    s.STU_NAME,
    c.COURSE_NAME,
    e.ENROLL_STATUS
FROM
    StudentInfo s
JOIN
    EnrollmentInfo e ON s.STU_ID = e.STU_ID
JOIN
    CoursesInfo c ON e.COURSE_ID = c.COURSE_ID
WHERE
    s.STU_NAME = 'Siddharth kataria'
    AND e.ENROLL_STATUS = 'Enrolled';

-- c) Write a query to retrieve course information, including course name, instructor information.

SELECT
    COURSE_NAME,
    COURSE_INSTRUCTOR_NAME
FROM
    CoursesInfo;

-- d) Write a query to retrieve course information for a specific course .

SELECT
    COURSE_ID,
    COURSE_NAME,
    COURSE_INSTRUCTOR_NAME
FROM
    CoursesInfo
WHERE 
	COURSE_NAME = 'Selection Central Systems';

-- e) Write a query to retrieve course information for multiple courses.

SELECT
    COURSE_ID,
    COURSE_NAME,
    COURSE_INSTRUCTOR_NAME
FROM
    CoursesInfo
WHERE 
	COURSE_NAME IN ('Selection Central Systems','Data Central Systems');


 -- f. Test the queries to ensure accurate retrieval of student information.( execute the queries and verify the results against the expected output.)

 -- Answer   -   Attached result for all query.

-- 4. Reporting and Analytics (Using joining queries)
-- a) Write a query to retrieve the number of students enrolled in each course

SELECT
	c.COURSE_NAME,
    COUNT(e.STU_ID) AS Number_of_Students
FROM 
	coursesinfo c
JOIN
	enrollmentinfo e ON c.COURSE_ID = e.COURSE_ID
WHERE
	e.ENROLL_STATUS = 'enrolled'
GROUP BY 
	c.COURSE_NAME;

-- b) Write a query to retrieve the list of students enrolled in a specific course

SELECT
    s.STU_NAME,
    s.PHONE_NO,
    s.EMAIL_ID
FROM
    StudentInfo s
JOIN
    EnrollmentInfo e ON s.STU_ID = e.STU_ID
JOIN
    CoursesInfo c ON e.COURSE_ID = c.COURSE_ID
WHERE
    c.COURSE_NAME = 'Data Central Systems'
    AND e.ENROLL_STATUS = 'Enrolled';

-- c) Write a query to retrieve the count of enrolled students for each instructor.

SELECT
    c.COURSE_INSTRUCTOR_NAME,
    COUNT(e.STU_ID) AS Number_of_Students
FROM
    CoursesInfo c
JOIN
    EnrollmentInfo e ON c.COURSE_ID = e.COURSE_ID
WHERE
    e.ENROLL_STATUS = 'Enrolled'
GROUP BY
    c.COURSE_INSTRUCTOR_NAME;

-- d) Write a query to retrieve the list of students who are enrolled in multiple courses

SELECT
	s.STU_ID,
    s.STU_NAME,
    count(e.COURSE_ID) AS Number_of_Courses
FROM 
	studentinfo s
JOIN
	enrollmentinfo e ON s.STU_ID = e.STU_ID
WHERE 
	ENROLL_STATUS = 'Enrolled'
group by 
	s.STU_ID, s.STU_NAME
HAVING 
	count(e.COURSE_ID)>1;

-- e) Write a query to retrieve the courses that have the highest number of enrolled students(arranging from highest to lowest)

SELECT
	c.COURSE_NAME,
    count(e.STU_ID) AS Number_of_Students
FROM 
	coursesinfo c
JOIN
	enrollmentinfo e ON c.COURSE_ID = e.COURSE_ID
WHERE
	ENROLL_STATUS = 'Enrolled'
group by
	c.COURSE_NAME
order by
	Number_of_Students desc;
