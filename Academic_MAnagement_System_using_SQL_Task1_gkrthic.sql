--1. Database Creation


 --StudentInfo table
CREATE TABLE StudentInfo (
    STU_ID INT PRIMARY KEY,
    STU_NAME VARCHAR(100),
    DOB DATE,
    PHONE_NO VARCHAR(15),
    EMAIL_ID VARCHAR(100),
    ADDRESS VARCHAR(255)
);

--CoursesInfo table
CREATE TABLE CoursesInfo (
    COURSE_ID INT PRIMARY KEY,
    COURSE_NAME VARCHAR(100),
    COURSE_INSTRUCTOR_NAME VARCHAR(100)
);
--EnrollmentInfo table
CREATE TABLE EnrollmentInfo (
    ENROLLMENT_ID INT PRIMARY KEY,
    STU_ID INT,
    COURSE_ID INT,
    ENROLL_STATUS VARCHAR(50),
    FOREIGN KEY (STU_ID) REFERENCES StudentInfo(STU_ID),
    FOREIGN KEY (COURSE_ID) REFERENCES CoursesInfo(COURSE_ID)
);

--2.Data creation

INSERT INTO StudentInfo (STU_ID, STU_NAME, DOB, PHONE_NO, EMAIL_ID, ADDRESS)
VALUES
(1, 'Bruce Wayne', '1980-05-27', '123-456-7890', 'bruce.wayne@waynecorp.com', 'Wayne Manor, Gotham'),
(2, 'Clark Kent', '1978-06-18', '987-654-3210', 'clark.kent@dailyplanet.com', 'Metropolis'),
(3, 'Diana Prince', '1984-03-22', '555-666-7777', 'diana.prince@themiscira.com', 'Themyscira'),
(4, 'Barry Allen', '1992-09-20', '333-444-5555', 'barry.allen@ccpd.com', 'Central City'),
(5, 'Arthur Curry', '1985-01-29', '222-333-4444', 'arthur.curry@atlantis.com', 'Atlantis');

INSERT INTO CoursesInfo (COURSE_ID, COURSE_NAME, COURSE_INSTRUCTOR_NAME)
VALUES
(101, 'Combat Training', 'Oliver Queen'),
(102, 'Advanced Physics', 'Ray Palmer'),
(103, 'Mythology', 'Hippolyta'),
(104, 'Forensics', 'Iris West'),
(105, 'Marine Biology', 'Mera');

INSERT INTO EnrollmentInfo (ENROLLMENT_ID, STU_ID, COURSE_ID, ENROLL_STATUS)
VALUES
(1, 1, 101, 'Enrolled'),
(2, 2, 102, 'Enrolled'),
(3, 3, 103, 'Enrolled'),
(4, 4, 104, 'Enrolled'),
(5, 5, 105, 'Enrolled'),
(6, 1, 103, 'Enrolled'),
(7, 2, 101, 'Not Enrolled'),
(8, 3, 102, 'Enrolled'),
(9, 4, 101, 'Enrolled'),
(10, 5, 102, 'Not Enrolled');

--3.Information retreival

--a.Retrieve student details such as student name, contact information, and enrollment status
SELECT STU_NAME, PHONE_NO, EMAIL_ID, ENROLL_STATUS
FROM StudentInfo SI
JOIN EnrollmentInfo EI ON SI.STU_ID = EI.STU_ID;
--b.Query to Retrieve List of Courses for a Specific Student
--retreiving details for Bruce Wayne

SELECT C.COURSE_NAME, C.COURSE_INSTRUCTOR_NAME
FROM EnrollmentInfo E
JOIN CoursesInfo C ON E.COURSE_ID = C.COURSE_ID
WHERE E.STU_ID = (SELECT STU_ID FROM StudentInfo WHERE STU_NAME = 'Bruce Wayne');

--c.Query to Retrieve Course Information Including Course name and Instructor Information
SELECT COURSE_NAME, COURSE_INSTRUCTOR_NAME
FROM CoursesInfo;
--d.Query to Retrieve Course Information for a Specific Course
--Retrieve course information for 'Combat Training'
SELECT COURSE_NAME, COURSE_INSTRUCTOR_NAME
FROM CoursesInfo
WHERE COURSE_NAME = 'Combat Training';

--e.Query to Retrieve Course Information for Multiple Courses

SELECT COURSE_NAME, COURSE_INSTRUCTOR_NAME
FROM CoursesInfo
WHERE COURSE_NAME IN ('Combat Training', 'Mythology');
--4. Reporting and Analysis
--a.Query to Retrieve the Number of Students Enrolled in Each Course
SELECT C.COURSE_NAME, COUNT(E.STU_ID) AS NumberOfStudents
FROM CoursesInfo C
LEFT JOIN EnrollmentInfo E ON C.COURSE_ID = E.COURSE_ID
GROUP BY C.COURSE_NAME;

--b.Query to Retrieve the List of Students Enrolled in a Specific Course
SELECT S.STU_NAME
FROM StudentInfo S
JOIN EnrollmentInfo E ON S.STU_ID = E.STU_ID
WHERE E.COURSE_ID = (SELECT COURSE_ID FROM CoursesInfo WHERE COURSE_NAME = 'Combat Training');

--c.Query to Retrieve the Count of Enrolled Students for Each Instructor

SELECT C.COURSE_INSTRUCTOR_NAME, COUNT(E.STU_ID) AS NumberOfStudents
FROM CoursesInfo C
LEFT JOIN EnrollmentInfo E ON C.COURSE_ID = E.COURSE_ID
GROUP BY C.COURSE_INSTRUCTOR_NAME;

--d.Query to Retrieve the List of Students Enrolled in Multiple Courses

SELECT S.STU_NAME, COUNT(E.COURSE_ID) AS NumberOfCourses
FROM StudentInfo S
JOIN EnrollmentInfo E ON S.STU_ID = E.STU_ID
GROUP BY S.STU_NAME
HAVING COUNT(E.COURSE_ID) > 1;

--e.Query to Retrieve the Courses with the Highest Number of Enrolled Students
SELECT C.COURSE_NAME, COUNT(E.STU_ID) AS NumberOfStudents
FROM CoursesInfo C
LEFT JOIN EnrollmentInfo E ON C.COURSE_ID = E.COURSE_ID
GROUP BY C.COURSE_NAME
ORDER BY NumberOfStudents DESC;

