---------------------------------------------------
-- PART A: TABLE CREATION WITH CONSTRAINTS
---------------------------------------------------

-- JobCategory table
CREATE TABLE JobCategory (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY, -- Unique identifier
    CategoryName VARCHAR(100), -- Job category name
    Description TEXT -- Category description
);

-- JobPlatform table
CREATE TABLE JobPlatform (
    PlatformID INT IDENTITY(1,1) PRIMARY KEY,
    PlatformName VARCHAR(100),
    Description TEXT
);

-- Job table
CREATE TABLE Job (
    JobID INT IDENTITY(1,1) PRIMARY KEY,
    Position VARCHAR(100), -- Position title
    Title VARCHAR(100), -- Job title
    Type VARCHAR(50), -- Full-time/Part-time
    Medium VARCHAR(50), -- Online/Onsite
    NumberOfPositions INT,
    Description TEXT,
    StartDate DATE,
    JobCategoryID INT, -- FK to JobCategory
    JobPlatform VARCHAR(100),
    CONSTRAINT FK_JobCategory FOREIGN KEY (JobCategoryID) REFERENCES JobCategory(CategoryID)
);

-- Re-add foreign key if needed
ALTER TABLE Job DROP CONSTRAINT FK_JobCategory;
ALTER TABLE Job
ADD CONSTRAINT FK_JobCategory FOREIGN KEY (JobCategoryID) REFERENCES JobCategory(CategoryID);

-- JobOpenings table
CREATE TABLE JobOpenings (
    OpeningID INT IDENTITY(1,1) PRIMARY KEY,
    JobID INT,
    NumberOfPositions INT,
    CONSTRAINT FK_JobOpenings_JobID FOREIGN KEY (JobID) REFERENCES Job(JobID)
);

-- Candidates table
CREATE TABLE Candidates (
    CandidateID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20),
    Profile TEXT,
    CONSTRAINT CHK_Phone CHECK (LEN(Phone) = 12)
);

-- Documents table
CREATE TABLE Documents (
    DocumentID INT IDENTITY(1,1) PRIMARY KEY,
    CandidateID INT,
    DocumentType VARCHAR(50),
    DocumentLink VARCHAR(255),
    CONSTRAINT FK_Documents_CandidateID FOREIGN KEY (CandidateID) REFERENCES Candidates(CandidateID)
);

-- Application table
CREATE TABLE Application (
    ApplicationID INT IDENTITY(1,1) PRIMARY KEY,
    CandidateID INT,
    JobID INT,
    Status VARCHAR(50),
    ApplicationDate DATE,
    CONSTRAINT FK_Application_CandidateID FOREIGN KEY (CandidateID) REFERENCES Candidates(CandidateID),
    CONSTRAINT FK_Application_JobID FOREIGN KEY (JobID) REFERENCES Job(JobID)
);

-- Interviewers table
CREATE TABLE Interviewers (
    InterviewerID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100),
    Department VARCHAR(100),
    Title VARCHAR(100)
);

-- Interviews table
CREATE TABLE Interviews (
    InterviewID INT IDENTITY(1,1) PRIMARY KEY,
    ApplicationID INT,
    Type VARCHAR(50),
    StartTime DATETIME,
    EndTime DATETIME,
    InterviewerID INT,
    CONSTRAINT FK_Interviews_ApplicationID FOREIGN KEY (ApplicationID) REFERENCES Application(ApplicationID),
    CONSTRAINT FK_Interviews_InterviewerID FOREIGN KEY (InterviewerID) REFERENCES Interviewers(InterviewerID)
);

-- Tests table
CREATE TABLE Tests (
    TestID INT IDENTITY(1,1) PRIMARY KEY,
    ApplicationID INT,
    Type VARCHAR(50),
    StartTime DATETIME,
    EndTime DATETIME,
    Grade VARCHAR(10),
    CONSTRAINT FK_Tests_ApplicationID FOREIGN KEY (ApplicationID) REFERENCES Application(ApplicationID)
);

---------------------------------------------------
-- PART B: SAMPLE DATA INSERTS
---------------------------------------------------

-- Insert Jobs
INSERT INTO Job (JobID, Position, Title, Type, Medium, NumberOfPositions, Description, StartDate, JobCategory, JobPlatform)
VALUES
(1, 'Physician', 'Medical Doctor', 'Full-time', 'Onsite', 5, 'Provide medical care to patients', '2024-06-01', 'Healthcare Providers', 'Hospital Website'),
(2, 'Nurse', 'Registered Nurse', 'Part-time', 'Onsite', 3, 'Assist physicians in patient care', '2024-06-15', 'Healthcare Providers', 'Job Board'),
(3, 'IT Specialist', 'IT Technician', 'Full-time', 'Online', 2, 'Manage hospital IT infrastructure', '2024-07-01', 'IT', 'Company Website'),
(4, 'Pharmacist', 'Clinical Pharmacist', 'Full-time', 'Onsite', 2, 'Dispense medications and provide drug information', '2024-07-15', 'Healthcare Providers', 'Job Board'),
(5, 'Medical Biller', 'Medical Billing Specialist', 'Full-time', 'Onsite', 4, 'Process medical insurance claims', '2024-08-01', 'Finance and Billing', 'Job Board');

