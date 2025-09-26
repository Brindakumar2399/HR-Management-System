-- EduTrackDB_Project2 SQL Script
-- Author: Brinda Upendra Kumar

-- =======================
-- 1. TABLE CREATION
-- =======================

-- Students table to track student info, year, and tuition
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100),
    Program VARCHAR(50),
    Year INT,
    TuitionFee DECIMAL(10,2)
);

-- Instructors table to store instructor info and salary
CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY,
    InstructorName VARCHAR(100),
    Department VARCHAR(100),
    Salary DECIMAL(10,2)
);

-- Courses table storing all course details and instructor link
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    Units INT,
    InstructorID INT FOREIGN KEY REFERENCES Instructors(InstructorID)
);

-- Enrollments table to link students to courses
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT FOREIGN KEY REFERENCES Students(StudentID),
    CourseID INT FOREIGN KEY REFERENCES Courses(CourseID)
);

-- =======================
-- 2. SAMPLE QUERIES
-- =======================

-- View: Student tuition by year
CREATE VIEW TuitionByYear AS
SELECT Year, AVG(TuitionFee) AS AvgTuition
FROM Students
GROUP BY Year;

-- Function: Full-time or part-time classification
CREATE FUNCTION GetStudentStatus(@studentId INT)
RETURNS VARCHAR(10)
AS
BEGIN
    DECLARE @totalUnits INT
    SELECT @totalUnits = SUM(c.Units)
    FROM Enrollments e
    JOIN Courses c ON e.CourseID = c.CourseID
    WHERE e.StudentID = @studentId

    IF @totalUnits >= 9
        RETURN 'Full-time'
    RETURN 'Part-time'
END;

-- Procedure: Update instructor salary based on course load
CREATE PROCEDURE UpdateInstructorSalary
    @InstructorID INT
AS
BEGIN
    DECLARE @courseCount INT
    SELECT @courseCount = COUNT(*) FROM Courses WHERE InstructorID = @InstructorID

    UPDATE Instructors
    SET Salary = Salary + (@courseCount * 500)
    WHERE InstructorID = @InstructorID
END;

-- Trigger: Auto-calculate tuition when new student added
CREATE TRIGGER trg_AutoCalculateTuition
ON Students
AFTER INSERT
AS
BEGIN
    UPDATE s
    SET s.TuitionFee = CASE 
                          WHEN s.Program = 'MS' THEN 20000
                          WHEN s.Program = 'PhD' THEN 10000
                          ELSE 15000
                      END
    FROM Students s
    JOIN inserted i ON s.StudentID = i.StudentID
END;

-- End of Script
