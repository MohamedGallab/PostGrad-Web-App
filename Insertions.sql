USE PostGradOffice;

-- Insert 2 Admins
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
	EXEC addMobile @ID = @StudentID, @mobile_number = '01097123419';
	

	-- thesis 1, 2 reports, 2 defenses, 1 pub
	-- thesis 1 & grade
	INSERT INTO Thesis (field, type, title, startDate, endDate, noOfExtensions) VALUES ('Charms', 'MS', 'Patronus', '2011-07-11', '2014-08-03', 0);
	SET @ThesisID = IDENT_CURRENT ('Thesis');

	EXEC AdminIssueThesisPayment @ThesisSerialNo = @ThesisID, @amount = 50000, @noOfInstallments = 2,
		@fundPercentage = 100	;
	SET @ThesisPaymentID = IDENT_CURRENT ('Payment');
	EXEC AdminIssueInstallPayment @paymentID = @ThesisPaymentID, @InstallStartDate = '2011-08-11';

	EXEC AdminUpdateExtension @ThesisID;
	EXEC AdminUpdateExtension @ThesisID;

	INSERT INTO GUCianStudentRegisterThesis(sid, supid, serial_no) VALUES(@StudentID, @SupervisorID ,@ThesisID);
	
	EXEC AddGrade @ThesisSerialNo = @ThesisID, @ThesisGrade = 80.00;

	-- 2 progress reports
	EXEC AddProgressReport @thesisSerialNo = @ThesisID, @progressReportDate = '2012-01-21';
	SET @ProgressReportNum = (SELECT TOP 1 GUCianProgressReport.no
			FROM GUCianProgressReport
			WHERE @studentID = GUCianProgressReport.sid ORDER BY GUCianProgressReport.no DESC);

	EXEC FillProgressReport @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @state = 50, @description = 'Defintion for the patronus charm';

	EXEC EvaluateProgressReport @supervisorID = @SupervisorID, @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @evaluation = 3;
	--
	EXEC AddProgressReport @thesisSerialNo = @ThesisID, @progressReportDate = '2013-06-06';
	SET @ProgressReportNum = (SELECT TOP 1 GUCianProgressReport.no
			FROM GUCianProgressReport
			WHERE @studentID = GUCianProgressReport.sid ORDER BY GUCianProgressReport.no DESC);

	EXEC FillProgressReport @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @state = 100, @description = 'More info about the patronus charm';

	EXEC EvaluateProgressReport @supervisorID = @SupervisorID, @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @evaluation = 2;

	-- defenses and publications
	-- 2 defenses
	EXEC AddDefenseGucian @ThesisSerialNo = @ThesisID, @DefenseDate = '2012-05-09', @DefenseLocation = 'Gryffindor Tower, Hogwarts';
	EXEC AddExaminer @ThesisSerialNo = @ThesisID, @DefenseDate = '2012-05-09', @ExaminerName = 'Rolanda Hooch', @National = 1, @fieldOfWork = 'Flying';
	set @examiner_id1 = IDENT_CURRENT ('PostGradUser');
	EXEC AddDefenseGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2012-05-09', @grade = 95.00;
	EXEC ExaminerAddCommentsGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2012-05-09', @examinerId = @examiner_id1, @comments = 'More info is needed';

	EXEC AddDefenseGucian @ThesisSerialNo = @ThesisID, @DefenseDate = '2013-08-09', @DefenseLocation = 'Dumbledore Office Tower';
	EXEC AddExaminer @ThesisSerialNo = @ThesisID, @DefenseDate = '2013-08-09', @ExaminerName = 'Dolores Umbridge', @National = 0, @fieldOfWork = 'fieldOfWork';
	set @examiner_id2 = IDENT_CURRENT ('PostGradUser');
	EXEC AddDefenseGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2013-08-09', @grade = 97.00;
	EXEC ExaminerAddCommentsGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2013-08-09', @examinerId = @examiner_id2, @comments = 'Perfect Job';

	EXEC addPublication @title = 'Relations of the Patronus', @pubDate = '2013-11-10', @host = 'Dumbledore', @place = 'Divination', @accepted = 1;
	SET @Pub_ID = IDENT_CURRENT ('Publication');
	EXEC linkPubThesis @PubID = @Pub_ID, @thesisSerialNo = @ThesisID;



	-- thesis 2 with 1 progress report
	INSERT INTO Thesis (field, type, title, startDate, endDate, noOfExtensions) VALUES ('Dark Arts Defence', 'PHD', 'The Cruciatus Curse', '2019-07-03', '2022-01-09', 0);
	SET @ThesisID = IDENT_CURRENT ('Thesis');

	EXEC AdminIssueThesisPayment @ThesisSerialNo = @ThesisID, @amount = 100, @noOfInstallments = 3,
		@fundPercentage = 75;
	SET @ThesisPaymentID = IDENT_CURRENT ('Payment');
	EXEC AdminIssueInstallPayment @paymentID = @ThesisPaymentID, @InstallStartDate = '2020-01-01';

	EXEC AdminUpdateExtension @ThesisID;

	INSERT INTO GUCianStudentRegisterThesis VALUES(@StudentID, @SupervisorID ,@ThesisID);

	EXEC AddGrade @ThesisSerialNo = @ThesisID, @ThesisGrade = 100.00;

	-- 1 progress report
	EXEC AddProgressReport @thesisSerialNo = @ThesisID, @progressReportDate = '2020-01-03';
	SET @ProgressReportNum = (SELECT TOP 1 GUCianProgressReport.no
			FROM GUCianProgressReport
			WHERE @studentID = GUCianProgressReport.sid ORDER BY GUCianProgressReport.no DESC);

	EXEC FillProgressReport @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @state = 50, @description = 'How does the Cruciatus curse effect the brain?';

	EXEC EvaluateProgressReport @supervisorID = @SupervisorID, @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @evaluation = 2;

	-- 1 defenses with old examiners and publication
	EXEC AddDefenseGucian @ThesisSerialNo = @ThesisID, @DefenseDate = '2020-06-09', @DefenseLocation = 'Ravenclaw Tower';

	INSERT INTO ExaminerEvaluateDefense (date, serialNo, examinerId) VALUES ('2020-06-09', @ThesisID, @examiner_id1);
	EXEC AddDefenseGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2020-06-09', @grade = 75.00;
	EXEC ExaminerAddCommentsGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2020-06-09', @examinerId = @examiner_id1, @comments = 'Lacks the magical info';

	INSERT INTO ExaminerEvaluateDefense (date, serialNo, examinerId) VALUES ('2020-06-09', @ThesisID, @examiner_id2);
	EXEC AddDefenseGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2020-06-09', @grade = 90.00;
	EXEC ExaminerAddCommentsGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2020-06-09', @examinerId = @examiner_id2, @comments = 'Accurate info medical wise';

	EXEC addPublication @title = 'Effect of the Cruciatus curse', @pubDate = '2021-05-07', @host = 'Hedwig', @place = 'Owlery', @accepted = 0;
	SET @Pub_ID = IDENT_CURRENT ('Publication');
	EXEC linkPubThesis @PubID = @Pub_ID, @thesisSerialNo = @ThesisID;

	-------------------------

	-- Nongucian Student with 1 phones and 1 thesis and 1 progress reports and 1 defenses
	EXEC StudentRegister @first_name = 'Luna' , @last_name = 'Lovegood',@password = 'LunaLovegoodPass',
	@faculty = 'Ravenclaw', @Gucian = 0, @email = 'LunaLovegoodEmail', @address = 'The Lovegood House';
	SET @StudentID = IDENT_CURRENT ('PostGradUser');

	UPDATE NonGucianStudent set GPA = 3.50, type = 'PhD' WHERE NonGucianStudent.id = @StudentID;

	-- phones
	EXEC addMobile @ID = @StudentID, @mobile_number = '01002124331';

	-- thesis 1, 2 reports, 2 defenses, 1 pub
	-- thesis 1 & grade
	INSERT INTO Thesis (field, type, title, startDate, endDate, noOfExtensions) VALUES ('Potions', 'PHD', 'Felix Felicis', '2020-11-11', '2023-09-04', 0);
	SET @ThesisID = IDENT_CURRENT ('Thesis');


	EXEC AdminIssueThesisPayment @ThesisSerialNo = @ThesisID, @amount = 100, @noOfInstallments = 3,
	@fundPercentage = 75;
	SET @ThesisPaymentID = IDENT_CURRENT ('Payment');
	EXEC AdminIssueInstallPayment @paymentID = @ThesisPaymentID, @InstallStartDate = '2020-12-11';

	EXEC AdminUpdateExtension @ThesisID;
	EXEC AdminUpdateExtension @ThesisID;

	INSERT INTO NonGUCianStudentRegisterThesis VALUES(@StudentID, @SupervisorID ,@ThesisID);

	EXEC AddGrade @ThesisSerialNo = @ThesisID, @ThesisGrade = 99.00;

	-- 1 progress reports
	EXEC AddProgressReport @thesisSerialNo = @ThesisID, @progressReportDate = '2021-01-05';
	SET @ProgressReportNum = (SELECT TOP 1 NonGUCianProgressReport.no
			FROM NonGUCianProgressReport
			WHERE @studentID = NonGUCianProgressReport.sid ORDER BY NonGUCianProgressReport.no DESC);

	EXEC FillProgressReport @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @state = 50, @description = 'Liquid luck and its effect on the real world';

	EXEC EvaluateProgressReport @supervisorID = @SupervisorID, @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @evaluation = 2;

	-- ADDING COURSE --

	
	EXEC AddCourse @courseCode = 'Transfiguration 101', @creditHrs = 2, @fees = 5000;
	SET @CourseID = IDENT_CURRENT('Course');

	EXEC linkCourseStudent @courseID = @CourseID, @studentID = @StudentID;

	EXEC addStudentCourseGrade @courseID = @CourseID, @studentID = @StudentID, @grade = 75.0;

	
	SELECT @Fees = fees FROM Course WHERE id = @CourseID;
	
	INSERT INTO PAYMENT (amount, noOfInstallments, fundPercentage) VALUES (@Fees, 4, 100);
	SET @CoursePaymentId = IDENT_CURRENT ('Payment');
	EXEC AdminIssueInstallPayment @paymentID = @CoursePaymentId, @InstallStartDate = '2021-04-07';

	INSERT INTO NonGucianStudentPayForCourse VALUES (@StudentID, @CoursePaymentId, @CourseID);

	-- defenses and publications
	-- 1 defenses
	EXEC AddDefenseGucian @ThesisSerialNo = @ThesisID, @DefenseDate = '2021-12-08', @DefenseLocation = 'Astronomy Tower';

	INSERT INTO ExaminerEvaluateDefense (date, serialNo, examinerId) VALUES ('2021-12-08', @ThesisID, @examiner_id1);
	EXEC AddDefenseGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2021-12-08', @grade = 100.00;
	EXEC ExaminerAddCommentsGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2021-12-08', @examinerId = @examiner_id1, @comments = 'Well presented';


	EXEC addPublication @title = 'The Luck by Liquid Luck', @pubDate = '2022-07-07', @host = 'Sybill Trelawney', @place = 'Astronomy Tower', @accepted = 1;
	SET @Pub_ID = IDENT_CURRENT ('Publication');
	EXEC linkPubThesis @PubID = @Pub_ID, @thesisSerialNo = @ThesisID;
