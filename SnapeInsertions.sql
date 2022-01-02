USE PostGradOffice;

INSERT INTO PostGradUser (email, password) VALUES ('AlbusDumbledoreEmail', 'DumbledorePass');
INSERT INTO Admin VALUES (IDENT_CURRENT ('PostGradUser'));
INSERT INTO PostGradUser (email, password) VALUES ('MinervaMcGonagallEmail', 'MinervaPass');
INSERT INTO Admin VALUES (IDENT_CURRENT ('PostGradUser'));

----------------------- YOUSEF -------------------------------------

GO
	-- all declares
	DECLARE @ThesisID INT;
	DECLARE @ThesisPaymentID INT;
	DECLARE @SupervisorID INT;
	DECLARE @StudentID INT;
	DECLARE @SuccessThesisPayment BIT;
	DECLARE @ProgressReportNum INT;
	DECLARE @examiner_id1 INT;
	DECLARE @examiner_id2 INT;
	DECLARE @Pub_ID INT;
	DECLARE @CourseID INT;
	DECLARE @Fees DECIMAL;
	DECLARE @CoursePaymentId INT;

	-- 1 supervisor, 2 students, 3 phone numbers, 3 thesis, 4 progress reports, 4 defenses, 2 examiners, 2 courses, 3 publictaions

	-- supervisor
	EXEC SupervisorRegister @first_name = 'Remus', @last_name = 'Lupin', @password = 'RemusLupinPass', @faculty = 'Gryffindor', @email = 'RemusLupinEmail';
	SET @SupervisorID = IDENT_CURRENT ('PostGradUser');

	-- gucian Studnet with 2 phones and 2 thesis and 3 progress reports and 3 defenses
	EXEC StudentRegister @first_name = 'Neville' , @last_name = 'Longbottom', @password = 'NevilleLongbottomPass',
		@faculty = 'Gryffindor', @Gucian = 1, @email = 'NevilleLongbottomEmail', @address = 'The Leaky Cauldron';
	SET @StudentID = IDENT_CURRENT ('PostGradUser');
	EXEC addUndergradID @studentID = @StudentID, @undergradID = 0710;

	UPDATE GucianStudent set GPA = 3.85, type = 'PhD' WHERE GucianStudent.id = @StudentID;

	-- phones
	--EXEC addMobile @ID = @StudentID, @mobile_number = '01097123419';
	

	-- thesis 1, 2 reports, 2 defenses, 1 pub
	-- thesis 1 & grade
	INSERT INTO Thesis (field, type, title, startDate, endDate, noOfExtensions) VALUES ('Charms', 'MSC', 'Patronus', '2011-07-11', '2014-08-03', 0);
	SET @ThesisID = IDENT_CURRENT ('Thesis');

	--EXEC AdminIssueThesisPayment @ThesisSerialNo = @ThesisID, @amount = 50000, @noOfInstallments = 2,
	--	@fundPercentage = 100, @Success = @SuccessThesisPayment OUTPUT;
	--SET @ThesisPaymentID = IDENT_CURRENT ('Payment');
	--EXEC AdminIssueInstallPayment @paymentID = @ThesisPaymentID, @InstallStartDate = '2011-08-11';

	--EXEC AdminUpdateExtension @ThesisID;
	--EXEC AdminUpdateExtension @ThesisID;

	INSERT INTO GUCianStudentRegisterThesis(sid, supid, serial_no) VALUES(@StudentID, @SupervisorID ,@ThesisID);
	
	--EXEC AddGrade @ThesisSerialNo = @ThesisID, @ThesisGrade = 80.00;

	-- 2 progress reports
	EXEC AddProgressReport @thesisSerialNo = @ThesisID, @progressReportDate = '2012-01-21', @studentID = @StudentID, @ProgressReportNo = 1;
	SET @ProgressReportNum = (SELECT TOP 1 GUCianProgressReport.no
			FROM GUCianProgressReport
			WHERE @studentID = GUCianProgressReport.sid ORDER BY GUCianProgressReport.no DESC);

	--EXEC FillProgressReport @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @state = 50, @description = 'Defintion for the patronus charm', @studentID = @StudentID;

	--EXEC EvaluateProgressReport @supervisorID = @SupervisorID, @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @evaluation = 3;
	----
	--EXEC AddProgressReport @thesisSerialNo = @ThesisID, @progressReportDate = '2013-06-06';
	--SET @ProgressReportNum = (SELECT TOP 1 GUCianProgressReport.no
	--		FROM GUCianProgressReport
	--		WHERE @studentID = GUCianProgressReport.sid ORDER BY GUCianProgressReport.no DESC);

	--EXEC FillProgressReport @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @state = 100, @description = 'More info about the patronus charm';

	--EXEC EvaluateProgressReport @supervisorID = @SupervisorID, @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @evaluation = 2;

	-- defenses and publications
	-- 2 defenses
	EXEC AddDefenseGucian @ThesisSerialNo = @ThesisID, @DefenseDate = '2012-05-09', @DefenseLocation = 'Gryffindor Tower, Hogwarts';
	EXEC AddExaminer @ThesisSerialNo = @ThesisID, @DefenseDate = '2012-05-09', @ExaminerName = 'Rolanda Hooch', @Password = 'RolandaHoochPass', @National = 1, @fieldOfWork = 'Flying';
	set @examiner_id1 = IDENT_CURRENT ('PostGradUser');
	EXEC AddDefenseGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2012-05-09', @grade = 95.00;
	EXEC ExaminerAddCommentsGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2012-05-09', @examinerId = @examiner_id1, @comments = 'More info is needed';

	--EXEC AddDefenseGucian @ThesisSerialNo = @ThesisID, @DefenseDate = '2013-08-09', @DefenseLocation = 'Dumbledore Office Tower';
	--EXEC AddExaminer @ThesisSerialNo = @ThesisID, @DefenseDate = '2013-08-09', @ExaminerName = 'Dolores Umbridge', @National = 0, @fieldOfWork = 'fieldOfWork';
	--set @examiner_id2 = IDENT_CURRENT ('PostGradUser');
	--EXEC AddDefenseGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2013-08-09', @grade = 97.00;
	--EXEC ExaminerAddCommentsGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2013-08-09', @examinerId = @examiner_id2, @comments = 'Perfect Job';

	EXEC addPublication @title = 'Relations of the Patronus', @pubDate = '2013-11-10', @host = 'Dumbledore', @place = 'Divination', @accepted = 1;
	SET @Pub_ID = IDENT_CURRENT ('Publication');
	EXEC linkPubThesis @PubID = @Pub_ID, @thesisSerialNo = @ThesisID;

	INSERT INTO Thesis (field, type, title, startDate, endDate, noOfExtensions) VALUES ('ninjutsu', 'MS', 'shadow clone jutsu!', '2020-6-03', '2022-07-08', 0);
	SET @ThesisID = IDENT_CURRENT ('Thesis');
	INSERT INTO GUCianStudentRegisterThesis(sid, supid, serial_no) VALUES(@StudentID, @SupervisorID ,@ThesisID);



	GO
	-- all declares
	DECLARE @ThesisID INT;
	DECLARE @ThesisPaymentID INT;
	DECLARE @SupervisorID INT;
	DECLARE @StudentID INT;
	DECLARE @SuccessThesisPayment BIT;
	DECLARE @ProgressReportNum INT;
	DECLARE @examiner_id1 INT;
	DECLARE @examiner_id2 INT;
	DECLARE @Pub_ID INT;
	DECLARE @CourseID INT;
	DECLARE @Fees DECIMAL;
	DECLARE @CoursePaymentId INT;

	-- 1 supervisor, 2 students, 3 phone numbers, 3 thesis, 4 progress reports, 4 defenses, 2 examiners, 2 courses, 3 publictaions

	-- supervisor
	EXEC SupervisorRegister @first_name = 'Natalie', @last_name = 'Wynn', @password = 'Darkm321@@', @faculty = 'Philosiphy', @email = 'contrapoints@gmail.com';
	SET @SupervisorID = IDENT_CURRENT ('PostGradUser');

	-- gucian Studnet with 2 phones and 2 thesis and 3 progress reports and 3 defenses
	EXEC StudentRegister @first_name = 'Abd Elghafour' , @last_name = 'El Boray', @password = 'Biro102030',
		@faculty = 'Philosiphy', @Gucian = 1, @email = 'barbora@gmail.com', @address = 'Wekalet El balah, St 1, Apt 3';
	SET @StudentID = IDENT_CURRENT ('PostGradUser');

	
	INSERT INTO Thesis (field, type, title, startDate, endDate, noOfExtensions) VALUES ('Philosiphy', 'Phd', 'Effects of catgrils on the psyche of the fragile', '2021-11-10', '2023-11-10', 0);
	SET @ThesisID = IDENT_CURRENT ('Thesis');

	INSERT INTO GUCianStudentRegisterThesis(sid, supid, serial_no) VALUES(@StudentID, @SupervisorID ,@ThesisID);
	
	EXEC AddGrade @ThesisSerialNo = @ThesisID;

	-- 2 progress reports
	EXEC AddProgressReport @thesisSerialNo = @ThesisID, @progressReportDate = '2022-01-07',@studentID = @StudentID,@progressReportNo=1;
	SET @ProgressReportNum = (SELECT TOP 1 GUCianProgressReport.no
			FROM GUCianProgressReport
			WHERE @studentID = GUCianProgressReport.sid ORDER BY GUCianProgressReport.no DESC);

	EXEC AddProgressReport @thesisSerialNo = @ThesisID, @progressReportDate = '2022-02-08',@studentID = @StudentID,@progressReportNo=2;
	SET @ProgressReportNum = (SELECT TOP 1 GUCianProgressReport.no
			FROM GUCianProgressReport
			WHERE @studentID = GUCianProgressReport.sid ORDER BY GUCianProgressReport.no DESC);


	-- defenses and publications
	-- 2 defenses
	--EXEC AddDefenseGucian @ThesisSerialNo = @ThesisID, @DefenseDate = '2023-01-01', @DefenseLocation = 'Court Room';
	--EXEC AddExaminer @ThesisSerialNo = @ThesisID, @DefenseDate = '2023-01-01', @ExaminerName = 'Abigaul Thorne',@Password = 'Abi123!@#', @National = 0, @fieldOfWork = 'Philosiphy';
	--set @examiner_id1 = IDENT_CURRENT ('PostGradUser');
	--EXEC AddDefenseGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2023-01-01', @grade = 0.00;
	--EXEC ExaminerAddCommentsGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2023-01-01', @examinerId = @examiner_id1, @comments = 'Its abhorent to say that catgirls are disgusting';

	--EXEC AddDefenseGucian @ThesisSerialNo = @ThesisID, @DefenseDate = '2024-01-01', @DefenseLocation = 'Court Room';
	--EXEC AddExaminer @ThesisSerialNo = @ThesisID, @DefenseDate = '2024-01-01', @ExaminerName = 'Berni',@Password = 'SocialistToTheCore', @National = 1, @fieldOfWork = 'Chocolate';
	--set @examiner_id2 = IDENT_CURRENT ('PostGradUser');
	--EXEC AddDefenseGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2024-01-01', @grade = 70.00;
	--EXEC ExaminerAddCommentsGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2024-01-01', @examinerId = @examiner_id2, @comments = 'Meh';

	EXEC addPublication @title = 'Catgirls and Otakus', @pubDate = '2024-02-02', @host = 'Times', @place = 'The web', @accepted = 0;
	SET @Pub_ID = IDENT_CURRENT ('Publication');
	EXEC linkPubThesis @PubID = @Pub_ID, @thesisSerialNo = @ThesisID;



	-- thesis 2 with 1 progress report
	INSERT INTO Thesis (field, type, title, startDate, endDate, noOfExtensions) VALUES ('Sharks', 'MSC', 'Sharks Swim?', '2030-09-11', '2033-08-08', 0);
	SET @ThesisID = IDENT_CURRENT ('Thesis');



	INSERT INTO GUCianStudentRegisterThesis VALUES(@StudentID, @SupervisorID ,@ThesisID);


	-- 1 progress report
	EXEC AddProgressReport @thesisSerialNo = @ThesisID, @progressReportDate = '2031-01-01',@studentID = @StudentID,@progressReportNo=3;
	SET @ProgressReportNum = (SELECT TOP 1 GUCianProgressReport.no
			FROM GUCianProgressReport
			WHERE @studentID = GUCianProgressReport.sid ORDER BY GUCianProgressReport.no DESC);


	-- 1 defenses with old examiners and publication
	--EXEC AddDefenseGucian @ThesisSerialNo = @ThesisID, @DefenseDate = '2034-01-01', @DefenseLocation = 'Tank';

	--INSERT INTO ExaminerEvaluateDefense (date, serialNo, examinerId) VALUES ('2034-01-01', @ThesisID, @examiner_id1);
	--EXEC AddDefenseGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2034-01-01', @grade = 90.00;
	--EXEC ExaminerAddCommentsGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2034-01-01', @examinerId = @examiner_id1, @comments = 'Sharks indeed look like they are swimming';

	--INSERT INTO ExaminerEvaluateDefense (date, serialNo, examinerId) VALUES ('2034-01-01', @ThesisID, @examiner_id2);
	--EXEC AddDefenseGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2034-01-01', @grade = 95.00;
	--EXEC ExaminerAddCommentsGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2034-01-01', @examinerId = @examiner_id2, @comments = 'Sharks Swim! WOW!';

	EXEC addPublication @title = 'Sharks swim', @pubDate = '2034-01-02', @host = 'AquaNews', @place = 'Ocean', @accepted = 1;
	SET @Pub_ID = IDENT_CURRENT ('Publication');
	EXEC linkPubThesis @PubID = @Pub_ID, @thesisSerialNo = @ThesisID;

	-------------------------

	-- none gucian Studnet with 1 phones and 1 thesis and 1 progress reports and 1 defenses
	EXEC StudentRegister @first_name = 'Fatma' , @last_name = 'Koshary',@password = 'aTGAs$!@gA',
	@faculty = 'MET', @Gucian = 0, @email = 'fatma.koshary@guc.edu.eg', @address = 'Wekalet ElBalah,St1,Apt2';
	SET @StudentID = IDENT_CURRENT ('PostGradUser');

	-- thesis 1, 2 reports, 2 defenses, 1 pub
	-- thesis 1 & grade
	INSERT INTO Thesis (field, type, title, startDate, endDate, noOfExtensions) VALUES ('CS', 'MS', 'Interuppt commands in CPU', '2024-03-04', '2026-01-01', 0);
	SET @ThesisID = IDENT_CURRENT ('Thesis');

	INSERT INTO NonGUCianStudentRegisterThesis VALUES(@StudentID, @SupervisorID ,@ThesisID);

	-- 1 progress reports
	EXEC AddProgressReport @thesisSerialNo = @ThesisID, @progressReportDate = '2025-01-01',@studentID = @StudentID,@progressReportNo=1;
	SET @ProgressReportNum = (SELECT TOP 1 NonGUCianProgressReport.no
			FROM NonGUCianProgressReport
			WHERE @studentID = NonGUCianProgressReport.sid ORDER BY NonGUCianProgressReport.no DESC);


	-- defenses and publications
	-- 1 defenses
	--EXEC AddDefenseGucian @ThesisSerialNo = @ThesisID, @DefenseDate = '2026-01-01', @DefenseLocation = 'C1';

	--INSERT INTO ExaminerEvaluateDefense (date, serialNo, examinerId) VALUES ('2026-01-01', @ThesisID, @examiner_id1);
	--EXEC AddDefenseGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2026-01-01', @grade = 71.00;
	--EXEC ExaminerAddCommentsGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2026-01-01', @examinerId = @examiner_id1, @comments = 'Wonderful';


	EXEC addPublication @title = 'CPU Interuppts', @pubDate = '2026-05-01', @host = 'CNN', @place = 'Internet', @accepted = 1;
	SET @Pub_ID = IDENT_CURRENT ('Publication');
	EXEC linkPubThesis @PubID = @Pub_ID, @thesisSerialNo = @ThesisID;
