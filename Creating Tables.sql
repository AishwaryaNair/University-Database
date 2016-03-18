-- Table: PersonStatus
CREATE TABLE pr2.PersonStatus (
    StatusId			INT				PRIMARY KEY		IDENTITY(1, 1),
    PersonStatus		VARCHAR(10)		NOT NULL
);
GO

-- Table: Addresses
CREATE TABLE pr2.Addresses (
    AddressId			INT				PRIMARY KEY		IDENTITY(1, 1),
    AddressLine1		VARCHAR(50)		NOT NULL,
    AddressLine2		VARCHAR(50),
    City				VARCHAR(50)		NOT NULL,
    State				VARCHAR(50)		NOT NULL,
    Country				VARCHAR(50)		NOT NULL,
    PostalCode			VARCHAR(20)		NOT NULL
);
GO

-- Table: Person
CREATE TABLE pr2.Person (
    PersonId			VARCHAR(10)		PRIMARY KEY,
    FirstName			VARCHAR(20)		NOT NULL,
    LastName			VARCHAR(20)		NOT NULL,
    NetID				VARCHAR(20)		NOT NULL,
    Password			VARCHAR(50),
    DateOfBirth			DATE			NOT NULL,
    SocialSecurityNo	CHAR(10),
    LocalAddress		INT				NOT NULL		REFERENCES pr2.Addresses(AddressId),
    HomeAddress			INT 							REFERENCES pr2.Addresses(AddressId),
	PersonStatus		INT				NOT NULL		REFERENCES pr2.PersonStatus(StatusId)
);
GO

-- Table: StudentStatus
CREATE TABLE pr2.StudentStatus (
    StatusId			INT				PRIMARY KEY		IDENTITY(1, 1),
    StudentStatus		VARCHAR(20)		NOT NULL
);
GO

-- Table: Students
CREATE TABLE pr2.Students (
    StudentId			VARCHAR(10)		PRIMARY KEY,
    PersonId			VARCHAR(10)		NOT NULL		REFERENCES pr2.Person(PersonId),
    StudentStatusId		INT				NOT NULL		REFERENCES pr2.StudentStatus(StatusId)
);
GO

-- Table: Colleges
CREATE TABLE pr2.Colleges (
	CollegeId			INT				PRIMARY KEY		IDENTITY(1, 1),
    CollegeName			VARCHAR(100)		NOT NULL
);
GO

-- Table: ProgramOfStudy
CREATE TABLE pr2.ProgramOfStudy (
    ProgOfStudyId		VARCHAR(10)		PRIMARY KEY,
    ProgOfStudy			VARCHAR(50)		NOT NULL,
    CollegeId			INT				NOT NULL		REFERENCES pr2.Colleges(CollegeId)
);
GO

-- Table: Majors
CREATE TABLE pr2.Majors (
	MajorId				INT				PRIMARY KEY		IDENTITY(1,1),
    StudentId			VARCHAR(10)		NOT NULL		REFERENCES pr2.Students(StudentId),
    ProgOfStudyId		VARCHAR(10)		NOT NULL		REFERENCES pr2.ProgramOfStudy(ProgOfStudyId)
);
GO

-- Table: Minors
CREATE TABLE pr2.Minors (
	MinorId				INT				PRIMARY KEY		IDENTITY(1,1),
    StudentId			VARCHAR(10)		NOT NULL		REFERENCES pr2.Students(StudentId),
    ProgOfStudyId		VARCHAR(10)		NOT NULL		REFERENCES pr2.ProgramOfStudy(ProgOfStudyId)
);
GO

-- Table: BenefitsSelection
CREATE TABLE pr2.BenefitsSelection (
    BenefitsId			INT				PRIMARY KEY		IDENTITY(1, 1),
    Benefits			VARCHAR(20)		NOT NULL
);
GO

-- Table: HealthBenefits
CREATE TABLE pr2.HealthBenefits (
    HealthBenefitsId	VARCHAR(10)		PRIMARY KEY,
    Cost				DECIMAL(10,2)	NOT NULL,
    BenefitsSelection	INT				NOT NULL		REFERENCES pr2.BenefitsSelection(BenefitsId)			
);
GO

-- Table: VisionBenefits
CREATE TABLE pr2.VisionBenefits (
    VisionBenefitsId	VARCHAR(10)		PRIMARY KEY,
    Cost				DECIMAL(10,2)	NOT NULL,
    BenefitsSelection	INT				NOT NULL		REFERENCES pr2.BenefitsSelection(BenefitsId)			
);
GO

-- Table: DentalBenefits
CREATE TABLE pr2.DentalBenefits (
    DentalBenefitsId	VARCHAR(10)		PRIMARY KEY,
    Cost				DECIMAL(10,2)	NOT NULL,
    BenefitsSelection	INT				NOT NULL		REFERENCES pr2.BenefitsSelection(BenefitsId)
);
GO

-- Table: JobInformation
CREATE TABLE pr2.JobInformation (
    JobInformationId	VARCHAR(10)		PRIMARY KEY,
    JobTitle			VARCHAR(50)		NOT NULL,
    JobDescription		VARCHAR(500)	NOT NULL,
    JobRequirements		VARCHAR(1000)	NOT NULL,
    MinPay				INT				NOT NULL,
    MaxPay				INT				NOT NULL,
    UnionJob			BIT				NOT NULL
);
GO