GO

----------------------- WAGDY -------------------------------------

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
	EXEC SupervisorRegister @first_name = 'kakashi', @last_name = 'hatake', @password = 'copycat', @faculty = 'jonin', @email = 'iStoleMySharingan@gmail.com';
	SET @SupervisorID = IDENT_CURRENT ('PostGradUser');

	-- gucian Studnet with 2 phones and 2 thesis and 3 progress reports and 3 defenses
	EXEC StudentRegister @first_name = 'naruto' , @last_name = 'uzumaki', @password = 'dattebayo!',
		@faculty = 'genin', @Gucian = 1, @email = 'sasukePlsComeback@gmail.com', @address = 'some trash appartement';
	SET @StudentID = IDENT_CURRENT ('PostGradUser');
	EXEC  addUndergradID @studentID = @StudentID, @undergradID = 111;

	UPDATE GucianStudent set GPA = 3.70, type = 'Phd' WHERE GucianStudent.id = @StudentID;

	-- phones
	
	EXEC addMobile @ID = @StudentID, @mobile_number = '01020039955';

	-- thesis 1, 2 reports, 2 defenses, 1 pub
	-- thesis 1 & grade
	INSERT INTO Thesis (field, type, title, startDate, endDate, noOfExtensions) VALUES ('ninjutsu', 'MS', 'shadow clone jutsu!', '2020-6-03', '2022-07-08', 0);
	SET @ThesisID = IDENT_CURRENT ('Thesis');

	EXEC AdminIssueThesisPayment @ThesisSerialNo = @ThesisID, @amount = 50000, @noOfInstallments = 4,
		@fundPercentage = 100;
	SET @ThesisPaymentID = IDENT_CURRENT ('Payment');
	EXEC AdminIssueInstallPayment @paymentID = @ThesisPaymentID, @InstallStartDate = '2020-12-01';

	EXEC AdminUpdateExtension @ThesisID;

	INSERT INTO GUCianStudentRegisterThesis(sid, supid, serial_no) VALUES(@StudentID, @SupervisorID ,@ThesisID);
	
	EXEC AddGrade @ThesisSerialNo = @ThesisID, @ThesisGrade = 100.00;

	-- 2 progress reports
	EXEC AddProgressReport @thesisSerialNo = @ThesisID, @progressReportDate = '2021-07-01';
	SET @ProgressReportNum = (SELECT TOP 1 GUCianProgressReport.no
			FROM GUCianProgressReport
			WHERE @studentID = GUCianProgressReport.sid ORDER BY GUCianProgressReport.no DESC);

	EXEC FillProgressReport @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @state = 50, @description = 'this is the description of how i stole my main jutsu lol';

	EXEC EvaluateProgressReport @supervisorID = @SupervisorID, @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @evaluation = 3;
	--
	EXEC AddProgressReport @thesisSerialNo = @ThesisID, @progressReportDate = '2022-03-06';
	SET @ProgressReportNum = (SELECT TOP 1 GUCianProgressReport.no
			FROM GUCianProgressReport
			WHERE @studentID = GUCianProgressReport.sid ORDER BY GUCianProgressReport.no DESC);

	EXEC FillProgressReport @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @state = 100, @description = 'i think i almost got it,just need to try it a few more times';

	EXEC EvaluateProgressReport @supervisorID = @SupervisorID, @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @evaluation = 2;

	-- defenses and publications
	-- 2 defenses
	EXEC AddDefenseGucian @ThesisSerialNo = @ThesisID, @DefenseDate = '2022-06-09', @DefenseLocation = 'class';
	EXEC AddExaminer @ThesisSerialNo = @ThesisID, @DefenseDate = '2022-06-09', @ExaminerName = 'iruka umino', @National = 0, @fieldOfWork = 'academy teacher';
	set @examiner_id2 = IDENT_CURRENT ('PostGradUser');
	EXEC AddDefenseGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2022-06-09', @grade = 100.00;
	EXEC ExaminerAddCommentsGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2022-06-09', @examinerId = @examiner_id2, @comments = 'how did you learn a forbidden jutsu literally 10 minutes apart in the same episode...you kinda sus';

	
	EXEC AddDefenseGucian @ThesisSerialNo = @ThesisID, @DefenseDate = '2022-04-20', @DefenseLocation = 'chunin exams arena';
	EXEC AddExaminer @ThesisSerialNo = @ThesisID, @DefenseDate = '2022-04-20', @ExaminerName = 'hayate gekko', @National = 1, @fieldOfWork = 'proctor';
	set @examiner_id1 = IDENT_CURRENT ('PostGradUser');
	EXEC AddDefenseGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2022-04-20', @grade = 100.00;
	EXEC ExaminerAddCommentsGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2022-04-20', @examinerId = @examiner_id1, @comments = 'this dude literally stole the forbidden scroll and he aint sorry about it';

	EXEC addPublication @title = 'my ninja way', @pubDate = '2022-11-19', @host = 'konoha news', @place = 'konoha', @accepted = 1;
	SET @Pub_ID = IDENT_CURRENT ('Publication');
	EXEC linkPubThesis @PubID = @Pub_ID, @thesisSerialNo = @ThesisID;



	-- thesis 2 with 1 progress report
	INSERT INTO Thesis (field, type, title, startDate, endDate, noOfExtensions) VALUES ('ninjutsu', 'Phd', 'rasengaaaan!', '2020-01-01', '2023-01-01', 0);
	SET @ThesisID = IDENT_CURRENT ('Thesis');

	EXEC AdminIssueThesisPayment @ThesisSerialNo = @ThesisID, @amount = 100000, @noOfInstallments = 3,
		@fundPercentage = 75;
	SET @ThesisPaymentID = IDENT_CURRENT ('Payment');
	EXEC AdminIssueInstallPayment @paymentID = @ThesisPaymentID, @InstallStartDate = '2020-05-01';

	EXEC AdminUpdateExtension @ThesisID;
	EXEC AdminUpdateExtension @ThesisID;

	INSERT INTO GUCianStudentRegisterThesis VALUES(@StudentID, @SupervisorID ,@ThesisID);

	EXEC AddGrade @ThesisSerialNo = @ThesisID, @ThesisGrade = 100.00;

	-- 1 progress report
	EXEC AddProgressReport @thesisSerialNo = @ThesisID, @progressReportDate = '2021-05-01';
	SET @ProgressReportNum = (SELECT TOP 1 GUCianProgressReport.no
			FROM GUCianProgressReport
			WHERE @studentID = GUCianProgressReport.sid ORDER BY GUCianProgressReport.no DESC);

	EXEC FillProgressReport @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @state = 50, @description = 'my throat is starting to hurt cause i scream too hard when i do the jutsu';

	EXEC EvaluateProgressReport @supervisorID = @SupervisorID, @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @evaluation = 3;

	-- 1 defenses with old examiners and publication
	EXEC AddDefenseGucian @ThesisSerialNo = @ThesisID, @DefenseDate = '2022-6-09', @DefenseLocation = 'training grounds';

	INSERT INTO ExaminerEvaluateDefense (date, serialNo, examinerId) VALUES ('2022-6-09', @ThesisID, @examiner_id1);
	EXEC AddDefenseGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2022-6-09', @grade = 100.00;
	EXEC ExaminerAddCommentsGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2022-6-09', @examinerId = @examiner_id1, @comments = 'at least this one isnt stolen...or is it???';

	INSERT INTO ExaminerEvaluateDefense (date, serialNo, examinerId) VALUES ('2022-6-09', @ThesisID, @examiner_id2);
	EXEC AddDefenseGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2022-6-09', @grade = 100.00;
	EXEC ExaminerAddCommentsGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2022-6-09', @examinerId = @examiner_id2, @comments = 'this dude went from creating dead clones to creating a mini nuke...what klnda steroids you on ,kid?';

	EXEC addPublication @title = 'maybe i am not a one-trick after all', @pubDate = '2023-07-07', @host = 'konoha news', @place = 'konoha', @accepted = 1;
	SET @Pub_ID = IDENT_CURRENT ('Publication');
	EXEC linkPubThesis @PubID = @Pub_ID, @thesisSerialNo = @ThesisID;

	-------------------------

	-- none gucian Studnet with 1 phones and 1 thesis and 1 progress reports and 1 defenses
	EXEC StudentRegister @first_name = 'boruto' , @last_name = 'uzumaki',@password = 'iUsedToHateMyDad',
	@faculty = 'genin', @Gucian = 0, @email = 'noticeMeDad@gmail.com', @address = 'i live with the hokage boiiii';
	SET @StudentID = IDENT_CURRENT ('PostGradUser');

	UPDATE NonGucianStudent set GPA = 3.00, type = 'MS' WHERE NonGucianStudent.id = @StudentID;

	-- phones
	EXEC addMobile @ID = @StudentID, @mobile_number = '01924999224';

	-- thesis 1, 2 reports, 2 defenses, 1 pub
	-- thesis 1 & grade
	INSERT INTO Thesis (field, type, title, startDate, endDate, noOfExtensions) VALUES ('ninjutsu', 'MS', 'learning rasengan so sasuke notices me', '2020-02-01', '2023-05-01', 0);
	SET @ThesisID = IDENT_CURRENT ('Thesis');


	EXEC AdminIssueThesisPayment @ThesisSerialNo = @ThesisID, @amount = 120000, @noOfInstallments = 3,
	@fundPercentage = 75;
	SET @ThesisPaymentID = IDENT_CURRENT ('Payment');
	EXEC AdminIssueInstallPayment @paymentID = @ThesisPaymentID, @InstallStartDate = '2020-04-01';

	EXEC AdminUpdateExtension @ThesisID;
	EXEC AdminUpdateExtension @ThesisID;

	INSERT INTO NonGUCianStudentRegisterThesis VALUES(@StudentID, @SupervisorID ,@ThesisID);

	EXEC AddGrade @ThesisSerialNo = @ThesisID, @ThesisGrade = 100.00;

	-- 1 progress reports
	EXEC AddProgressReport @thesisSerialNo = @ThesisID, @progressReportDate = '2021-01-01';
	SET @ProgressReportNum = (SELECT TOP 1 NonGUCianProgressReport.no
			FROM NonGUCianProgressReport
			WHERE @studentID = NonGUCianProgressReport.sid ORDER BY NonGUCianProgressReport.no DESC);

	EXEC FillProgressReport @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @state = 50, @description = 'i just created a rasengan the size of a pea and i am proud';

	EXEC EvaluateProgressReport @supervisorID = @SupervisorID, @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @evaluation = 3;

	-- ADDING COURSE --

	
	EXEC AddCourse @courseCode = 'nin501', @creditHrs = 8, @fees = 9000;
	SET @CourseID = IDENT_CURRENT('Course');

	EXEC linkCourseStudent @courseID = @CourseID, @studentID = @StudentID;

	EXEC addStudentCourseGrade @courseID = @CourseID, @studentID = @StudentID, @grade = 100.0;

	
	SELECT @Fees = fees FROM Course WHERE id = @CourseID;
	
	INSERT INTO PAYMENT (amount, noOfInstallments, fundPercentage) VALUES (@Fees, 4, 100);
	SET @CoursePaymentId = IDENT_CURRENT ('Payment');
	EXEC AdminIssueInstallPayment @paymentID = @CoursePaymentId, @InstallStartDate = '2021-01-01';

	INSERT INTO NonGucianStudentPayForCourse VALUES (@StudentID, @CoursePaymentId, @CourseID);

	-- defenses and publications
	-- 1 defenses
	EXEC AddDefenseGucian @ThesisSerialNo = @ThesisID, @DefenseDate = '2023-01-09', @DefenseLocation = 'training grounds';

	INSERT INTO ExaminerEvaluateDefense (date, serialNo, examinerId) VALUES ('2023-01-09', @ThesisID, @examiner_id1);
	EXEC AddDefenseGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2023-01-09', @grade = 100.00;
	EXEC ExaminerAddCommentsGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2023-01-09', @examinerId = @examiner_id1, @comments = 'ok maybe he isnt just a spoiled kid after all';


	EXEC addPublication @title = 'sasuke finally noticed me', @pubDate = '2023-07-07', @host = 'konoha modern news', @place = 'konoha', @accepted = 1;
	SET @Pub_ID = IDENT_CURRENT ('Publication');
	EXEC linkPubThesis @PubID = @Pub_ID, @thesisSerialNo = @ThesisID;
