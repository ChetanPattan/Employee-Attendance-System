use EMS
select * from EmpAttendance

  INSERT INTO [EMS].[dbo].[EmpAttendance] ([EmpID], [CheckIn], [LunchIn], [LunchOut], [CheckOut])
VALUES (1, GETDATE(), GETDATE(), GETDATE(), GETDATE())

alter table EmpAttendance add Date date;


/*DECLARE @CheckIn DATETIME = GETDATE()
DECLARE @CheckInDate DATE = CAST(@CurrentDate AS DATE)
DECLARE @CheckInTimeOnly TIME = CAST(@CheckIn AS TIME)

INSERT INTO [EMS].[dbo].[EmpAttendance] ([EmpID], [CheckIn], [CurrentDate])
VALUES (1, @CheckInTimeOnly, @CheckInDate)*/


CREATE PROCEDURE InsertCheckIn
    @EmpID INT,
    @CheckInDateTime DATETIME
AS
BEGIN
    DECLARE @CheckInDate DATE = CAST(@CheckInDateTime AS DATE)
    DECLARE @CheckInTime TIME = CAST(@CheckInDateTime AS TIME)

    INSERT INTO [EMS].[dbo].[EmpAttendance] ([EmpID], [CheckIn], [CurrentDate])
    VALUES (@EmpID, @CheckInDate, @CheckInTime)
END

select * from EmpRegistration;

alter table EmpRegistration Add EmpId int;

/*Store Procedure for Registration*/
create procedure SpRegister
  @FName nvarchar(50),
  @MName nvarchar(50),
  @LName nvarchar(50),
  @DOB date,
  @Email varchar(50),
  @Username varchar(50),
  @Password varchar(50),
  @EmpId int out
  as
  begin
  insert into EmpRegistration values (@FName,@MName,@LName,@DOB,@Email, @Username,@Password,@EmpId)
  select @EmpId = SCOPE_IDENTITY()
  end
  
  /*New Store Procedure for Emp Registration*/
  use EMS
  create procedure SpEMPRegister
  @FName nvarchar(50),
  @MName nvarchar(50),
  @LName nvarchar(50),
  @DOB date,
  @Email varchar(50),
  @Username varchar(50),
  @Password varchar(50),
  @EmpId int out
  as
  begin
  insert into EmpRegistration values (@FName,@MName,@LName,@DOB,@Email, @Username,@Password,@EmpId)
  select @EmpId = SCOPE_IDENTITY()
  end
  
  /*Check Username Procedure*/
  create procedure SpChkUsername
  @Username varchar (50)
  as 
  begin
  select * from EmpRegistration where Username=@Username
  end

 delete from EmpRegistration;

/*Login Store Procedure*/
create procedure spAuthenticationUser
@Password nvarchar(50),
@Username nvarchar(50)

as
Begin
	declare @count int
	select @count = COUNT(@Username) from EmpRegistration
where [Username] = @Username and [Password] = @Password
	if(@count = 1)
	begin
	select 1 as ReturnCode
	end
	else
	begin
	select -1 as ReturnCode
	end
end

/*Store Procedure for retrieving profile data after registration*/
create procedure spPersonalRegistration
@Username nvarchar(50)
as
begin
select 'FirstName', 'MiddleName', 'LastName', 'DateOfBirth', 'Email' from EmpRegistration where Username=@Username;
end

use EMS
create procedure spPersonal
@Username nvarchar(50)
as
begin
select 'FirstName', 'MiddleName', 'LastName', 'DateOfBirth', 'Email' from EmpRegistration where Username = @Username;
end
exec spPersonal @Username = 'ChetanPattan'

/*Altered procedure*/
ALTER procedure [dbo].[spPersonal]
@Username nvarchar(50)
as
begin
select FirstName, MiddleName, LastName, DateOfBirth, Email from EmpRegistration where Username = @Username;
end

select FirstName, MiddleName , LastName, DateOfBirth, Email from EmpRegistration

