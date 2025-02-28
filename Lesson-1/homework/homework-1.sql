--Question type: Medium 

--1 
create database SchoolDB
use SchoolDB
--2
create table Students (
   StudentID INT PRIMARY KEY,
   Name VARCHAR(50),
   Age INT,
);
--3
SQL - Structured Query Language, type of programming language to connect with database
SQL Server - Software app to manage database
SSMS - Visual comfortable application for SQL


--Question type: Hard 
--1
DQL - Data Query Language 
Includes: SELECT

DML - Data Manipulation Language 
Includes - INSERT, UPDATE, DELETE

DDL - Data Definition Language
Includes - ALTER, DROP, TRUNCATE, CREATE, RENAME

DCL - Data control Language
Includes - GRANT, REVOKE, DENY

--2
Insert into Students Values ('1', 'Bek', '18'), ('2', 'Otabek', '19'), ('3', 'Ulugbek', '19')

--3
BACKUP DATABASE SchoolDB 
TO DISK = 'C:\Backup\SchoolDB.bak'
WITH FORMAT, INIT;

RESTORE DATABASE SchoolDB 
FROM DISK = 'C:\Backup\SchoolDB.bak'
WITH REPLACE, RECOVERY;