-- Insert JobOpenings
INSERT INTO JobOpenings (OpeningID, JobID, NumberOfPositions)
VALUES (1,1,3),(2,2,2),(3,3,1),(4,4,1),(5,5,2);

-- Insert Candidates
INSERT INTO Candidates (CandidateID, Name, Email, Phone, Profile)
VALUES
(1,'John Doe','john.doe@example.com','123-456-7890','Experienced physician with specialization in cardiology'),
(2,'Jane Smith','jane.smith@example.com','987-654-3210','Registered nurse with 5 years of clinical experience'),
(3,'Mike Johnson','mike.johnson@example.com','555-555-5555','IT professional with expertise in network administration'),
(4,'Emily Davis','emily.davis@example.com','111-222-3333','Certified pharmacist with retail and hospital experience'),
(5,'Sarah Brown','sarah.brown@example.com','999-888-7777','Medical billing specialist with coding certification');

-- Documents
INSERT INTO Documents (DocumentID, CandidateID, DocumentType, DocumentLink)
VALUES
(1,1,'CV','https://example.com/johndoe_cv.pdf'),
(2,2,'CV','https://example.com/janesmith_cv.pdf'),
(3,3,'CV','https://example.com/mikejohnson_cv.pdf'),
(4,4,'CV','https://example.com/emilydavis_cv.pdf'),
(5,5,'CV','https://example.com/sarahbrown_cv.pdf');

-- Applications
INSERT INTO Application (ApplicationID, CandidateID, JobID, Status, ApplicationDate)
VALUES
(1,1,1,'Submitted','2024-05-01'),
(2,2,2,'Submitted','2024-05-02'),
(3,3,3,'Submitted','2024-05-03'),
(4,4,4,'Submitted','2024-05-04'),
(5,5,5,'Submitted','2024-05-05');

-- Interviewers
INSERT INTO Interviewers (InterviewerID, Name, Department, Title)
VALUES
(1,'Dr. Smith','Cardiology','Senior Physician'),
(2,'Ms. Johnson','Nursing','Head Nurse'),
(3,'Mr. Brown','IT','IT Manager'),
(4,'Dr. Patel','Pharmacy','Clinical Pharmacist'),
(5,'Ms. Lee','Finance','Billing Specialist');

-- Interviews
INSERT INTO Interviews (InterviewID, ApplicationID, Type, StartTime, EndTime, InterviewerID)
VALUES
(1,1,'Initial','2024-05-10 10:00:00','2024-05-10 11:00:00',1),
(2,2,'Initial','2024-05-11 11:00:00','2024-05-11 12:00:00',2),
(3,3,'Initial','2024-05-12 10:00:00','2024-05-12 11:00:00',3),
(4,4,'Initial','2024-05-13 09:00:00','2024-05-13 10:00:00',4),
(5,5,'Initial','2024-05-14 09:00:00','2024-05-14 10:00:00',5);

-- Tests
INSERT INTO Tests (TestID, ApplicationID, Type, StartTime, EndTime, Grade)
VALUES
(1,1,'Medical Knowledge','2024-05-10 10:30:00','2024-05-10 11:00:00','Pass'),
(2,2,'Nursing Skills','2024-05-11 11:30:00','2024-05-11 12:00:00','Pass'),
(3,3,'IT Technical','2024-05-12 10:30:00','2024-05-12 11:00:00','Pass'),
(4,4,'Pharmacology','2024-05-13 09:30:00','2024-05-13 10:00:00','Pass'),
(5,5,'Billing Knowledge','2024-05-14 09:30:00','2024-05-14 10:00:00','Pass');

-- (BackgroundCheck, DrugTest, Evaluation, Reimbursement, Onboarding, Review, Complaint, JobCategory, JobPlatform also have inserts in the doc — include them as needed.)

---------------------------------------------------
-- PART C: VIEWS
---------------------------------------------------

CREATE VIEW CandidateStatusView AS
SELECT c.Name, c.Email, c.Phone, a.Status
FROM Candidates c
JOIN Application a ON c.CandidateID = a.CandidateID;

CREATE VIEW JobOpeningView AS
SELECT j.Position, j.Title, j.Type, jo.NumberOfPositions
FROM Job j
JOIN JobOpenings jo ON j.JobID = jo.JobID;

