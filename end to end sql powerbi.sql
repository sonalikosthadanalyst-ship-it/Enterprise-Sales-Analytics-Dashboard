-- Database agar pehle se hai toh dobara nahi banayega, error nahi aayega
CREATE DATABASE IF NOT EXISTS Hospital_Analytics;
USE Hospital_Analytics;

-- Tables agar pehle se bani hain toh unhe fresh start dene ke liye drop kar rahe hain
DROP TABLE IF EXISTS Fact_Admissions;
DROP TABLE IF EXISTS Dim_Patients;
DROP TABLE IF EXISTS Dim_Doctors;

-- 1. Create Dimension Table for Patients
CREATE TABLE Dim_Patients (
    Patient_ID VARCHAR(10) PRIMARY KEY,
    Age INT,
    Gender VARCHAR(10),
    City VARCHAR(50)
);

-- 2. Create Dimension Table for Doctors
CREATE TABLE Dim_Doctors (
    Doctor_ID VARCHAR(10) PRIMARY KEY,
    Doctor_Name VARCHAR(50),
    Department VARCHAR(50),
    Experience_Years INT
);

-- 3. Create the Fact Table for Admissions
CREATE TABLE Fact_Admissions (
    Admission_ID INT PRIMARY KEY AUTO_INCREMENT,
    Patient_ID VARCHAR(10),
    Doctor_ID VARCHAR(10),
    Admission_Date DATE,
    Discharge_Date DATE,
    Wait_Time_Minutes INT,
    Total_Bill_INR INT,
    FOREIGN KEY (Patient_ID) REFERENCES Dim_Patients(Patient_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Dim_Doctors(Doctor_ID)
);

-- 4. Insert Data into Dim_Patients
INSERT INTO Dim_Patients VALUES 
('P101', 34, 'Male', 'Mumbai'),
('P102', 45, 'Female', 'Noida'),
('P103', 62, 'Male', 'Etawah'),
('P104', 23, 'Female', 'Mumbai'),
('P105', 55, 'Male', 'Delhi'),
('P106', 29, 'Female', 'Noida');

-- 5. Insert Data into Dim_Doctors
INSERT INTO Dim_Doctors VALUES 
('D201', 'Dr. Sharma', 'Cardiology', 12),
('D202', 'Dr. Verma', 'Emergency', 8),
('D203', 'Dr. Iyer', 'Pediatrics', 15),
('D204', 'Dr. Joshi', 'ICU', 10);

-- 6. Insert Data into Fact_Admissions
INSERT INTO Fact_Admissions (Patient_ID, Doctor_ID, Admission_Date, Discharge_Date, Wait_Time_Minutes, Total_Bill_INR) VALUES 
('P101', 'D201', '2026-06-01', '2026-06-05', 45, 120000),
('P102', 'D202', '2026-06-02', '2026-06-02', 15, 15000),
('P103', 'D204', '2026-06-03', '2026-06-12', 90, 350000),
('P104', 'D203', '2026-06-04', '2026-06-06', 20, 45000),
('P105', 'D201', '2026-06-05', '2026-06-15', 60, 280000),
('P106', 'D202', '2026-06-06', '2026-06-07', 35, 25000);
SELECT 
    f.Admission_ID,
    p.Patient_ID,
    p.City,
    d.Doctor_Name,
    d.Department,
    f.Wait_Time_Minutes,
    f.Total_Bill_INR
FROM Fact_Admissions f
JOIN Dim_Patients p ON f.Patient_ID = p.Patient_ID
JOIN Dim_Doctors d ON f.Doctor_ID = d.Doctor_ID;
SELECT * FROM Dim_Patients;