/*Create table for saving details*/
CREATE TABLE EmpProfileInfo (
  ID INT IDENTITY(1,1) PRIMARY KEY,
  FirstName NVARCHAR(50),
  MiddleName NVARCHAR(50),
  LastName NVARCHAR(50),
  DateOfBirth DATE,
  DateOfJoin DATE,
  Email NVARCHAR(100),
  ContactNo NVARCHAR(20),
  AltContactNo NVARCHAR(20),
  PANNo NVARCHAR(20),
  Address1 NVARCHAR(100),
  Address2 NVARCHAR(100),
  Country NVARCHAR(50),
  State NVARCHAR(50),
  City NVARCHAR(50),
  Zip NVARCHAR(20),
  Qualification NVARCHAR(50),
  PassoutYear INT,
  Certificate NVARCHAR(100),
  WorkedAs NVARCHAR(50),
  YearsOfExperience INT,
  ExperienceCertificate NVARCHAR(100),
  Salary DECIMAL(10, 2),
  Photo NVARCHAR(100),
  Signature NVARCHAR(100)
);

ALTER TABLE EmpProfileInfo
ADD Username NVARCHAR(50)

alter table EmpProfileInfo alter column PassoutYear nvarchar(10);


select * from EmpProfileInfo

/*Store Procedure for saving all details to db*/
CREATE PROCEDURE InsertEmployee
  @Username NVARCHAR(50),
  @FirstName NVARCHAR(50),
  @MiddleName NVARCHAR(50),
  @LastName NVARCHAR(50),
  @DateOfBirth DATE,
  @DateOfJoin DATE,
  @Email NVARCHAR(100),
  @ContactNo NVARCHAR(20),
  @AltContactNo NVARCHAR(20),
  @PANNo NVARCHAR(20),
  @Address1 NVARCHAR(100),
  @Address2 NVARCHAR(100),
  @Country NVARCHAR(50),
  @State NVARCHAR(50),
  @City NVARCHAR(50),
  @Zip NVARCHAR(20),
  @Qualification NVARCHAR(50),
  @PassoutYear INT,
  @Certificate NVARCHAR(100),
  @WorkedAs NVARCHAR(50),
  @YearsOfExperience INT,
  @ExperienceCertificate NVARCHAR(100),
  @Salary DECIMAL(10, 2),
  @Photo NVARCHAR(100),
  @Signature NVARCHAR(100)
AS
BEGIN
  INSERT INTO EmpProfileInfo(
	Username,
    FirstName,
    MiddleName,
    LastName,
    DateOfBirth,
    DateOfJoin,
    Email,
    ContactNo,
    AltContactNo,
    PANNo,
    Address1,
    Address2,
    Country,
    State,
    City,
    Zip,
    Qualification,
    PassoutYear,
    Certificate,
    WorkedAs,
    YearsOfExperience,
    ExperienceCertificate,
    Salary,
    Photo,
    Signature
  )
  VALUES (
	@Username,
    @FirstName,
    @MiddleName,
    @LastName,
    @DateOfBirth,
    @DateOfJoin,
    @Email,
    @ContactNo,
    @AltContactNo,
    @PANNo,
    @Address1,
    @Address2,
    @Country,
    @State,
    @City,
    @Zip,
    @Qualification,
    @PassoutYear,
    @Certificate,
    @WorkedAs,
    @YearsOfExperience,
    @ExperienceCertificate,
    @Salary,
    @Photo,
    @Signature
  );
END;


/*Altered Procedure's table name*/
ALTER PROCEDURE [dbo].[InsertEmployee]
  @Username NVARCHAR(50),
  @FirstName NVARCHAR(50),
  @MiddleName NVARCHAR(50),
  @LastName NVARCHAR(50),
  @DateOfBirth DATE,
  @DateOfJoin DATE,
  @Email NVARCHAR(100),
  @ContactNo NVARCHAR(20),
  @AltContactNo NVARCHAR(20),
  @PANNo NVARCHAR(20),
  @Address1 NVARCHAR(100),
  @Address2 NVARCHAR(100),
  @Country NVARCHAR(50),
  @State NVARCHAR(50),
  @City NVARCHAR(50),
  @Zip NVARCHAR(20),
  @Qualification NVARCHAR(50),
  @PassoutYear INT,
  @Certificate NVARCHAR(100),
  @WorkedAs NVARCHAR(50),
  @YearsOfExperience INT,
  @ExperienceCertificate NVARCHAR(100),
  @Salary DECIMAL(10, 2),
  @Photo NVARCHAR(100),
  @Signature NVARCHAR(100)