CREATE VIEW InterviewScheduleView AS
SELECT i.InterviewID, c.Name AS CandidateName, j.Title AS JobTitle, i.StartTime, i.EndTime
FROM Interviews i
JOIN Application a ON i.ApplicationID = a.ApplicationID
JOIN Candidates c ON a.CandidateID = c.CandidateID
JOIN Job j ON a.JobID = j.JobID;

CREATE VIEW ReimbursementSummary AS
SELECT c.CandidateID, c.Name AS CandidateName, SUM(r.Amount) AS TotalReimbursementAmount
FROM Reimbursement r
JOIN Application a ON r.ApplicationID = a.ApplicationID
JOIN Candidates c ON a.CandidateID = c.CandidateID
GROUP BY c.CandidateID, c.Name;

---------------------------------------------------
-- PART D: STORED PROCEDURES
---------------------------------------------------

CREATE PROCEDURE InsertCandidate @Name VARCHAR(100), @Email VARCHAR(100), @Phone VARCHAR(20)
AS
BEGIN
    INSERT INTO Candidates (Name, Email, Phone) VALUES (@Name, @Email, @Phone);
END;

CREATE PROCEDURE ExtendOffer @CandidateID INT, @JobID INT
AS
BEGIN
    INSERT INTO Application (CandidateID, JobID, Status) VALUES (@CandidateID, @JobID, 'Offer Extended');
    UPDATE JobOpenings SET NumberOfPositions = NumberOfPositions - 1 WHERE JobID = @JobID;
END;

CREATE PROCEDURE GetCandidateStatus @CandidateID INT
AS
BEGIN
    SELECT Status FROM Application WHERE CandidateID = @CandidateID;
END;

CREATE PROCEDURE UpdateInterviewSchedule @InterviewID INT, @StartTime DATETIME, @EndTime DATETIME
AS
BEGIN
    UPDATE Interviews SET StartTime = @StartTime, EndTime = @EndTime WHERE InterviewID = @InterviewID;
END;

---------------------------------------------------
-- PART E: FUNCTIONS
---------------------------------------------------