-- Table: Employees
CREATE TABLE pr2.Employees (
    EmployeeId			VARCHAR(10)		PRIMARY KEY,
    PersonId			VARCHAR(10)		NOT NULL		REFERENCES pr2.Person(PersonId),
    YearlyPay			INT				NOT NULL,
    JobInformation		VARCHAR(10)		NOT NULL		REFERENCES pr2.JobInformation(JobInformationId),
    HealthBenefits		VARCHAR(10)		NOT NULL		REFERENCES pr2.HealthBenefits(HealthBenefitsId), 
	VisionBenefits		VARCHAR(10)		NOT NULL		REFERENCES pr2.VisionBenefits(VisionBenefitsId),
    DentalBenefits		VARCHAR(10)		NOT NULL		REFERENCES pr2.DentalBenefits( DentalBenefitsId)
);
GO

-- Table: Courses
CREATE TABLE pr2.Courses (
    CourseId			VARCHAR(10)		PRIMARY KEY,
    CourseCode			VARCHAR(10)		NOT NULL,
    CourseNumber		VARCHAR(10)		NOT NULL,
    CourseTitle			VARCHAR(100)		NOT NULL,
    CourseDescription	VARCHAR(1000)	NOT NULL
);
GO

-- Table: Prerequisites
CREATE TABLE pr2.Prerequisites (
    PrereqId			VARCHAR(20)		PRIMARY KEY,
    ParentCourseId		VARCHAR(10)		NOT NULL		REFERENCES pr2.Courses(CourseId),
    ChildCourseId		VARCHAR(10)		NOT NULL		REFERENCES pr2.Courses(CourseId)
);
GO

-- Table: Semester
CREATE TABLE pr2.Semester (
    SemesterId			INT				PRIMARY KEY		IDENTITY(1, 1),
    Semester			VARCHAR(20)		NOT NULL
);
GO

-- Table: SemesterInfo
CREATE TABLE pr2.SemesterInfo (
    SemesterId			INT				PRIMARY KEY		IDENTITY(1, 1),
    Semester			INT				NOT NULL		REFERENCES pr2.Semester(SemesterId),
    SemYear				CHAR(4)			NOT NULL,
    StartDate			DATE			NOT NULL,
    EndDate				DATE			NOT NULL,
);
GO

-- Table: BuildingName
CREATE TABLE pr2.BuildingName (
    BuildingId			VARCHAR(10)		PRIMARY KEY,
    Name				VARCHAR(50)		NOT NULL,
);
GO

-- Table: Location
CREATE TABLE pr2.Location (
    LocationId			VARCHAR(10)		PRIMARY KEY,
    BuildingName		VARCHAR(10)		NOT NULL		REFERENCES pr2.BuildingName(BuildingId),
    RoomNumber			INT				NOT NULL
);
GO

-- Table: Projector
CREATE TABLE pr2.Projector (
    ProjectorId			INT				PRIMARY KEY		IDENTITY(1, 1),
    ProjectorText		VARCHAR(20)		NOT NULL
);
GO

-- Table: Classroom
CREATE TABLE pr2.Classroom (
    ClassroomId			INT				PRIMARY KEY     IDENTITY(1, 1),
    Location			VARCHAR(10)		NOT NULL		REFERENCES pr2.Location(LocationId),
	MaxSeating			INT				NOT NULL		CHECK(MaxSeating >= 0),
	Projector			INT				NOT NULL		REFERENCES pr2.Projector(ProjectorId),
    NoOfWhiteBoards		INT				NOT NULL		CHECK(NumberofWhiteBoards >= 0),
    AVEquipment			VARCHAR(1000)	NOT NULL  
);
GO

-- Table: ScheduledCourses
CREATE TABLE pr2.ScheduledCourses (
    ScheduleId			INT				PRIMARY KEY     IDENTITY(1, 1),
    CourseId			VARCHAR(10)		NOT NULL		REFERENCES pr2.Courses(CourseId),
    FacultyId			VARCHAR(10)						REFERENCES pr2.Employees(EmployeeId),
    Semester			INT				NOT NULL		REFERENCES pr2.SemesterInfo(SemesterId),
    NoOfSeats			INT				NOT NULL		CHECK(NoOfSeats >= 0),
    Classroom			INT								REFERENCES pr2.Classroom(ClassroomId)
);
GO

-- Table: DailyCourseDay
CREATE TABLE pr2.DailyCourseDay (
    DailyCourseId		INT				NOT NULL		IDENTITY(1, 1),
    ScheduledId			INT				NOT NULL		REFERENCES pr2.ScheduledCourses(ScheduleId),
    DayOfTheWeek		VARCHAR(20)		NOT NULL,
    StartTime			TIME(0)			NOT NULL,
    EndTime				TIME(0)			NOT NULL
);
GO

-- Table: EnrollmentStatus
CREATE TABLE pr2.EnrollmentStatus (
    StatusId			INT				PRIMARY KEY		IDENTITY(1, 1),
    EnrollmentStatus	VARCHAR(20)		NOT NULL
);
GO

-- Table: StudentGrade
CREATE TABLE pr2.StudentGrade (
    Grade				VARCHAR(20)		PRIMARY KEY,
	GradePoints			DECIMAL(4,2)    NOT NULL
);
GO

-- Table: Enrollment
CREATE TABLE pr2.Enrollment (
    EnrollmentId		INT				PRIMARY KEY		IDENTITY(1, 1),
    StudentId			VARCHAR(10)		NOT NULL		REFERENCES pr2.Students(StudentId) ,
    ScheduleId			INT				NOT NULL		REFERENCES pr2.ScheduledCourses(ScheduleId),
    EnrollmentStatus	INT				NOT NULL		REFERENCES pr2.EnrollmentStatus(StatusId),
    StudentGrade		VARCHAR(20)						REFERENCES pr2.StudentGrade(Grade)
);
GO