AS
BEGIN
  INSERT INTO EmpProfileInfo(
	Username,
    FirstName,
    MiddleName,
    LastName,
    DateOfBirth,
    DateOfJoin,
    Email,
    ContactNo,
    AltContactNo,
    PANNo,
    Address1,
    Address2,
    Country,
    State,
    City,
    Zip,
    Qualification,
    PassoutYear,
    Certificate,
    WorkedAs,
    YearsOfExperience,
    ExperienceCertificate,
    Salary,
    Photo,
    Signature
  )
  VALUES (
	@Username,
    @FirstName,
    @MiddleName,
    @LastName,
    @DateOfBirth,
    @DateOfJoin,
    @Email,
    @ContactNo,
    @AltContactNo,
    @PANNo,
    @Address1,
    @Address2,
    @Country,
    @State,
    @City,
    @Zip,
    @Qualification,
    @PassoutYear,
    @Certificate,
    @WorkedAs,
    @YearsOfExperience,
    @ExperienceCertificate,
    @Salary,
    @Photo,
    @Signature
  );
END;

/*Create Procedure for retriving profile photo on master page*/
create procedure spPhoto
@Username nvarchar(50)
as
begin
select Photo from EmpProfileInfo where Username=@Username;
end

exec spPhoto @Username="prakash123"

/*Alter Table EmpAttendance for adding Username Column to it*/
Use EMS
alter table EmpAttendance add Username nvarchar(50) ;

select * from EmpAttendance

/*Store Procedures for getting CheckIn, LunchIn, LunchOut, CheckOut Time*/
create procedure ChkIn
@Username nvarchar(50),
@CurrentDate date,
@CheckIn datetime,
@LunchIn datetime,
@LunchOut datetime,
@CheckOut datetime
as 
begin
insert into EmpAttendance (Username, CurrentDate, CheckIn, LunchIn, LunchOut, CheckOut) values(@Username, @CurrentDate, @CheckIn, @LunchIn, @LunchOut, @CheckOut)
end

/*Alter Procedure for checkin*/
ALTER procedure [dbo].[ChkIn]
@Username nvarchar(50),
@CurrentDate date,
@CheckIn time,
@LunchIn time,
@LunchOut time,
@CheckOut time
as 
begin
insert into EmpAttendance (Username, CurrentDate, CheckIn, LunchIn,LunchOut,CheckOut) values(@Username, @CurrentDate, @CheckIn, @LunchIn,@LunchOut,@CheckOut)
end


/*Alter table EmpAttendance for making EmpId column as Identity*/
use EMs
-- Drop the existing primary key constraint if it exists
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.EmpAttendance_PK') AND type = 'PK')
    ALTER TABLE dbo.EmpAttendance
    DROP CONSTRAINT EmpAttendance_PK;

IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.EmpAttendance') AND name = 'EmpID')
    ALTER TABLE dbo.EmpAttendance
    DROP COLUMN EmpID;

IF EXISTS (SELECT * FROM sys.foreign_keys WHERE referenced_object_id = OBJECT_ID(N'dbo.EmpAttendance'))
BEGIN
    ALTER TABLE dbo.TableName1
    DROP CONSTRAINT FK_TableName1_EmpAttendance;

    -- Add additional DROP CONSTRAINT statements for each foreign key constraint that references the 'EmpAttendance' table
END

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.EmpAttendance_PK') AND type = 'PK')
    ALTER TABLE dbo.EmpAttendance
    DROP CONSTRAINT EmpAttendance_PK;

IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.EmpAttendance') AND name = 'EmpID')
    ALTER TABLE dbo.EmpAttendance
    DROP COLUMN EmpID;


-- Drop the foreign key constraints that reference the 'EmpAttendance' table
IF EXISTS (SELECT * FROM sys.foreign_keys WHERE referenced_object_id = OBJECT_ID(N'dbo.EmpAttendance'))
BEGIN
    ALTER TABLE dbo.TableName1
    DROP CONSTRAINT FK_TableName1_EmpAttendance;

    -- Add additional DROP CONSTRAINT statements for each foreign key constraint that references the 'EmpAttendance' table