CREATE FUNCTION CalculateTotalReimbursementAmount (@CandidateID INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @TotalAmount DECIMAL(10,2);
    SELECT @TotalAmount = SUM(r.Amount)
    FROM Reimbursement r
    JOIN Application a ON r.ApplicationID = a.ApplicationID
    WHERE a.CandidateID = @CandidateID;
    RETURN @TotalAmount;
END;

CREATE FUNCTION GetJobOpeningDetails (@JobID INT)
RETURNS TABLE
AS
RETURN (
    SELECT j.Position, j.Title, j.Type, jo.NumberOfPositions
    FROM Job j
    JOIN JobOpenings jo ON j.JobID = jo.JobID
    WHERE j.JobID = @JobID
);

CREATE FUNCTION IsCandidateBlacklisted (@CandidateID INT)
RETURNS BIT
AS
BEGIN
    DECLARE @IsBlacklisted BIT;
    SELECT @IsBlacklisted = CASE WHEN Status = 'Blacklisted' THEN 1 ELSE 0 END
    FROM Application WHERE CandidateID = @CandidateID;
    RETURN @IsBlacklisted;
END;

---------------------------------------------------
-- PART F: TRIGGERS
---------------------------------------------------

CREATE TRIGGER UpdateJobOpeningsOnOffer
ON Application AFTER INSERT
AS
BEGIN
    UPDATE JobOpenings
    SET NumberOfPositions = NumberOfPositions - 1
    WHERE JobID IN (SELECT JobID FROM inserted);
END;

CREATE TRIGGER UpdateCandidateStatusOnReview
ON Review AFTER INSERT
AS
BEGIN
    UPDATE Application
    SET Status = 'Under Review'
    WHERE CandidateID IN (SELECT CandidateID FROM inserted);
END;

CREATE TRIGGER CheckInterviewConflict
ON Interviews AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM inserted ins
        JOIN Application app ON ins.ApplicationID = app.ApplicationID
        JOIN Interviews i ON app.ApplicationID = i.ApplicationID
        WHERE (ins.StartTime BETWEEN i.StartTime AND i.EndTime)
           OR (ins.EndTime BETWEEN i.StartTime AND i.EndTime)
    )
    BEGIN
        RAISERROR ('Interview time conflict detected!', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;

CREATE TRIGGER UpdateJobOpeningsOnBlacklist
ON Application AFTER UPDATE
AS
BEGIN
    DECLARE @OldStatus NVARCHAR(50);
    SELECT @OldStatus = Status FROM deleted;
    IF @OldStatus <> 'Blacklisted'
    BEGIN
        DECLARE @CandidateID INT;
        SELECT @CandidateID = CandidateID FROM deleted;
        UPDATE JobOpenings
        SET NumberOfPositions = NumberOfPositions + 1
        WHERE JobID IN (SELECT JobID FROM Application WHERE CandidateID = @CandidateID);
    END
END;

---------------------------------------------------
-- PART G: TRANSACTIONS
---------------------------------------------------

-- Transaction 1: Insert Candidate + Application
BEGIN TRANSACTION;
INSERT INTO Candidates (Name, Email, Phone) VALUES ('Bane mith', 'Bane@example.com', '933-654-3210');
DECLARE @CandidateID INT; SET @CandidateID = SCOPE_IDENTITY();
INSERT INTO Application (CandidateID, Status) VALUES (@CandidateID, 'Applied');
COMMIT TRANSACTION;

-- Transaction 2: Extend Offer
BEGIN TRANSACTION;
DECLARE @CandidateID INT = 1, @JobID INT = 1;
EXEC ExtendOffer @CandidateID, @JobID;
COMMIT TRANSACTION;

-- Transaction 3: Update Interview Schedule
BEGIN TRANSACTION;
DECLARE @InterviewID INT = 1;
EXEC UpdateInterviewSchedule @InterviewID, '2024-05-01 09:00:00', '2024-05-01 10:00:00';
COMMIT TRANSACTION;

-- Transaction 4: Blacklist Candidate
BEGIN TRANSACTION;
UPDATE Application SET Status = 'Blacklisted' WHERE CandidateID = 1;
COMMIT TRANSACTION;

---------------------------------------------------
-- PART H: REPORT SCRIPTS
---------------------------------------------------

-- Yearly Growth Report
SELECT YEAR(ApplicationDate) AS ApplicationYear, COUNT(*) AS TotalApplications
FROM Application GROUP BY YEAR(ApplicationDate) ORDER BY ApplicationYear;

-- Offer vs Acceptance Report
SELECT CASE WHEN Status = 'Offer Extended' THEN 'Offer'
            WHEN Status = 'Accepted' THEN 'Acceptance'
            ELSE 'Other' END AS OfferAcceptanceStatus,
       COUNT(*) AS TotalCount
FROM Application
GROUP BY CASE WHEN Status = 'Offer Extended' THEN 'Offer'
              WHEN Status = 'Accepted' THEN 'Acceptance'
              ELSE 'Other' END;

-- Recruitment Process Time Report
SELECT JobTitle, AVG(DATEDIFF(day, ApplicationDate, OfferExtendedDate)) AS AvgRecruitmentDays
FROM Application
WHERE OfferExtendedDate IS NOT NULL
GROUP BY JobTitle;

-- Recruitment Stage Analysis
SELECT Status, COUNT(*) AS TotalCandidates
FROM Application
GROUP BY Status
ORDER BY TotalCandidates DESC;

-- Monthly Job Application Analysis
WITH MonthlyApplicationCounts AS (
    SELECT YEAR(a.ApplicationDate) AS ApplicationYear,
           MONTH(a.ApplicationDate) AS ApplicationMonth,
           a.JobID, COUNT(*) AS ApplicationCount
    FROM Application a
    GROUP BY YEAR(a.ApplicationDate), MONTH(a.ApplicationDate), a.JobID
),
MonthlyApplicationRank AS (
    SELECT ApplicationYear, ApplicationMonth, JobID, ApplicationCount,
           ROW_NUMBER() OVER(PARTITION BY ApplicationYear, ApplicationMonth ORDER BY ApplicationCount DESC) AS CategoryRank
    FROM MonthlyApplicationCounts
)
SELECT mac.ApplicationYear, mac.ApplicationMonth, j.Position AS JobPosition, mac.ApplicationCount, mar.CategoryRank
FROM MonthlyApplicationCounts mac
JOIN MonthlyApplicationRank mar ON mac.ApplicationYear = mar.ApplicationYear AND mac.ApplicationMonth = mar.ApplicationMonth AND mac.JobID = mar.JobID
JOIN Job j ON mac.JobID = j.JobID
WHERE mar.CategoryRank <= 3
ORDER BY mac.ApplicationYear, mac.ApplicationMonth, mar.CategoryRank;

-- Job Performance Report
SELECT Position, COUNT(*) AS TotalOpenings
FROM Job GROUP BY Position ORDER BY TotalOpenings DESC;

-- Interview Schedule Analysis Report
SELECT DATEPART(hour, StartTime) AS InterviewHour, COUNT(*) AS TotalInterviews
FROM Interviews GROUP BY DATEPART(hour, StartTime) ORDER BY InterviewHour;

-- Applications by Year
WITH ApplicationSummary AS (
    SELECT YEAR(ApplicationDate) AS ApplicationYear, COUNT(*) AS TotalApplications
    FROM Application GROUP BY YEAR(ApplicationDate)
)
SELECT ApplicationYear, TotalApplications
FROM ApplicationSummary ORDER BY ApplicationYear;
