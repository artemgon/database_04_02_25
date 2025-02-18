CREATE DATABASE HOSPITAL;
GO

USE HOSPITAL;
GO

CREATE TABLE Departments (
    DepartmentID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    DepartmentBuilding INT NOT NULL CHECK (DepartmentBuilding >= 1 AND DepartmentBuilding <= 5),
    DepartmentFinancing MONEY NOT NULL CHECK (DepartmentFinancing > 0),
    DepartmentName NVARCHAR(100) NOT NULL CHECK (LEN(TRIM(DepartmentName)) > 0) UNIQUE
)
GO

CREATE TABLE Diseases(
    DiseaseID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    DiseaseName NVARCHAR(100) NOT NULL CHECK (LEN(TRIM(DiseaseName)) > 0) UNIQUE,
    DiseaseSeverity INT NOT NULL CHECK (DiseaseSeverity >= 1) DEFAULT 1
)
GO

CREATE TABLE Doctors(
    DoctorID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    DoctorName NVARCHAR(MAX) NOT NULL CHECK (LEN(TRIM(DoctorName)) > 0),
    DoctorPhone CHAR(10) NOT NULL CHECK (DoctorPhone LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    DoctorSalary MONEY NOT NULL CHECK (DoctorSalary > 0),
    DoctorSurname NVARCHAR(MAX) NOT NULL CHECK (LEN(TRIM(DoctorSurname)) > 0)
)
GO

CREATE TABLE Examinations(
    ExaminationID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    ExaminationDayOfWeek INT NOT NULL CHECK (ExaminationDayOfWeek >= 1 AND ExaminationDayOfWeek <= 7),
    ExaminationStartTime TIME NOT NULL CHECK (ExaminationStartTime >= '08:00:00' AND ExaminationStartTime <= '18:00:00'),
    ExaminationEndTime TIME NOT NULL CHECK (ExaminationEndTime > ExaminationStartTime),
    ExaminationName NVARCHAR(100) NOT NULL CHECK (LEN(TRIM(ExaminationName)) > 0) UNIQUE
)
GO

INSERT INTO Departments (DepartmentBuilding, DepartmentFinancing, DepartmentName)
VALUES
(1, 100000, 'Cardiology'),
(2, 200000, 'Neurology'),
(3, 300000, 'Oncology'),
(4, 400000, 'Gynecology'),
(5, 500000, 'Pediatrics');

INSERT INTO Diseases (DiseaseName, DiseaseSeverity)
VALUES
('Heart Disease', 1),
('Brain Tumor', 2),
('Breast Cancer', 3),
('Pregnancy', 4),
('Chickenpox', 5);

INSERT INTO Doctors (DoctorName, DoctorPhone, DoctorSalary, DoctorSurname)
VALUES
('John', '1234567890', 10000, 'Doe'),
('Jane', '0987654321', 20000, 'Doe'),
('Jack', '1234567890', 30000, 'Smith'),
('Jill', '0987654321', 40000, 'Smith'),
('Jim', '1234567890', 50000, 'Johnson');

INSERT INTO Examinations (ExaminationDayOfWeek, ExaminationStartTime, ExaminationEndTime, ExaminationName)
VALUES
(1, '08:00:00', '12:00:00', 'Cardiology Examination'),
(2, '08:00:00', '12:00:00', 'Neurology Examination'),
(3, '08:00:00', '12:00:00', 'Oncology Examination'),
(4, '08:00:00', '12:00:00', 'Gynecology Examination'),
(5, '08:00:00', '12:00:00', 'Pediatrics Examination');


CREATE TRIGGER ValidateExaminationTime
ON Examinations
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE ExaminationEndTime <= ExaminationStartTime
    )
    BEGIN
        RAISERROR('ExaminationEndTime must be greater than ExaminationStartTime.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO

DROP DATABASE HOSPITAL;