END


-- Drop the existing primary key constraint if it exists
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.PK_EmpAttendance') AND type = 'PK')
    ALTER TABLE dbo.EmpAttendance
    DROP CONSTRAINT PK_EmpAttendance;

IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.EmpAttendance') AND name = 'EmpID')
    ALTER TABLE dbo.EmpAttendance
    DROP COLUMN EmpID;


-- Add the 'EmpID' column as an identity column
ALTER TABLE dbo.EmpAttendance
ADD EmpID INT IDENTITY(1,1) PRIMARY KEY;

/*ALTER TABLE dbo.TableName1
ADD CONSTRAINT FK_TableName1_EmpAttendance FOREIGN KEY (EmpID) REFERENCES dbo.EmpAttendance(EmpID);
*/
use ems
select * from empattendance

/*Alter Procedure and table*/
ALTER TABLE EmpAttendance
ADD NewCheckIn time,
    NewLunchIn time,
    NewLunchOut time,
    NewCheckOut time;

UPDATE EmpAttendance
SET NewCheckIn = CONVERT(time, CheckIn),
    NewLunchIn = CONVERT(time, LunchIn),
    NewLunchOut = CONVERT(time, LunchOut),
    NewCheckOut = CONVERT(time, CheckOut);


-- Step 3: Drop the existing columns
ALTER TABLE EmpAttendance
DROP COLUMN CheckIn,
 LunchIn,
LunchOut,
 CheckOut;

 -- Step 4: Rename the temporary columns to the original column names
EXEC sp_rename 'EmpAttendance.NewCheckIn', 'CheckIn', 'COLUMN';
EXEC sp_rename 'EmpAttendance.NewLunchIn', 'LunchIn', 'COLUMN';
EXEC sp_rename 'EmpAttendance.NewLunchOut', 'LunchOut', 'COLUMN';
EXEC sp_rename 'EmpAttendance.NewCheckOut', 'CheckOut', 'COLUMN';

/*Update Procedure*/
ALTER PROCEDURE [dbo].[ChkIn]
    @Username NVARCHAR(50),
    @CurrentDate DATE,
    @CheckIn TIME,
    @LunchIn TIME,
    @LunchOut TIME,
    @CheckOut TIME
AS
BEGIN
    IF EXISTS (SELECT 1 FROM EmpAttendance WHERE Username = @Username AND CurrentDate = @CurrentDate)
    BEGIN
        UPDATE EmpAttendance
        SET CheckIn = @CheckIn,
            LunchIn = @LunchIn,
            LunchOut = @LunchOut,
            CheckOut = @CheckOut
        WHERE Username = @Username
          AND CurrentDate = @CurrentDate
    END
    ELSE
    BEGIN
        INSERT INTO EmpAttendance (Username, CurrentDate, CheckIn, LunchIn, LunchOut, CheckOut)
        VALUES (@Username, @CurrentDate, @CheckIn, @LunchIn, @LunchOut, @CheckOut)
    END
END


DELETE FROM EmpAttendance
WHERE Username = 'chetanpattan';

/*Procedures for checkin, lunchin, lunchout, checkout*/

create procedure checkInTime
@Username nvarchar(50)
as
begin
insert into EmpAttendance values() where @CheckIn = CheckIn;

use ems
select * from EmpAttendance

/*Procedure for getting profile info*/
create procedure spUserInfo
@Username nvarchar(50)
as
begin
select FirstName, MiddleName, LastName, DateOfBirth, DateOfJoin, Email, ContactNo, AltContactNo, PANNo,
Address1, Address2, Country, State,City,Zip, Qualification, PassoutYear,Certificate,WorkedAs,YearsOfExperience,
ExperienceCertificate, Salary, Photo, Signature
from EmpProfileInfo where Username = @Username;
end

select * from EmpProfileInfo

select * from EmpRegistration

select * from ManagerLogin

Delete  from EmpRegistration where DateOfBirth='2001-05-01'

select * from EmpProfileInfo where Username='Chetan123';


/*create procedure for Admin Login*/
create procedure spAuthenticationAdmin
@ManagerPassword nvarchar(50),
@ManagerUsername nvarchar(50)