GO

----------------------- MAHMOUD -------------------------------------

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
	EXEC  addUndergradID @studentID = @StudentID, @undergradID = 101;

	UPDATE GucianStudent set GPA = 3.90, type = 'PhD' WHERE GucianStudent.id = @StudentID;

	-- phones
	
	EXEC addMobile @ID = @StudentID, @mobile_number = '01132654512';

	-- thesis 1, 2 reports, 2 defenses, 1 pub
	-- thesis 1 & grade
	INSERT INTO Thesis (field, type, title, startDate, endDate, noOfExtensions) VALUES ('Philosiphy', 'Phd', 'Effects of catgrils on the psyche of the fragile', '2021-11-10', '2023-11-10', 0);
	SET @ThesisID = IDENT_CURRENT ('Thesis');

	EXEC AdminIssueThesisPayment @ThesisSerialNo = @ThesisID, @amount = 150000, @noOfInstallments = 3,
		@fundPercentage = 50;
	SET @ThesisPaymentID = IDENT_CURRENT ('Payment');
	EXEC AdminIssueInstallPayment @paymentID = @ThesisPaymentID, @InstallStartDate = '2021-11-01';

	EXEC AdminUpdateExtension @ThesisID;
	EXEC AdminUpdateExtension @ThesisID;

	INSERT INTO GUCianStudentRegisterThesis(sid, supid, serial_no) VALUES(@StudentID, @SupervisorID ,@ThesisID);
	
	EXEC AddGrade @ThesisSerialNo = @ThesisID, @ThesisGrade = 40.00;

	-- 2 progress reports
	EXEC AddProgressReport @thesisSerialNo = @ThesisID, @progressReportDate = '2022-01-07';
	SET @ProgressReportNum = (SELECT TOP 1 GUCianProgressReport.no
			FROM GUCianProgressReport
			WHERE @studentID = GUCianProgressReport.sid ORDER BY GUCianProgressReport.no DESC);

	EXEC FillProgressReport @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @state = 50, @description = 'So far, Venician catgirls seem to ellicit the highest reaction in our subjects';

	EXEC EvaluateProgressReport @supervisorID = @SupervisorID, @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @evaluation = 3;
	--
	EXEC AddProgressReport @thesisSerialNo = @ThesisID, @progressReportDate = '2022-02-08';
	SET @ProgressReportNum = (SELECT TOP 1 GUCianProgressReport.no
			FROM GUCianProgressReport
			WHERE @studentID = GUCianProgressReport.sid ORDER BY GUCianProgressReport.no DESC);

	EXEC FillProgressReport @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @state = 70, @description = 'In our recent research, it has been concluded that otakus are into all kinds of catgirls. Disgusting.';

	EXEC EvaluateProgressReport @supervisorID = @SupervisorID, @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @evaluation = 1;

	-- defenses and publications
	-- 2 defenses
	EXEC AddDefenseGucian @ThesisSerialNo = @ThesisID, @DefenseDate = '2023-01-01', @DefenseLocation = 'Court Room';
	EXEC AddExaminer @ThesisSerialNo = @ThesisID, @DefenseDate = '2023-01-01', @ExaminerName = 'Abigaul Thorne', @National = 0, @fieldOfWork = 'Philosiphy';
	set @examiner_id1 = IDENT_CURRENT ('PostGradUser');
	EXEC AddDefenseGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2023-01-01', @grade = 0.00;
	EXEC ExaminerAddCommentsGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2023-01-01', @examinerId = @examiner_id1, @comments = 'Its abhorent to say that catgirls are disgusting';

	EXEC AddDefenseGucian @ThesisSerialNo = @ThesisID, @DefenseDate = '2024-01-01', @DefenseLocation = 'Court Room';
	EXEC AddExaminer @ThesisSerialNo = @ThesisID, @DefenseDate = '2024-01-01', @ExaminerName = 'Berni', @National = 1, @fieldOfWork = 'Chocolate';
	set @examiner_id2 = IDENT_CURRENT ('PostGradUser');
	EXEC AddDefenseGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2024-01-01', @grade = 70.00;
	EXEC ExaminerAddCommentsGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2024-01-01', @examinerId = @examiner_id2, @comments = 'Meh';

	EXEC addPublication @title = 'Catgirls and Otakus', @pubDate = '2024-02-02', @host = 'Times', @place = 'The web', @accepted = 0;
	SET @Pub_ID = IDENT_CURRENT ('Publication');
	EXEC linkPubThesis @PubID = @Pub_ID, @thesisSerialNo = @ThesisID;



	-- thesis 2 with 1 progress report
	INSERT INTO Thesis (field, type, title, startDate, endDate, noOfExtensions) VALUES ('Sharks', 'Master', 'Sharks Swim or no?', '2030-09-11', '2033-08-08', 0);
	SET @ThesisID = IDENT_CURRENT ('Thesis');

	EXEC AdminIssueThesisPayment @ThesisSerialNo = @ThesisID, @amount = 50, @noOfInstallments = 3,
		@fundPercentage = 75;
	SET @ThesisPaymentID = IDENT_CURRENT ('Payment');
	EXEC AdminIssueInstallPayment @paymentID = @ThesisPaymentID, @InstallStartDate = '2040-01-01';

	EXEC AdminUpdateExtension @ThesisID;
	EXEC AdminUpdateExtension @ThesisID;

	INSERT INTO GUCianStudentRegisterThesis VALUES(@StudentID, @SupervisorID ,@ThesisID);

	EXEC AddGrade @ThesisSerialNo = @ThesisID, @ThesisGrade = 90.00;

	-- 1 progress report
	EXEC AddProgressReport @thesisSerialNo = @ThesisID, @progressReportDate = '2031-01-01';
	SET @ProgressReportNum = (SELECT TOP 1 GUCianProgressReport.no
			FROM GUCianProgressReport
			WHERE @studentID = GUCianProgressReport.sid ORDER BY GUCianProgressReport.no DESC);

	EXEC FillProgressReport @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @state = 20, @description = 'So far sharks do seem to swim';

	EXEC EvaluateProgressReport @supervisorID = @SupervisorID, @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @evaluation = 1;

	-- 1 defenses with old examiners and publication
	EXEC AddDefenseGucian @ThesisSerialNo = @ThesisID, @DefenseDate = '2034-01-01', @DefenseLocation = 'Tank';

	INSERT INTO ExaminerEvaluateDefense (date, serialNo, examinerId) VALUES ('2034-01-01', @ThesisID, @examiner_id1);
	EXEC AddDefenseGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2034-01-01', @grade = 90.00;
	EXEC ExaminerAddCommentsGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2034-01-01', @examinerId = @examiner_id1, @comments = 'Sharks indeed look like they are swimming';

	INSERT INTO ExaminerEvaluateDefense (date, serialNo, examinerId) VALUES ('2034-01-01', @ThesisID, @examiner_id2);
	EXEC AddDefenseGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2034-01-01', @grade = 95.00;
	EXEC ExaminerAddCommentsGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2034-01-01', @examinerId = @examiner_id2, @comments = 'Sharks Swim! WOW!';

	EXEC addPublication @title = 'Sharks swim', @pubDate = '2034-01-02', @host = 'AquaNews', @place = 'Ocean', @accepted = 1;
	SET @Pub_ID = IDENT_CURRENT ('Publication');
	EXEC linkPubThesis @PubID = @Pub_ID, @thesisSerialNo = @ThesisID;

	-------------------------

	-- none gucian Studnet with 1 phones and 1 thesis and 1 progress reports and 1 defenses
	EXEC StudentRegister @first_name = 'Fatma' , @last_name = 'Koshary',@password = 'aTGAs$!@gA',
	@faculty = 'MET', @Gucian = 0, @email = 'fatma.koshary@guc.edu.eg', @address = 'Wekalet ElBalah,St1,Apt2';
	SET @StudentID = IDENT_CURRENT ('PostGradUser');

	UPDATE NonGucianStudent set GPA = 2.70, type = 'MS' WHERE NonGucianStudent.id = @StudentID;

	-- phones
	EXEC addMobile @ID = @StudentID, @mobile_number = '01099654321';

	-- thesis 1, 2 reports, 2 defenses, 1 pub
	-- thesis 1 & grade
	INSERT INTO Thesis (field, type, title, startDate, endDate, noOfExtensions) VALUES ('CS', 'MS', 'Interuppt commands in CPU', '2024-03-04', '2026-01-01', 0);
	SET @ThesisID = IDENT_CURRENT ('Thesis');


	EXEC AdminIssueThesisPayment @ThesisSerialNo = @ThesisID, @amount = 40, @noOfInstallments = 3,
	@fundPercentage = 100;
	SET @ThesisPaymentID = IDENT_CURRENT ('Payment');
	EXEC AdminIssueInstallPayment @paymentID = @ThesisPaymentID, @InstallStartDate = '2024-03-04';

	EXEC AdminUpdateExtension @ThesisID;

	INSERT INTO NonGUCianStudentRegisterThesis VALUES(@StudentID, @SupervisorID ,@ThesisID);

	EXEC AddGrade @ThesisSerialNo = @ThesisID, @ThesisGrade = 99.00;

	-- 1 progress reports
	EXEC AddProgressReport @thesisSerialNo = @ThesisID, @progressReportDate = '2025-01-01';
	SET @ProgressReportNum = (SELECT TOP 1 NonGUCianProgressReport.no
			FROM NonGUCianProgressReport
			WHERE @studentID = NonGUCianProgressReport.sid ORDER BY NonGUCianProgressReport.no DESC);

	EXEC FillProgressReport @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @state = 70, @description = 'Has been successful in re impleminting interrupt commands in Intel processors, resulting in 700% faster CPUs';

	EXEC EvaluateProgressReport @supervisorID = @SupervisorID, @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @evaluation = 3;

	-- ADDING COURSE --

	
	EXEC AddCourse @courseCode = 'CSEN901', @creditHrs = 6, @fees = 10000;
	SET @CourseID = IDENT_CURRENT('Course');

	EXEC linkCourseStudent @courseID = @CourseID, @studentID = @StudentID;

	EXEC addStudentCourseGrade @courseID = @CourseID, @studentID = @StudentID, @grade = 98.0;

	
	SELECT @Fees = fees FROM Course WHERE id = @CourseID;
	
	INSERT INTO PAYMENT (amount, noOfInstallments, fundPercentage) VALUES (@Fees, 3, 100);
	SET @CoursePaymentId = IDENT_CURRENT ('Payment');
	EXEC AdminIssueInstallPayment @paymentID = @CoursePaymentId, @InstallStartDate = '2025-01-01';

	INSERT INTO NonGucianStudentPayForCourse VALUES (@StudentID, @CoursePaymentId, @CourseID);

	-- defenses and publications
	-- 1 defenses
	EXEC AddDefenseGucian @ThesisSerialNo = @ThesisID, @DefenseDate = '2026-01-01', @DefenseLocation = 'C1';

	INSERT INTO ExaminerEvaluateDefense (date, serialNo, examinerId) VALUES ('2026-01-01', @ThesisID, @examiner_id1);
	EXEC AddDefenseGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2026-01-01', @grade = 100.00;
	EXEC ExaminerAddCommentsGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2026-01-01', @examinerId = @examiner_id1, @comments = 'Wonderful';


	EXEC addPublication @title = 'CPU Interuppts', @pubDate = '2026-05-01', @host = 'CNN', @place = 'Internet', @accepted = 1;
	SET @Pub_ID = IDENT_CURRENT ('Publication');
	EXEC linkPubThesis @PubID = @Pub_ID, @thesisSerialNo = @ThesisID;
