-- HR Recruitment Management System ERD Schema

-- Job Category
CREATE TABLE JobCategory (
    CategoryID INT PRIMARY KEY,
    Category VARCHAR(100),
    Description TEXT
);

-- Job Platform
CREATE TABLE JobPlatform (
    PlatformID INT PRIMARY KEY,
    JobID INT FOREIGN KEY REFERENCES Job(JobID),
    PlatformName VARCHAR(100),
    Description TEXT
);

-- Job
CREATE TABLE Job (
    JobID INT PRIMARY KEY,
    Title VARCHAR(100),
    Type VARCHAR(50),
    Medium VARCHAR(50),
    NumberOfPositions INT,
    Description TEXT,
    StartDate DATE,
    Category INT FOREIGN KEY REFERENCES JobCategory(CategoryID),
    Platform INT FOREIGN KEY REFERENCES JobPlatform(PlatformID)
);

-- Job Openings
CREATE TABLE JobOpenings (
    JobOpeningID INT PRIMARY KEY,
    JobID INT FOREIGN KEY REFERENCES Job(JobID),
    NumberOfPositions INT
);

-- Candidates
CREATE TABLE Candidates (
    CandidateID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Profile TEXT
);

-- Applications
CREATE TABLE Applications (
    ApplicationID INT PRIMARY KEY,
    CandidateID INT FOREIGN KEY REFERENCES Candidates(CandidateID),
    JobOpeningID INT FOREIGN KEY REFERENCES JobOpenings(JobOpeningID),
    Date DATE,
    Status VARCHAR(50)
);

-- Documents
CREATE TABLE Documents (
    DocumentID INT PRIMARY KEY,
    CandidateID INT FOREIGN KEY REFERENCES Candidates(CandidateID),
    Type VARCHAR(50),
    FileLink VARCHAR(255)
);

-- Onboarding
CREATE TABLE Onboarding (
    OnboardingID INT PRIMARY KEY,
    CandidateID INT FOREIGN KEY REFERENCES Candidates(CandidateID),
    JobOpeningID INT FOREIGN KEY REFERENCES JobOpenings(JobOpeningID),
    StartDate DATE,
    EndDate DATE,
    Status VARCHAR(50)
);

-- Interviews
CREATE TABLE Interviews (
    InterviewID INT PRIMARY KEY,
    ApplicationID INT FOREIGN KEY REFERENCES Applications(ApplicationID),
    Type VARCHAR(50),
    StartTime DATETIME,
    EndTime DATETIME
);

-- Interviewers
CREATE TABLE Interviewers (
    InterviewerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Department VARCHAR(100),
    Title VARCHAR(100)
);

-- Evaluation
CREATE TABLE Evaluation (
    EvaluationID INT PRIMARY KEY,
    ApplicationID INT FOREIGN KEY REFERENCES Applications(ApplicationID),
    Notes TEXT,
    Result VARCHAR(50)
);

-- Tests
CREATE TABLE Tests (
    TestID INT PRIMARY KEY,
    CandidateID INT FOREIGN KEY REFERENCES Candidates(CandidateID),
    Type VARCHAR(50),
    StartTime DATETIME,
    EndTime DATETIME,
    Answers TEXT,
    Grade VARCHAR(10)
);

-- Drug Tests
CREATE TABLE DrugTest (
    TestID INT PRIMARY KEY,
    CandidateID INT FOREIGN KEY REFERENCES Candidates(CandidateID),
    Type VARCHAR(50),
    Date DATE,
    Result VARCHAR(50)
);

-- Background Check
CREATE TABLE BackgroundCheck (
    CheckID INT PRIMARY KEY,
    CandidateID INT FOREIGN KEY REFERENCES Candidates(CandidateID),
    Status VARCHAR(50),
    Date DATE
);

-- Review
CREATE TABLE Review (
    ReviewID INT PRIMARY KEY,
    CandidateID INT FOREIGN KEY REFERENCES Candidates(CandidateID),
    ReviewerID INT,
    ReviewerType VARCHAR(50),
    ReviewType VARCHAR(50),
    ReviewText TEXT,
    Rating INT,
    ReviewDate DATE
);

-- Complaint
CREATE TABLE Complaint (
    ComplaintID INT PRIMARY KEY,
    CandidateID INT FOREIGN KEY REFERENCES Candidates(CandidateID),
    ComplaintText TEXT,
    ComplaintDate DATE,
    Status VARCHAR(50),
    ResolutionDate DATE
);

-- Reimbursement
CREATE TABLE Reimbursement (
    ReimbursementID INT PRIMARY KEY,
    ApplicationID INT FOREIGN KEY REFERENCES Applications(ApplicationID),
    Type VARCHAR(50),
    Amount DECIMAL(10,2),
    Status VARCHAR(50)
);
