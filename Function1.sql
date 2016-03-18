-- The following function calculates the total fees of a student. The function accepts StudentId, 
-- the cost per credit and the number of credits per course. The function outputs the total fees the student has to pay.

CREATE FUNCTION pr2.CalculateTotalFees(@amount INT, 
									   @perCourse INT, 
									   @studentId VARCHAR(10))
	RETURNS INT
	AS
	BEGIN
		DECLARE @totalAmount INT
		DECLARE @courses INT
		DECLARE @currVal INT
		DECLARE @maxValue INT
		DECLARE @totalValue INT
		DECLARE @tempStudentId VARCHAR(10)
		SET @currVal = 1
		SET @courses = 0
		IF NOT EXISTS(SELECT * 
						FROM pr2.Students
						WHERE StudentId = @StudentId)
			BEGIN
				SET @totalValue = -1
			END
		ELSE
			BEGIN
				SET @maxValue = (SELECT COUNT(*)
									FROM pr2.Enrollment)
				WHILE @currVal <= @maxValue
					BEGIN
						SET @tempStudentId = (SELECT StudentId
													FROM pr2.Enrollment
													WHERE @currVal = pr2.Enrollment.EnrollmentId)
						IF @tempStudentId = @studentId
							BEGIN
								SET @courses = @courses + 1
							END
						SET @currVal = @currVal + 1
					END
				IF @courses = 0
					BEGIN
						SET @totalvalue = 0
					END
				ELSE
					BEGIN
						SET @totalValue = @courses * @amount * @perCourse
					END
			END
		RETURN @totalvalue
	END;

-- The function returns the following:
-- Returns -1 if Student does not exist
SELECT pr2.CalculateTotalFees(1380, 3, 'STU02-MM') AS TotalAmount;

-- Returns 0 if Student has not enrolled for any course
SELECT pr2.CalculateTotalFees(1380, 3, 'STU06-JH') AS TotalAmount;

-- Returns the total amount depending on how many courses the student has enrolled for
SELECT pr2.CalculateTotalFees(1380, 3, 'STU03-JZ') AS TotalAmount;

DROP FUNCTION pr2.CalculateTotalFees;
