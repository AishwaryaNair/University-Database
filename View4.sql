-- The following view shows courses that the university is offering which are scheduled on Friday.
-- The view includes the following data:
-- CourseId
-- CourseTitle
-- StartTime
-- EndTime
-- Day Of The Week
-- Faculty for that course
-- Building the course is scheduled in
-- Room Number

CREATE VIEW pr2.FridayCourses AS
	SELECT c.CourseId, c.CourseTitle, ds.DayOfTheWeek, ds.StartTime, ds.EndTime, p.FirstName + ' ' + p.LastName AS FacultyName, bn.Name AS BuildingName, loc.RoomNumber
		FROM pr2.DailyCourseDay ds INNER JOIN pr2.ScheduledCourses sc
			ON ds.DayOfTheWeek = 'Friday' AND ds.ScheduledId = sc.ScheduleId
			INNER JOIN Courses c
				ON sc.CourseId = c.CourseId
			INNER JOIN Employees emp
				ON sc.FacultyId = emp.EmployeeId
			INNER JOIN Person p
				ON emp.PersonId = p.PersonId
			INNER JOIN Classroom class
				ON sc.Classroom = class.ClassroomId
			INNER JOIN Location loc
				ON class.Location = loc.LocationId
			INNER JOIN BuildingName bn
				ON loc.BuildingName = bn.BuildingId;

SELECT * FROM pr2.FridayCourses

DROP VIEW pr2.FridayCourses;

