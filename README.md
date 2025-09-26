# 🏢 HR Management System

📌 **Project Overview**

The HR Recruitment Management System is a **comprehensive SQL database project** designed to manage the **end-to-end hiring lifecycle**. It supports everything from job postings and candidate applications to interviews, tests, onboarding, reimbursements, and background checks.

The project demonstrates:

* **Database schema design (ERD)** for HR recruitment workflows
* **Advanced SQL features** including views, functions, stored procedures, triggers, and transactions
* **Reports & analytics** to monitor recruitment performance

---

## 📂 Repository Contents

* **HR_Management_System_ERD.sql** → Schema-only file with tables and relationships
* **HR_Management_System.sql** → Full database implementation with constraints, sample data, views, procedures, triggers, and reports

---

## 🔄 Database Workflow

### **1. Schema Design (ERD)**

Core entities include:

* **JobCategory** → Defines job sectors
* **JobPlatform** → Sources where jobs are posted
* **Job / JobOpenings** → Positions and available openings
* **Candidates / Documents** → Candidate information and documents (e.g., CVs)
* **Applications** → Applications submitted by candidates
* **Interviews & Interviewers** → Scheduling and managing interviews
* **Tests / DrugTests / BackgroundChecks** → Candidate evaluations
* **Onboarding** → Managing hired candidates
* **Evaluation / Review / Complaint** → Quality and feedback processes
* **Reimbursement** → Candidate reimbursements for expenses

---

### **2. Core SQL Features**

* **Views**

  * `CandidateStatusView` → Candidate contact info + application status
  * `JobOpeningView` → Current job openings and positions
  * `InterviewScheduleView` → Candidate interviews with schedules
  * `ReimbursementSummary` → Total reimbursements per candidate

* **Stored Procedures**

  * `InsertCandidate` → Add new candidates
  * `ExtendOffer` → Extend offers and update job openings
  * `GetCandidateStatus` → Check application status of a candidate
  * `UpdateInterviewSchedule` → Reschedule interviews

* **Functions**

  * `CalculateTotalReimbursementAmount` → Sum reimbursements for a candidate
  * `GetJobOpeningDetails` → Get detailed job opening info
  * `IsCandidateBlacklisted` → Check if a candidate is blacklisted

* **Triggers**

  * `UpdateJobOpeningsOnOffer` → Auto-update job openings when offers are extended
  * `UpdateCandidateStatusOnReview` → Mark candidate as “Under Review” after review submission
  * `CheckInterviewConflict` → Prevent double-booking of interviews
  * `UpdateJobOpeningsOnBlacklist` → Free up openings if a candidate is blacklisted

* **Transactions**

  * Candidate + Application insert
  * Extend job offer
  * Update interview schedule
  * Blacklist candidate

---

## 📊 Reports & Analytics

The system includes SQL scripts to generate:

* 📈 Yearly growth of applications
* 📊 Offer vs. acceptance breakdown
* ⏳ Average recruitment process time
* 🔎 Recruitment stage analysis
* 📅 Monthly job application trends (Top 3 jobs per month)
* 📌 Job performance by openings
* 🕒 Interview schedule analysis by hour

---

## 📈 Applications

* 🏢 **HR Departments** → Manage recruitment pipelines
* 💼 **Recruitment Agencies** → Track candidates, clients, and job openings
* 🎓 **Campus Hiring** → Streamline student applications and onboarding
* 📊 **Business Analytics** → Generate insights into hiring trends

---

## 🛠️ Tools & Technologies

* **SQL Server / Azure SQL Database**
* **T-SQL** (DDL, DML, Views, Functions, Procedures, Triggers, Transactions)
* **ERD Modeling** for relational design

---