GO
---------------------------------------------------------------------------------------------------------
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
	EXEC SupervisorRegister @first_name = 'Arturious', @last_name = 'Askeladd', @password = 'deaddad', @faculty = 'History', @email = 'idonthave@gmail.com';
	SET @SupervisorID = IDENT_CURRENT ('PostGradUser');

	-- gucian Studnet with 2 phones and 2 thesis and 3 progress reports and 3 defenses
	EXEC StudentRegister @first_name = 'thorfinn' , @last_name = 'thors', @password = 'wheremydad',
		@faculty = 'History', @Gucian = 1, @email = 'none@gmail.com', @address = 'no home';
	SET @StudentID = IDENT_CURRENT ('PostGradUser');
	EXEC  addUndergradID @studentID = @StudentID, @undergradID = 1341;

	UPDATE GucianStudent set GPA = 2.00, type = 'PhD' WHERE GucianStudent.id = @StudentID;

	-- phones
	EXEC addMobile @ID = @StudentID, @mobile_number = '01111114412';
	

	-- thesis 1, 2 reports, 2 defenses, 1 pub
	-- thesis 1 & grade
	INSERT INTO Thesis (field, type, title, startDate, endDate, noOfExtensions) VALUES ('Philosiphy', 'Phd', 'how to avenge your dad', '2021-01-10', '2022-11-10', 4);
	SET @ThesisID = IDENT_CURRENT ('Thesis');

	EXEC AdminIssueThesisPayment @ThesisSerialNo = @ThesisID, @amount = 140000, @noOfInstallments = 5,
		@fundPercentage = 60;
	SET @ThesisPaymentID = IDENT_CURRENT ('Payment');
	EXEC AdminIssueInstallPayment @paymentID = @ThesisPaymentID, @InstallStartDate = '2021-01-11';

	EXEC AdminUpdateExtension @ThesisID;
	EXEC AdminUpdateExtension @ThesisID;

	INSERT INTO GUCianStudentRegisterThesis(sid, supid, serial_no) VALUES(@StudentID, @SupervisorID ,@ThesisID);
	
	EXEC AddGrade @ThesisSerialNo = @ThesisID, @ThesisGrade = 70.00;

	-- 2 progress reports
	EXEC AddProgressReport @thesisSerialNo = @ThesisID, @progressReportDate = '2021-01-07';
	SET @ProgressReportNum = (SELECT TOP 1 GUCianProgressReport.no
			FROM GUCianProgressReport
			WHERE @studentID = GUCianProgressReport.sid ORDER BY GUCianProgressReport.no DESC);

	EXEC FillProgressReport @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @state = 30, @description = 'need sharp knife';

	EXEC EvaluateProgressReport @supervisorID = @SupervisorID, @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @evaluation = 3;
	--
	EXEC AddProgressReport @thesisSerialNo = @ThesisID, @progressReportDate = '2021-02-08';
	SET @ProgressReportNum = (SELECT TOP 1 GUCianProgressReport.no
			FROM GUCianProgressReport
			WHERE @studentID = GUCianProgressReport.sid ORDER BY GUCianProgressReport.no DESC);

	EXEC FillProgressReport @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @state = 60, @description = 'and a good bow';

	EXEC EvaluateProgressReport @supervisorID = @SupervisorID, @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @evaluation = 1;

	-- defenses and publications
	-- 2 defenses
	EXEC AddDefenseGucian @ThesisSerialNo = @ThesisID, @DefenseDate = '2022-11-01', @DefenseLocation = 'Court Room';
	EXEC AddExaminer @ThesisSerialNo = @ThesisID, @DefenseDate = '2022-11-01', @ExaminerName = 'Ragnar', @National = 0, @fieldOfWork = 'History';
	set @examiner_id1 = IDENT_CURRENT ('PostGradUser');
	EXEC AddDefenseGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2022-11-01', @grade = 20.00;
	EXEC ExaminerAddCommentsGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2022-11-01', @examinerId = @examiner_id1, @comments = 'bad temper';

	EXEC AddDefenseGucian @ThesisSerialNo = @ThesisID, @DefenseDate = '2023-08-09', @DefenseLocation = 'execution room';
	EXEC AddExaminer @ThesisSerialNo = @ThesisID, @DefenseDate = '2023-08-09', @ExaminerName = 'king of england', @National = 0, @fieldOfWork = 'I dont work';
	set @examiner_id2 = IDENT_CURRENT ('PostGradUser');
	EXEC AddDefenseGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2023-08-09', @grade = 97.00;
	EXEC ExaminerAddCommentsGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2023-08-09', @examinerId = @examiner_id2, @comments = 'calm down son';

	EXEC addPublication @title = 'I cat write', @pubDate = '2024-11-10', @host = 'the news room', @place = 'back room', @accepted = 1;
	SET @Pub_ID = IDENT_CURRENT ('Publication');
	EXEC linkPubThesis @PubID = @Pub_ID, @thesisSerialNo = @ThesisID;


	-- thesis 2 with 1 progress report
	INSERT INTO Thesis (field, type, title, startDate, endDate, noOfExtensions) VALUES ('anatomy', 'Master', 'how much blood do you need', '2010-09-11', '2011-08-08', 0);
	SET @ThesisID = IDENT_CURRENT ('Thesis');

	EXEC AdminIssueThesisPayment @ThesisSerialNo = @ThesisID, @amount = 800, @noOfInstallments = 3,
		@fundPercentage = 75;
	SET @ThesisPaymentID = IDENT_CURRENT ('Payment');
	EXEC AdminIssueInstallPayment @paymentID = @ThesisPaymentID, @InstallStartDate = '2011-01-01';

	EXEC AdminUpdateExtension @ThesisID;
	EXEC AdminUpdateExtension @ThesisID;

	INSERT INTO GUCianStudentRegisterThesis VALUES(@StudentID, @SupervisorID ,@ThesisID);

	EXEC AddGrade @ThesisSerialNo = @ThesisID, @ThesisGrade = 87.00;

	-- 1 progress report
	EXEC AddProgressReport @thesisSerialNo = @ThesisID, @progressReportDate = '2011-01-01';
	SET @ProgressReportNum = (SELECT TOP 1 GUCianProgressReport.no
			FROM GUCianProgressReport
			WHERE @studentID = GUCianProgressReport.sid ORDER BY GUCianProgressReport.no DESC);

	EXEC FillProgressReport @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @state = 20, @description = 'maybe 2 liters';

	EXEC EvaluateProgressReport @supervisorID = @SupervisorID, @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @evaluation = 1;

	-- 1 defenses with old examiners and publication
	EXEC AddDefenseGucian @ThesisSerialNo = @ThesisID, @DefenseDate = '2012-01-01', @DefenseLocation = 'Tank';

	INSERT INTO ExaminerEvaluateDefense (date, serialNo, examinerId) VALUES ('2012-01-01', @ThesisID, @examiner_id1);
	EXEC AddDefenseGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2012-01-01', @grade = 70.00;
	EXEC ExaminerAddCommentsGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2012-01-01', @examinerId = @examiner_id1, @comments = '2 liters can confirm';

	INSERT INTO ExaminerEvaluateDefense (date, serialNo, examinerId) VALUES ('2012-01-01', @ThesisID, @examiner_id2);
	EXEC AddDefenseGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2012-01-01', @grade = 45.00;
	EXEC ExaminerAddCommentsGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2012-01-01', @examinerId = @examiner_id2, @comments = '1 maybe ?';

	EXEC addPublication @title = 'too much bld', @pubDate = '2013-01-02', @host = 'bldnws', @place = 'ireland', @accepted = 1;
	SET @Pub_ID = IDENT_CURRENT ('Publication');
	EXEC linkPubThesis @PubID = @Pub_ID, @thesisSerialNo = @ThesisID;

	-------------------------

	-- none gucian Studnet with 1 phones and 1 thesis and 1 progress reports and 1 defenses
	EXEC StudentRegister @first_name = 'canute' , @last_name = 'kingsman',@password = 'fatherleft',
	@faculty = 'viking', @Gucian = 0, @email = 'oldhotmail', @address = 'homeless';
	SET @StudentID = IDENT_CURRENT ('PostGradUser');

	UPDATE NonGucianStudent set GPA = 4.70, type = 'MS' WHERE NonGucianStudent.id = @StudentID;

	-- phones
	EXEC addMobile @ID = @StudentID, @mobile_number = '01111654321';

	-- thesis 1, 2 reports, 2 defenses, 1 pub
	-- thesis 1 & grade
	INSERT INTO Thesis (field, type, title, startDate, endDate, noOfExtensions) VALUES ('leadership', 'MS', 'how to lead', '2022-03-04', '2028-01-01', 0);
	SET @ThesisID = IDENT_CURRENT ('Thesis');


	EXEC AdminIssueThesisPayment @ThesisSerialNo = @ThesisID, @amount = 4500, @noOfInstallments = 3,
	@fundPercentage = 100;
	SET @ThesisPaymentID = IDENT_CURRENT ('Payment');
	EXEC AdminIssueInstallPayment @paymentID = @ThesisPaymentID, @InstallStartDate = '2022-03-04';

	EXEC AdminUpdateExtension @ThesisID;

	INSERT INTO NonGUCianStudentRegisterThesis VALUES(@StudentID, @SupervisorID ,@ThesisID);

	EXEC AddGrade @ThesisSerialNo = @ThesisID, @ThesisGrade = 99.00;

	-- 1 progress reports
	EXEC AddProgressReport @thesisSerialNo = @ThesisID, @progressReportDate = '2023-01-01';
	SET @ProgressReportNum = (SELECT TOP 1 NonGUCianProgressReport.no
			FROM NonGUCianProgressReport
			WHERE @studentID = NonGUCianProgressReport.sid ORDER BY NonGUCianProgressReport.no DESC);

	EXEC FillProgressReport @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @state = 77, @description = 'sigma male';

	EXEC EvaluateProgressReport @supervisorID = @SupervisorID, @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @evaluation = 3;

	-- ADDING COURSE --

	
	EXEC AddCourse @courseCode = 'BSN 101', @creditHrs = 4, @fees = 12000;
	SET @CourseID = IDENT_CURRENT('Course');

	EXEC linkCourseStudent @courseID = @CourseID, @studentID = @StudentID;

	EXEC addStudentCourseGrade @courseID = @CourseID, @studentID = @StudentID, @grade = 78.0;

	
	SELECT @Fees = fees FROM Course WHERE id = @CourseID;
	
	INSERT INTO PAYMENT (amount, noOfInstallments, fundPercentage) VALUES (@Fees, 2, 10);
	SET @CoursePaymentId = IDENT_CURRENT ('Payment');
	EXEC AdminIssueInstallPayment @paymentID = @CoursePaymentId, @InstallStartDate = '2023-01-01';

	INSERT INTO NonGucianStudentPayForCourse VALUES (@StudentID, @CoursePaymentId, @CourseID);

	-- defenses and publications
	-- 1 defenses
	EXEC AddDefenseGucian @ThesisSerialNo = @ThesisID, @DefenseDate = '2028-01-01', @DefenseLocation = 'D1';

	INSERT INTO ExaminerEvaluateDefense (date, serialNo, examinerId) VALUES ('2028-01-01', @ThesisID, @examiner_id1);
	EXEC AddDefenseGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2028-01-01', @grade = 105.00;
	EXEC ExaminerAddCommentsGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2028-01-01', @examinerId = @examiner_id1, @comments = 'good work';


	EXEC addPublication @title = 'leadrship skills', @pubDate = '2028-05-01', @host = 'BCC', @place = 'Internet', @accepted = 1;
	SET @Pub_ID = IDENT_CURRENT ('Publication');
	EXEC linkPubThesis @PubID = @Pub_ID, @thesisSerialNo = @ThesisID;