GO


GO
CREATE PROC CheckGucianForThesis
	@thesisSerialNumber INT,
	@defenseDate DateTime,
	@defenseLocation VarChar(15)
AS
DECLARE @gucian INT
IF (EXISTS(SELECT serial_no
		   FROM GUCianStudentRegisterThesis
		   WHERE serial_no = @thesisSerialNumber))
BEGIN
	IF (EXISTS(SELECT * FROM Defense WHERE Defense.date = @defenseDate AND Defense.serialNumber = @thesisSerialNumber))
	BEGIN
		RAISERROR('Defense for this Thesis with this Defense Date is Already Added!',11,1);
	END
	Else
	BEGIN
		EXEC AddDefenseGucian @thesisSerialNumber, @defenseDate, @defenseLocation;
	END
END
ELSE IF (EXISTS(SELECT serial_no
		   FROM NonGUCianStudentRegisterThesis
		   WHERE serial_no = @thesisSerialNumber))
BEGIN
	IF (EXISTS(SELECT * FROM Defense WHERE Defense.date = @defenseDate AND Defense.serialNumber = @thesisSerialNumber))
	BEGIN
		RAISERROR('Defense for this Thesis with this Defense Date is Already Added!',11,1);
	END
	ELSE
	BEGIN
		EXEC AddDefenseNonGucian @thesisSerialNumber, @defenseDate, @defenseLocation;
	END
