USE PostGradOffice;



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
	--EXEC AddDefenseGucian @ThesisSerialNo = @ThesisID, @DefenseDate = '2012-05-09', @DefenseLocation = 'Gryffindor Tower, Hogwarts';
	--EXEC AddExaminer @ThesisSerialNo = @ThesisID, @DefenseDate = '2012-05-09', @ExaminerName = 'Rolanda Hooch', @National = 1, @fieldOfWork = 'Flying';
	--set @examiner_id1 = IDENT_CURRENT ('PostGradUser');
	--EXEC AddDefenseGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2012-05-09', @grade = 95.00;
	--EXEC ExaminerAddCommentsGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2012-05-09', @examinerId = @examiner_id1, @comments = 'More info is needed';

	--EXEC AddDefenseGucian @ThesisSerialNo = @ThesisID, @DefenseDate = '2013-08-09', @DefenseLocation = 'Dumbledore Office Tower';
	--EXEC AddExaminer @ThesisSerialNo = @ThesisID, @DefenseDate = '2013-08-09', @ExaminerName = 'Dolores Umbridge', @National = 0, @fieldOfWork = 'fieldOfWork';
	--set @examiner_id2 = IDENT_CURRENT ('PostGradUser');
	--EXEC AddDefenseGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2013-08-09', @grade = 97.00;
	--EXEC ExaminerAddCommentsGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2013-08-09', @examinerId = @examiner_id2, @comments = 'Perfect Job';

	EXEC addPublication @title = 'Relations of the Patronus', @pubDate = '2013-11-10', @host = 'Dumbledore', @place = 'Divination', @accepted = 1;
	SET @Pub_ID = IDENT_CURRENT ('Publication');
	EXEC linkPubThesis @PubID = @Pub_ID, @thesisSerialNo = @ThesisID;