as
Begin
	declare @count int
	select @count = COUNT(@ManagerUsername) from ManagerLogin
where [ManagerUsername] = @ManagerUsername and [ManagerPassword] = @ManagerPassword
	if(@count = 1)
	begin
	select 1 as ReturnCode
	end
	else
	begin
	select -1 as ReturnCode
	end
end

select * from ManagerLogin
use ems
exec spAuthenticationAdmin
@ManagerUsername = 'ManagerChetan',
@ManagerPassword = 'ManagerChetanAdmin123@';

/*Creating Store Procedures for retrieving check in , lunch in, lunch out, check out time*/
CREATE PROCEDURE RetrieveCheckInTime
    @Username VARCHAR(50)
AS
BEGIN
    SELECT CheckIn
    FROM EmpAttendance
    WHERE Username = @Username
END


CREATE PROCEDURE RetrieveLunchInTime
    @Username VARCHAR(50)
AS
BEGIN
    SELECT LunchIn
    FROM EmpAttendance
    WHERE Username = @Username
END


CREATE PROCEDURE RetrieveLunchOutTime
    @Username VARCHAR(50)
AS
BEGIN
    SELECT LunchOut
    FROM EmpAttendance
    WHERE Username = @Username
END


CREATE PROCEDURE CheckOut
    @Username VARCHAR(50)
AS
BEGIN
    SELECT CheckOut
    FROM EmpAttendance
    WHERE Username = @Username
END


/*Alter Procedure ChkIn*/
alter PROCEDURE ChkIn
    @Username VARCHAR(50),
    @CurrentDate DATE,
    @CheckIn TIME = NULL,
    @LunchIn TIME = NULL,
    @LunchOut TIME = NULL,
    @CheckOut TIME = NULL
AS
BEGIN
    UPDATE EmpAttendance
    SET CheckIn = ISNULL(@CheckIn, CheckIn),
        LunchIn = ISNULL(@LunchIn, LunchIn),
        LunchOut = ISNULL(@LunchOut, LunchOut),
        CheckOut = ISNULL(@CheckOut, CheckOut)
    WHERE Username = @Username AND CurrentDate = @CurrentDate;
END

use ems
delete  from EmpAttendance


select * from EmpAttendance

/*New Procedure for saving/updating attendance*/
create PROCEDURE spAttendance
    @Username VARCHAR(50),
    @CurrentDate DATE,
    @CheckIn TIME = NULL,
    @LunchIn TIME = NULL,
    @LunchOut TIME = NULL,
    @CheckOut TIME = NULL
AS
BEGIN
    UPDATE EmpAttendance
    SET CheckIn = ISNULL(@CheckIn, CheckIn),
        LunchIn = ISNULL(@LunchIn, LunchIn),
        LunchOut = ISNULL(@LunchOut, LunchOut),
        CheckOut = ISNULL(@CheckOut, CheckOut)
    WHERE Username = @Username AND CurrentDate = @CurrentDate;
END

use EMS
/*Store Procedures for getting CheckIn, LunchIn, LunchOut, CheckOut Time*/
create procedure InsertAttendance
@Username nvarchar(50),
@CurrentDate date,
@CheckIn time = Null,
@LunchIn time = Null,
@LunchOut time = Null,
@CheckOut time =Null
as 
begin
insert into EmpAttendance (Username, CurrentDate, CheckIn, LunchIn, LunchOut, CheckOut) 
values(@Username, @CurrentDate, @CheckIn, @LunchIn, @LunchOut, @CheckOut)
end

/*Update InsertAttendance procedure for checking existing user*/
ALTER PROCEDURE [dbo].InsertAttendance
    @Username NVARCHAR(50),
    @CurrentDate DATE,
    @CheckIn TIME,
    @LunchIn TIME,
    @LunchOut TIME,
    @CheckOut TIME
AS
BEGIN
    IF EXISTS (SELECT 1 FROM EmpAttendance WHERE Username = @Username AND CurrentDate = @CurrentDate)
    BEGIN
        UPDATE EmpAttendance
        SET CheckIn = @CheckIn,
            LunchIn = @LunchIn,
            LunchOut = @LunchOut,
            CheckOut = @CheckOut
        WHERE Username = @Username
          AND CurrentDate = @CurrentDate
    END
    ELSE
    BEGIN
        INSERT INTO EmpAttendance (Username, CurrentDate, CheckIn, LunchIn, LunchOut, CheckOut)
        VALUES (@Username, @CurrentDate, @CheckIn, @LunchIn, @LunchOut, @CheckOut)
    END
