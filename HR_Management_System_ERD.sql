-- EduTrackDB_Project2 ERD Schema Script

-- Students: StudentID → Program, Year, Tuition
-- Instructors: InstructorID → Department, Salary
-- Courses: CourseID → Units, InstructorID (FK)
-- Enrollments: EnrollmentID → StudentID (FK), CourseID (FK)

-- Relationships:
-- - Each student can enroll in many courses (Enrollments)
-- - Each instructor can teach many courses
-- - Each course belongs to one instructor
-- - Tuition calculated based on program via trigger

-- Designed for academic analytics, tuition tracking, and instructor load evaluation.