GO


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
	EXEC SupervisorRegister @first_name = 'Samy', @last_name = 'Fattah', @password = 'shiko23', @faculty = 'Pharmacy', @email = 'samyff@gmail.com';
	SET @SupervisorID = IDENT_CURRENT ('PostGradUser');

	-- gucian Studnet with 2 phones and 2 thesis and 3 progress reports and 3 defenses
	EXEC StudentRegister @first_name = 'Hady' , @last_name = 'Abo Hady', @password = 'hadhadhad2233',
		@faculty = 'Pharmacy', @Gucian = 1, @email = 'aboelhadahed@gmail.com', @address = 'Share3 El Hoda';
	SET @StudentID = IDENT_CURRENT ('PostGradUser');
	EXEC  addUndergradID @studentID = @StudentID, @undergradID = 300;

	UPDATE GucianStudent set GPA = 2, type = 'Phd' WHERE GucianStudent.id = @StudentID;

	-- phones
	EXEC addMobile @ID = @StudentID, @mobile_number = '01099999999';


	-- thesis 1, 2 reports, 2 defenses, 1 pub
	-- thesis 1 & grade
	INSERT INTO Thesis (field, type, title, startDate, endDate, noOfExtensions) VALUES ('Chemistry', 'MS', 'H2O', '2021-9-12', '2025-12-12', 0);
	SET @ThesisID = IDENT_CURRENT ('Thesis');

	EXEC AdminIssueThesisPayment @ThesisSerialNo = @ThesisID, @amount = 513210, @noOfInstallments = 3,
		@fundPercentage = 100;
	SET @ThesisPaymentID = IDENT_CURRENT ('Payment');
	EXEC AdminIssueInstallPayment @paymentID = @ThesisPaymentID, @InstallStartDate = '2021-12-01';

	EXEC AdminUpdateExtension @ThesisID;

	INSERT INTO GUCianStudentRegisterThesis(sid, supid, serial_no) VALUES(@StudentID, @SupervisorID ,@ThesisID);
	
	EXEC AddGrade @ThesisSerialNo = @ThesisID, @ThesisGrade = 85.00;

	-- 2 progress reports
	EXEC AddProgressReport @thesisSerialNo = @ThesisID, @progressReportDate = '2022-07-01';
	SET @ProgressReportNum = (SELECT TOP 1 GUCianProgressReport.no
			FROM GUCianProgressReport
			WHERE @studentID = GUCianProgressReport.sid ORDER BY GUCianProgressReport.no DESC);

	EXEC FillProgressReport @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @state = 75, @description = 'Water is made of h2o';

	EXEC EvaluateProgressReport @supervisorID = @SupervisorID, @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @evaluation = 4;
	--
	EXEC AddProgressReport @thesisSerialNo = @ThesisID, @progressReportDate = '2022-09-01';
	SET @ProgressReportNum = (SELECT TOP 1 GUCianProgressReport.no
			FROM GUCianProgressReport
			WHERE @studentID = GUCianProgressReport.sid ORDER BY GUCianProgressReport.no DESC);

	EXEC FillProgressReport @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @state = 100, @description = 'h2o makes water';

	EXEC EvaluateProgressReport @supervisorID = @SupervisorID, @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @evaluation = 9;

	-- defenses and publications
	-- 2 defenses
	EXEC AddDefenseGucian @ThesisSerialNo = @ThesisID, @DefenseDate = '2025-06-09', @DefenseLocation = 'Chem lab';
	EXEC AddExaminer @ThesisSerialNo = @ThesisID, @DefenseDate = '2025-06-09', @ExaminerName = 'Marie Curie JR', @National = 0, @fieldOfWork = 'chemistry';
	set @examiner_id2 = IDENT_CURRENT ('PostGradUser');
	EXEC AddDefenseGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2025-06-09', @grade = 100.00;
	EXEC ExaminerAddCommentsGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2025-06-09', @examinerId = @examiner_id2, @comments = 'this water taste good';

	
	EXEC AddDefenseGucian @ThesisSerialNo = @ThesisID, @DefenseDate = '2025-07-09', @DefenseLocation = 'chem lab 2nd floor';
	EXEC AddExaminer @ThesisSerialNo = @ThesisID, @DefenseDate = '2025-07-09', @ExaminerName = 'Marie curie', @National = 1, @fieldOfWork = 'chemistry';
	set @examiner_id1 = IDENT_CURRENT ('PostGradUser');
	EXEC AddDefenseGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2025-07-09', @grade = 100.00;
	EXEC ExaminerAddCommentsGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2025-07-09', @examinerId = @examiner_id1, @comments = 'h2o taste like water i agree';

	EXEC addPublication @title = 'DONT DRINK H2O', @pubDate = '2025-07-09', @host = 'FOX NEWS', @place = 'Alabama', @accepted = 1;
	SET @Pub_ID = IDENT_CURRENT ('Publication');
	EXEC linkPubThesis @PubID = @Pub_ID, @thesisSerialNo = @ThesisID;



	-- thesis 2 with 1 progress report
	INSERT INTO Thesis (field, type, title, startDate, endDate, noOfExtensions) VALUES ('Chemistry', 'Phd', 'Iron is metal', '2030-01-01', '2035-01-01', 0);
	SET @ThesisID = IDENT_CURRENT ('Thesis');

	EXEC AdminIssueThesisPayment @ThesisSerialNo = @ThesisID, @amount = 9000, @noOfInstallments = 3,
		@fundPercentage = 75;
	SET @ThesisPaymentID = IDENT_CURRENT ('Payment');
	EXEC AdminIssueInstallPayment @paymentID = @ThesisPaymentID, @InstallStartDate = '2030-01-05';

	EXEC AdminUpdateExtension @ThesisID;
	EXEC AdminUpdateExtension @ThesisID;

	INSERT INTO GUCianStudentRegisterThesis VALUES(@StudentID, @SupervisorID ,@ThesisID);

	EXEC AddGrade @ThesisSerialNo = @ThesisID, @ThesisGrade = 100.00;

	-- 1 progress report
	EXEC AddProgressReport @thesisSerialNo = @ThesisID, @progressReportDate = '2030-12-01';
	SET @ProgressReportNum = (SELECT TOP 1 GUCianProgressReport.no
			FROM GUCianProgressReport
			WHERE @studentID = GUCianProgressReport.sid ORDER BY GUCianProgressReport.no DESC);

	EXEC FillProgressReport @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @state = 50, @description = 'Iron is hard';

	EXEC EvaluateProgressReport @supervisorID = @SupervisorID, @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @evaluation = 9;

	-- 1 defenses with old examiners and publication
	EXEC AddDefenseGucian @ThesisSerialNo = @ThesisID, @DefenseDate = '2036-01-01', @DefenseLocation = 'Workshop';

	INSERT INTO ExaminerEvaluateDefense (date, serialNo, examinerId) VALUES ('2036-01-01', @ThesisID, @examiner_id1);
	EXEC AddDefenseGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2036-01-01', @grade = 99.00;
	EXEC ExaminerAddCommentsGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2036-01-01', @examinerId = @examiner_id1, @comments = 'Ive always thought about that!';

	INSERT INTO ExaminerEvaluateDefense (date, serialNo, examinerId) VALUES ('2036-01-01', @ThesisID, @examiner_id2);
	EXEC AddDefenseGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2036-01-01', @grade = 100.00;
	EXEC ExaminerAddCommentsGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2036-01-01', @examinerId = @examiner_id2, @comments = 'METAL IS PERFECTION';

	EXEC addPublication @title = 'Why you should eat your car', @pubDate = '2037-01-01', @host = 'FOX NEWS', @place = 'Alabama', @accepted = 1;
	SET @Pub_ID = IDENT_CURRENT ('Publication');
	EXEC linkPubThesis @PubID = @Pub_ID, @thesisSerialNo = @ThesisID;

	-------------------------

	-- none gucian Studnet with 1 phones and 1 thesis and 1 progress reports and 1 defenses
	EXEC StudentRegister @first_name = 'Alexandria' , @last_name = 'Ocasio Cortez',@password = 'Socialismlolz123',
	@faculty = 'Politics', @Gucian = 0, @email = 'tankygirl@gmail.com', @address = 'New York baby';
	SET @StudentID = IDENT_CURRENT ('PostGradUser');

	UPDATE NonGucianStudent set GPA = 0.7, type = 'MS' WHERE NonGucianStudent.id = @StudentID;

	-- phones
	EXEC addMobile @ID = @StudentID, @mobile_number = '95632158';

	-- thesis 1, 2 reports, 2 defenses, 1 pub
	-- thesis 1 & grade
	INSERT INTO Thesis (field, type, title, startDate, endDate, noOfExtensions) VALUES ('Politics', 'MS', 'why the poor need to eat actually', '2022-09-01', '2025-09-01', 0);
	SET @ThesisID = IDENT_CURRENT ('Thesis');


	EXEC AdminIssueThesisPayment @ThesisSerialNo = @ThesisID, @amount = 999999, @noOfInstallments = 3,
	@fundPercentage = 75;
	SET @ThesisPaymentID = IDENT_CURRENT ('Payment');
	EXEC AdminIssueInstallPayment @paymentID = @ThesisPaymentID, @InstallStartDate = '2022-09-01';

	EXEC AdminUpdateExtension @ThesisID;
	EXEC AdminUpdateExtension @ThesisID;

	INSERT INTO NonGUCianStudentRegisterThesis VALUES(@StudentID, @SupervisorID ,@ThesisID);

	EXEC AddGrade @ThesisSerialNo = @ThesisID, @ThesisGrade = 0.00;

	-- 1 progress reports
	EXEC AddProgressReport @thesisSerialNo = @ThesisID, @progressReportDate = '2023-01-01';
	SET @ProgressReportNum = (SELECT TOP 1 NonGUCianProgressReport.no
			FROM NonGUCianProgressReport
			WHERE @studentID = NonGUCianProgressReport.sid ORDER BY NonGUCianProgressReport.no DESC);

	EXEC FillProgressReport @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @state = 100, @description = 'guys i believe the poor do need to eat';

	EXEC EvaluateProgressReport @supervisorID = @SupervisorID, @thesisSerialNo = @ThesisID, @progressReportNo = @ProgressReportNum, @evaluation = 0;

	-- ADDING COURSE --

	
	EXEC AddCourse @courseCode = 'cook101', @creditHrs = 2, @fees = 10000;
	SET @CourseID = IDENT_CURRENT('Course');

	EXEC linkCourseStudent @courseID = @CourseID, @studentID = @StudentID;

	EXEC addStudentCourseGrade @courseID = @CourseID, @studentID = @StudentID, @grade = 100.0;

	
	SELECT @Fees = fees FROM Course WHERE id = @CourseID;
	
	INSERT INTO PAYMENT (amount, noOfInstallments, fundPercentage) VALUES (@Fees, 3, 0);
	SET @CoursePaymentId = IDENT_CURRENT ('Payment');
	EXEC AdminIssueInstallPayment @paymentID = @CoursePaymentId, @InstallStartDate = '2023-01-03';

	INSERT INTO NonGucianStudentPayForCourse VALUES (@StudentID, @CoursePaymentId, @CourseID);

	-- defenses and publications
	-- 1 defenses
	EXEC AddDefenseGucian @ThesisSerialNo = @ThesisID, @DefenseDate = '2025-05-05', @DefenseLocation = 'Congress';

	INSERT INTO ExaminerEvaluateDefense (date, serialNo, examinerId) VALUES ('2025-05-05', @ThesisID, @examiner_id1);
	EXEC AddDefenseGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2025-05-05', @grade = 0.00;
	EXEC ExaminerAddCommentsGrade @ThesisSerialNo = @ThesisID, @DefenseDate = '2025-05-05', @examinerId = @examiner_id1, @comments = 'no poor no need eat. gimme money';


	EXEC addPublication @title = 'AOC WANTS TO EAT YOUR CHILDREN', @pubDate = '2025-05-05', @host = 'FOX NEWS', @place = 'Alabama', @accepted = 0;
	SET @Pub_ID = IDENT_CURRENT ('Publication');
	EXEC linkPubThesis @PubID = @Pub_ID, @thesisSerialNo = @ThesisID;
GO



UPDATE Installment SET done = 1 WHERE date < '2021-01-01';

