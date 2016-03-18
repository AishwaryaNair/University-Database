-- The following view shows Scheduled Courses that require to take prerequisite courses
-- The view includes the following data:
-- CourseId
-- CourseTitle
-- FacultyName
-- Semester
-- Year
-- StartDate
-- EndDate


CREATE VIEW pr2.ScheduledPrerequisites AS
	SELECT c.CourseId, c.CourseTitle, p.FirstName + ' ' + p.LastName AS FacultyName, sem.Semester, si.SemYear, si.StartDate, si.EndDate, 
		   dc.DayOfTheWeek, dc.StartTime, dc.EndTime 
		FROM pr2.ScheduledCourses sc INNER JOIN pr2.Courses c
			ON sc.CourseId = c.CourseId
			RIGHT OUTER JOIN pr2.Prerequisites pr
				ON c.CourseId = pr.ParentCourseId
			INNER JOIN pr2.Employees emp
				ON sc.FacultyId = emp.EmployeeId
			INNER JOIN pr2.Person p
				ON emp.PersonId = p. PersonId
			INNER JOIN pr2.SemesterInfo si
				ON sc.Semester = si.SemesterId
			INNER JOIN pr2.Semester sem
				ON sem.SemesterId = si.SemesterId
			LEFT OUTER JOIN pr2.DailyCourseDay dc
				ON sc.ScheduleId = dc.ScheduledId

SELECT * FROM pr2.ScheduledPrerequisites;

DROP VIEW pr2.ScheduledPrerequisites;