END
ELSE
BEGIN
	RAISERROR('There is no Thesis with Thesis Serial Number!',11,1);
END


GO
CREATE PROC AddExistingExaminer
	@defenseDate DATETIME,
	@thesisSerialNumber INT,
	@examinerId INT
AS
IF (EXISTS(SELECT * FROM Defense WHERE Defense.date = @defenseDate AND Defense.serialNumber = @thesisSerialNumber))
BEGIN
	IF(not exists(SELECT * FROM ExaminerEvaluateDefense WHERE ExaminerEvaluateDefense.date = @defenseDate AND ExaminerEvaluateDefense.serialNo = @thesisSerialNumber AND ExaminerEvaluateDefense.examinerId =@examinerId))
	BEGIN
		IF (EXISTS(SELECT * FROM Examiner WHERE Examiner.id =@examinerId))
		BEGIN
			INSERT INTO ExaminerEvaluateDefense VALUES(@defenseDate, @thesisSerialNumber, @examinerId, null)
		END
		ELSE
		BEGIN
			RAISERROR('There is NO Examiner with this ID',11,1);
		END
	END
	ELSE
	BEGIN
		RAISERROR('This Examiner is ALREADY added to this Defense',11,1);
	END
END
ELSE
BEGIN
	RAISERROR('There is No Defense with this Thesis Serial Number and Defense Date. Please add the Defense Before adding the Examiner',11,1);
END

GO
CREATE PROC CheckStudentId
@studentId INT
AS
	IF (NOT EXISTS(SELECT id FROM GucianStudent WHERE GucianStudent.id = @StudentId UNION SELECT id FROM NonGucianStudent WHERE NonGucianStudent.id = @StudentId))
	BEGIN
		RAISERROR('There is NO Student with this ID',11,1);
	END