END

/*Procedeure for retriveing user specific attendance details in gridview*/
use EMS
CREATE PROCEDURE [dbo].[RetrieveAttendanceByUser]
    @Username NVARCHAR(50)
AS
BEGIN
    SELECT CurrentDate, CheckIn, LunchIn, LunchOut, CheckOut
    FROM EmpAttendance
    WHERE Username = @Username
    ORDER BY CurrentDate DESC
END

/*Alter procedure [RetrieveAttendanceByUser]*/
alter PROCEDURE [dbo].[RetrieveAttendanceByUser]
    @Username NVARCHAR(50)
AS
BEGIN
    SELECT CurrentDate, CheckIn, LunchIn, LunchOut, CheckOut
    FROM EmpAttendance
    WHERE Username = @Username
    ORDER BY CurrentDate ASC
END

exec [RetrieveAttendanceByUser]
@Username = 'Chetan123'


/*Procedure for getting all employees in GridView with other details*/
create PROCEDURE [dbo].[RetrieveAttendance]
AS
BEGIN
    SELECT Username, CurrentDate, CheckIn, LunchIn, LunchOut, CheckOut
    FROM EmpAttendance
   
    ORDER BY CurrentDate DESC
END

exec [RetrieveAttendance]

use EMS

select * from EmpAttendance

/*alter table EmpProfileInfo*/

use EMS
--below alter query didn't fired
ALTER TABLE EmpProfileInfo
ALTER COLUMN Photo VARBINARY(MAX);

ALTER PROCEDURE [dbo].[spPhoto]
@Username NVARCHAR(50)
AS
BEGIN
    SELECT CONVERT(VARBINARY(MAX), Photo, 2) AS PhotoData
    FROM EmpProfileInfo
    WHERE Username = @Username;
END


/*alter above procedure again*/

ALTER PROCEDURE [dbo].[spPhoto]
@Username NVARCHAR(50)
AS
BEGIN
    SELECT Photo
    FROM EmpProfileInfo
    WHERE Username = @Username;
END

ALTER PROCEDURE [dbo].[spPhoto]
@Username NVARCHAR(50)
AS
BEGIN
    DECLARE @Photo NVARCHAR(MAX);
    DECLARE @PhotoVarbinary VARBINARY(MAX);

    SELECT @Photo = Photo
    FROM EmpProfileInfo
    WHERE Username = @Username;

    SET @PhotoVarbinary = CONVERT(VARBINARY(MAX), @Photo, 1);

    SELECT @PhotoVarbinary AS Photo;
END


ALTER PROCEDURE [dbo].[spPhoto]
@Username NVARCHAR(50)
AS
BEGIN
    DECLARE @Photo NVARCHAR(MAX);
    DECLARE @PhotoVarbinary VARBINARY(MAX);

    SELECT @Photo = Photo
    FROM EmpProfileInfo
    WHERE Username = @Username;

    SET @PhotoVarbinary = CONVERT(VARBINARY(MAX), CAST('' AS XML).value('xs:base64Binary(sql:variable("@Photo"))', 'VARBINARY(MAX)'));

    SELECT @PhotoVarbinary AS Photo;
END



exec spPhoto
@Username = 'prakash123'


/*13/06/2023
Alter table EmpAttendance , add FirstName and Last Name (2) Columns*/
use EMS
alter table EmpAttendance add  FirstName nvarchar(50),
LastName nvarchar(50)

select * from EmpAttendance

/*Alter procedure for accepting First Name and Last Name from session*/
ALTER PROCEDURE [dbo].[RetrieveAttendanceByUser]
    @Username NVARCHAR(50)
	
AS
BEGIN
    SELECT FirstName,LastName, CurrentDate, CheckIn, LunchIn, LunchOut, CheckOut
    FROM EmpAttendance
    WHERE Username = @Username
    ORDER BY CurrentDate ASC
END

exec RetrieveAttendanceByUser
@Username = 'JulieD'

