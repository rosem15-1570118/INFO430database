/*1) Write the SQL code to create a stored procedure to get StudentID when provided a StudentFname, 
StudentLname and BirthDate.

2) Write the SQL code to create a stored procedure that gets UnitID when provided UnitName.

3) Write the SQL code to create a stored procedure that conducts an explicit transaction INSERT INTO the 
LEASE table (and leverages nested stored procedures created above) when provided Fname, Lname, BirthDate, 
UnitName, BeginDate, MonthlyPayment and EndDate

4) Include error-handling that terminates the processing before the transaction if the student is younger 
than 21 at the time of the Lease and the duration of the lease is greater than 1 year.*/


CREATE DATABASE rosem15_Lab07
CREATE TABLE tblSTUDENT (StudentID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, 
                        StudentFname VARCHAR(30) NOT NULL, 
                        StudentLname VARCHAR(30) NOT NULL, 
                        StudentDOB DATE NOT NULL, 
                        )
GO 
CREATE TABLE tblUNIT (UnitID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, 
                    UnitName VARCHAR(5) NOT NULL)
GO
CREATE TABLE tblLEASE (LeaseID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, 
                    StudentID INT FOREIGN KEY REFERENCES tblSTUDENT (StudentID) NOT NULL, 
                    UnitID INT FOREIGN KEY REFERENCES tblUNIT (UnitID) NOT NULL, 
                    BeginDate DATE NOT NULL, 
                    EndDate DATE NULL, 
                    MonthlyPayment NUMERIC(8,2) NOT NULL)
GO
INSERT INTO tblSTUDENT (StudentFname, StudentLname, StudentDOB)
VALUES ('Rachel', 'Green', '01/12/1978'), ('Ross', 'Geller', '10/18/1976'), ('Phoebe', 'Buffey', '01/29/1975')    
INSERT INTO tblUNIT (UnitName)
VALUES ('5'), ('7B'), ('12') 
GO
--GET STUDENT ID 
CREATE PROCEDURE getStudentID
@Fname VARCHAR(30), 
@Lname VARCHAR(30),
@DOB DATE,
@StudID INT OUTPUT
AS 
SET @StudID = (SELECT StudentID FROM tblSTUDENT WHERE StudentFname = @Fname AND StudentLName = @Lname 
AND StudentDOB = @DOB)
GO 

-- GET UNIT ID
CREATE PROCEDURE getUnitID 
@UnitName VARCHAR(5),
@UnitID INT OUTPUT 
AS 
SET @UnitID = (SELECT UnitID FROM tblUNIT WHERE UnitName = @UnitName)
GO

--NEW LEASE
CREATE PROCEDURE uspNewLease
@First VARCHAR(30),
@Last VARCHAR(30), 
@Birth DATE,
@Uname VARCHAR(5), 
@BeginDate DATE, 
@EndDate DATE, 
@MonthlyPayment NUMERIC(8,2)
AS 
DECLARE @SID INT, @UID INT 

EXECUTE getStudentID 
@Fname = @First, 
@Lname = @Last, 
@DOB = @Birth, 
@StudID = @SID OUTPUT

EXECUTE getUnitID
@UnitName = @UName, 
@UnitID = @UID OUTPUT

BEGIN TRAN G1

IF @Bith < ((GetDate() - 365) * 21) AND @BeginDate <= (GetDate()) OR @EndDate > (GetDate() + 365)
    BEGIN 
    PRINT 'You must be at least 21 at the time of the lease and you cannot have longer then a year lease.'
    RAISERROR ('You are too young or the lease is too long', 11, 1)
    RETURN 
    END

INSERT INTO tblLEASE (StudentID, UnitID, BeginDate, EndDate, MonthlyPayment)
VALUES (@SID, @UID, @BeginDate, @EndDate, @MonthlyPayment)

IF @@ERROR <> 0 
    ROLLBACK TRAN G1
ELSE
    COMMIT G1
