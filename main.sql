create database Academy;
go

use Academy;
go

create table Groups
(
    GroupId int primary key identity(1,1) not null,
    GroupName nvarchar(10) not null unique check (LEN(TRIM(GroupName)) > 0),
    GroupRating int not null check (GroupRating >= 0 and GroupRating <= 5),
    GroupYear int not null check (GroupYear >= 1 and GroupYear <= 5)
)
go

create table Departments
(
    DepartmentId int primary key identity(1,1) not null,
    DepartmentFinancing money not null check (DepartmentFinancing >= 0) default 0,
    DepartmentName nvarchar(100) not null unique check (LEN(TRIM(DepartmentName)) > 0)
)
go

create table Faculties
(
    FacultyId int primary key identity(1,1) not null,
    FacultyName nvarchar(100) not null unique check (LEN(TRIM(FacultyName)) > 0)
)
go

create table Teachers
(
    TeacherId int primary key identity (1,1) not null,
    TeacherEmploymentDate date not null check (TeacherEmploymentDate <= '01.01.1990'),
    TeacherName nvarchar(max) not null check (LEN(TRIM(TeacherName)) > 0),
    TeacherPremium money not null check (TeacherPremium >= 0) default 0,
    TeacherSalary money not null check (TeacherSalary > 0),
    TeacherSurname nvarchar(max) not null check (LEN(TRIM(TeacherSurname)) > 0)
)
go

insert into Groups (GroupName, GroupRating, GroupYear)
values
('A1', 5, 1),
('A2', 4, 2),
('A3', 3, 3),
('A4', 2, 4),
('A5', 1, 5)

insert into Departments (DepartmentFinancing, DepartmentName)
values
(100000, 'Department1'),
(200000, 'Department2'),
(300000, 'Department3'),
(400000, 'Department4'),
(500000, 'Department5')

insert into Faculties (FacultyName)
values
('Faculty1'),
('Faculty2'),
('Faculty3'),
('Faculty4'),
('Faculty5')

insert into Teachers (TeacherEmploymentDate, TeacherName, TeacherPremium, TeacherSalary, TeacherSurname)
values
('01.01.1980', 'Teacher1', 1000, 10000, 'Surname1'),
('01.01.1981', 'Teacher2', 2000, 20000, 'Surname2'),
('01.01.1982', 'Teacher3', 3000, 30000, 'Surname3'),
('01.01.1983', 'Teacher4', 4000, 40000, 'Surname4'),
('01.01.1984', 'Teacher5', 5000, 50000, 'Surname5')

drop database Academy;