/*Procedure for getting all employees in GridView with other details*/
alter PROCEDURE [dbo].[RetrieveAttendance]
AS
BEGIN
    SELECT FirstName, LastName ,Username, CurrentDate, CheckIn, LunchIn, LunchOut, CheckOut
    FROM EmpAttendance
   
    ORDER BY CurrentDate DESC
END

exec RetrieveAttendance

/*Alter Procedure for inserting FirstName and LastName*/
ALTER PROCEDURE [dbo].[InsertAttendance]
	@FirstName nvarchar(50),
	@LastName nvarchar(50),
    @Username NVARCHAR(50),
    @CurrentDate DATE,
    @CheckIn TIME,
    @LunchIn TIME,
    @LunchOut TIME,
    @CheckOut TIME
AS
BEGIN
    IF EXISTS (SELECT 1 FROM EmpAttendance WHERE Username = @Username AND CurrentDate = @CurrentDate)
    BEGIN
        UPDATE EmpAttendance
        SET CheckIn = @CheckIn,
            LunchIn = @LunchIn,
            LunchOut = @LunchOut,
            CheckOut = @CheckOut
        WHERE Username = @Username
          AND CurrentDate = @CurrentDate
    END
    ELSE
    BEGIN
        INSERT INTO EmpAttendance (FirstName,LastName,Username, CurrentDate, CheckIn, LunchIn, LunchOut, CheckOut)
        VALUES (@FirstName,@LastName,@Username, @CurrentDate, @CheckIn, @LunchIn, @LunchOut, @CheckOut)
    END
END

select * from EmpAttendance

use EMS
select * from EmpProfileInfo

delete from EmpRegistration where Username='UserU';

/*procedure for chage password*/
CREATE PROCEDURE spChangePassword
    @Username NVARCHAR(50),
    @CurrentPassword NVARCHAR(50),
    @NewPassword NVARCHAR(50)
AS
BEGIN
    UPDATE EmpRegistration
    SET Password = @NewPassword
    WHERE Username = @Username AND Password = @CurrentPassword;
END


/**17/06/2023*/
/*Store Procedure for update*/
create PROCEDURE [dbo].[InsertUpdateEmployee]
 @Username NVARCHAR(50),
  @FirstName NVARCHAR(50),
  @MiddleName NVARCHAR(50),
  @LastName NVARCHAR(50),
  @DateOfBirth DATE,
  @DateOfJoin DATE,
  @Email NVARCHAR(100),
  @ContactNo NVARCHAR(20),
  @AltContactNo NVARCHAR(20),
  @PANNo NVARCHAR(20),
  @Address1 NVARCHAR(100),
  @Address2 NVARCHAR(100),
  @Country NVARCHAR(50),
  @State NVARCHAR(50),
  @City NVARCHAR(50),
  @Zip NVARCHAR(20),
  @Qualification NVARCHAR(50),
  @PassoutYear INT,
  @Certificate NVARCHAR(100),
  @WorkedAs NVARCHAR(50),
  @YearsOfExperience INT,
  @ExperienceCertificate NVARCHAR(100),
  @Salary DECIMAL(10, 2),
  @Photo NVARCHAR(100),
  @Signature NVARCHAR(100)
AS
BEGIN IF EXISTS (SELECT 1 FROM EmpProfileInfo WHERE Username = @Username)
  BEGIN
    UPDATE EmpProfileInfo
    SET
      FirstName = @FirstName,
      MiddleName = @MiddleName,
      LastName = @LastName,
      DateOfBirth = @DateOfBirth,
      DateOfJoin = @DateOfJoin,
      Email = @Email,
      ContactNo = @ContactNo,
      AltContactNo = @AltContactNo,
      PANNo = @PANNo,
      Address1 = @Address1,
      Address2 = @Address2,
      Country = @Country,
      State = @State,
      City = @City,
      Zip = @Zip,
      Qualification = @Qualification,
      PassoutYear = @PassoutYear,
      Certificate = @Certificate,
      WorkedAs = @WorkedAs,
      YearsOfExperience = @YearsOfExperience,
      ExperienceCertificate = @ExperienceCertificate,
      Salary = @Salary,
      Photo = @Photo,
      Signature = @Signature
    WHERE Username = @Username;
  END
