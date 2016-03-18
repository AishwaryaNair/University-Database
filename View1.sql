-- The following view shows the Enrollment data of all the students in the university 
-- The view includes the following data
-- Student Name as StudentFirstName + StudentLastName
-- Course Id
-- Course Title
-- Faculty for that course
-- Grade

CREATE VIEW pr2.StudentCourse AS
	SELECT p1.FirstName + ' ' + p1.LastName AS StudentName, c.CourseId, c.CourseTitle, p2.FirstName + ' ' + p2.LastName AS FacultyName, sg.GradePoints
		FROM pr2.Person p1 INNER JOIN pr2.Students s
			ON p1.PersonId = s.PersonId
			RIGHT OUTER JOIN pr2.Enrollment e
				ON s.StudentId = e.StudentId
			INNER JOIN pr2.ScheduledCourses sc
				ON e.ScheduleId = sc.ScheduleId
			INNER JOIN pr2.Courses c
				ON sc.CourseId = c.CourseId
			LEFT OUTER JOIN pr2.Employees emp
				ON emp.EmployeeId = sc.FacultyId
			LEFT OUTER JOIN pr2.Person p2
				ON p2.PersonId = emp.PersonId
			LEFT OUTER JOIN pr2.StudentGrade sg
				ON e.StudentGrade = sg.Grade;

SELECT * FROM pr2.StudentCourse

DROP VIEW pr2.StudentCourse


