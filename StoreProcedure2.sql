-- The following store procedure assigns a valid grade to the students enrolled in the course.
-- If the student is not enrolled it prints ‘Error student not enrolled’. If the grade point entered 
-- is not valid it prints ‘Error: The Grade Point to be assigned is not a valid Grade Point.

CREATE PROCEDURE pr2.AssignGrades(@studentId VARCHAR(10), 
								  @courseid VARCHAR(10), 
								  @gradepoint DECIMAL(4,2)) AS
	DECLARE @oldgrade VARCHAR(20)
	DECLARE @newgrade VARCHAR(20)
	DECLARE @scheduleid INT
	SET @scheduleid = (SELECT ScheduleId
							FROM pr2.ScheduledCourses
							WHERE CourseId = @courseid)
	IF EXISTS(SELECT * 
				FROM pr2.Enrollment
				WHERE StudentId = @studentId AND ScheduleId = @scheduleid)
		BEGIN
			IF EXISTS (SELECT * 
							FROM pr2.StudentGrade
							WHERE GradePoints = @gradepoint)
				BEGIN
					SET @newgrade = (SELECT Grade
											FROM pr2.StudentGrade
											WHERE GradePoints = @gradePoint)
					SET @oldgrade = (SELECT StudentGrade
										FROM pr2.Enrollment
										WHERE StudentId = @studentId AND ScheduleId = @scheduleid)
					IF @oldgrade IS NOT NULL
						BEGIN
							UPDATE pr2.Enrollment
							SET StudentGrade = @newgrade
								WHERE StudentId = @studentid AND ScheduleId = @scheduleid
							PRINT 'The student''s old grade ' + @oldgrade + ' was changed to ' + @newgrade
						END
					ELSE
						BEGIN
							UPDATE pr2.Enrollment
							SET StudentGrade = @newgrade
								WHERE StudentId = @studentid AND ScheduleId = @scheduleid
							PRINT 'The student''s grade was updated to ' + @newgrade
						END
				END
			ELSE
				BEGIN
					PRINT 'Error: The Grade Point to be assigned is not a valid Grade Point.'
				END
		END
	ELSE
		BEGIN
			PRINT 'Error: The student has not enrolled in the course.'
		END;

-- The store procedure displays results as follows:
-- The Student is not enrolled in the course
EXEC pr2.AssignGrades 'STU01-AD', 'ANT624', 3.66;

-- The GradePoint to be assigned is not a valid GradePoint
EXEC pr2.AssignGrades 'STU01-AD', 'ELE606', 3.2;

-- The student already has a grade assigned
EXEC pr2.AssignGrades 'STU05-TZ', 'FSC635', 3.66;

-- The student had no grade assigned previously
EXEC pr2.AssignGrades 'STU03-JZ', 'PHO605', 3.33;