END;


SELECT 
    COLUMN_NAME, 
    DATA_TYPE, 
    CHARACTER_MAXIMUM_LENGTH AS MAX_LENGTH, 
    CHARACTER_OCTET_LENGTH AS OCTET_LENGTH 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'EmpProfileInfo' 
AND COLUMN_NAME = 'Photo';

/*spPhoto update*/
use EMS
--below query didn't fired
ALTER PROCEDURE [dbo].[spPhoto]
@Username NVARCHAR(50)
AS
BEGIN
    DECLARE @Photo NVARCHAR(MAX);
    DECLARE @PhotoVarbinary VARBINARY(MAX);

    SELECT @Photo = Photo
    FROM EmpProfileInfo
    WHERE Username = @Username;

    SET @PhotoVarbinary = CONVERT(VARBINARY(MAX), CAST('' AS XML).value('xs:base64Binary(sql:column("Photo"))', 'VARBINARY(MAX)'));

    SELECT @PhotoVarbinary AS Photo;
END

use EMS

select * from EmpProfileInfo where Username='prakash123'
exec spPhoto 
@username = 'prakash123'

/*21/06/2023*/
select * from EmpAttendance
select * from EmpAttendance where Username = 'JonDsouza'
select * from EmpAttendance where Username = 'JulieD'

exec RetrieveCheckInTime
@Username= 'julied'

exec RetrieveLunchInTime
@Username= 'julied'

--alter procedure
ALTER PROCEDURE [dbo].[RetrieveCheckInTime]
    @Username VARCHAR(50)
    --@CurrentDate DATE
AS
BEGIN
    SELECT CheckIn
    FROM EmpAttendance
    WHERE Username = @Username
    --AND CurrentDate = @CurrentDate
END

--22/06/2023
/*alter RetrieveAttendanceByUser*/

ALTER PROCEDURE [dbo].[RetrieveAttendanceByUser]
    @Username VARCHAR(50)
AS
BEGIN
    DECLARE @CurrentDate DATE = CONVERT(DATE, GETDATE())

    SELECT CheckIn, LunchIn, LunchOut, CheckOut
    FROM EmpAttendance
    WHERE Username = @Username
    AND CurrentDate = @CurrentDate
END


exec RetrieveAttendanceByUser
@Username='JulieD'

/*alter [RetrieveCheckInTime]*/
ALTER PROCEDURE [dbo].[RetrieveCheckInTime]
    @Username VARCHAR(50),
    @CurrentDate DATE
AS
BEGIN
    SELECT CheckIn
    FROM EmpAttendance
    WHERE Username = @Username
    AND CurrentDate = @CurrentDate
END

exec RetrieveCheckInTime
@Username='julied',
@CurrentDate='2023/06/22'

--ALTER RetrieveLunchInTime
ALTER PROCEDURE [dbo].[RetrieveLunchInTime]
    @Username VARCHAR(50),
	 @CurrentDate DATE
AS
BEGIN
    SELECT LunchIn
    FROM EmpAttendance
    WHERE Username = @Username
	AND CurrentDate = @CurrentDate
END
use EMS
exec RetrieveLunchInTime
@Username='JulieD',
@CurrentDate = '2023/06/22'

--alter RetrieveLunchOutTime
ALTER PROCEDURE [dbo].[RetrieveLunchOutTime]
    @Username VARCHAR(50),
	@Currentdate DATE
AS
BEGIN
    SELECT LunchOut
    FROM EmpAttendance
    WHERE Username = @Username
	AND CurrentDate = @CurrentDate
END

use EMS
delete from EmpRegistration where Username = 'chetanpattan'

exec RetrieveAttendanceByUser
@Username = 'chetanpattan'


--alter procedure [RetrieveAttendanceByUser]
ALTER PROCEDURE [dbo].[RetrieveAttendanceByUser]
    @Username VARCHAR(50)
AS
BEGIN
    DECLARE @CurrentDate DATE = CONVERT(DATE, GETDATE())

    SELECT CurrentDate, CheckIn, LunchIn, LunchOut, CheckOut
    FROM EmpAttendance
    WHERE Username = @Username
    AND CurrentDate = @CurrentDate
END

