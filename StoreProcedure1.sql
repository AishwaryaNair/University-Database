-- The University has introduces a new health benefit plan and it is 
-- mandatory that all Employees must be enrolled in that plan.
-- The following store procedure accepts an Employee Name and the new health plan cost and Benefit selection.
-- It adds the new health plan to the HealthBenefits table if doesnot exist and also enrolls 
-- the Person in the new plan if the Person has not enrolled in the plan
-- For every case it prints either one of the following:
-- • If the plan is already in the list it prints ‘The plan is already in the list of university health insurance plans’
-- • If the plan is not in the list it prints 'A new plan was added in to the list of university health insurance plans'

CREATE PROCEDURE pr2.UnivHealthBenefits(@firstname VARCHAR(20), 
										@lastname VARCHAR(20), 
										@cost DECIMAL(10,2), 
										@benefitsselection VARCHAR(20)) AS
	DECLARE @personid VARCHAR(10)
	DECLARE @benefitsid INT
	DECLARE @healthid VARCHAR(10)
	DECLARE @temphealthid VARCHAR(10)
	SET @benefitsid = (SELECT BenefitsId
							FROM pr2.BenefitsSelection
							WHERE Benefits = @benefitsselection)
	IF EXISTS (SELECT * 
					FROM pr2.HealthBenefits
					WHERE Cost = @cost AND BenefitsSelection = @benefitsid)
		BEGIN
			PRINT 'The plan is already included in the list of university health insurance plans'
		END
	ELSE 
		BEGIN
			INSERT INTO pr2.HealthBenefits(HealthBenefitsId, Cost, BenefitsSelection)
				VALUES ('HB07', @cost, @benefitsid)		
			PRINT 'A new plan was added in to the list of university health insurance plans'
		END
	SET @temphealthid = (SELECT HealthBenefitsId
								FROM pr2.HealthBenefits
								WHERE Cost = @cost AND BenefitsSelection = @benefitsid)
	IF EXISTS (SELECT * 
					FROM pr2.Person
					WHERE FirstName = @firstname AND LastName = @lastname)
		BEGIN
			SET @personid = (SELECT PersonId 
								FROM pr2.Person
								WHERE FirstName = @firstname AND LastName = @LastName)
			IF EXISTS (SELECT * 
							FROM pr2.Employees
							WHERE PersonId = @personid)
				BEGIN
					SET @healthid = (SELECT HealthBenefits
										FROM pr2.Employees
										WHERE PersonId = @personid)
					IF @healthid = @temphealthid
						BEGIN
							PRINT 'The Employee ' + @firstname + ' ' + @lastname + ' has already enrolled in the university health insurance plan.'
						END
					ELSE
						BEGIN 
							UPDATE pr2.Employees
							SET HealthBenefits = @temphealthid
								WHERE PersonId = @personid
							PRINT 'The Employee ' + @firstname + ' ' + @lastname + ' had a differnt health insurance plan, is now enrolled in the new health insurance plan'
						END				
				END
			ELSE
				BEGIN
					PRINT 'Error: ' + @firstname + ' ' + @lastname + ' is not an Employee'
				END
		END
	ELSE
		BEGIN
			PRINT 'Error: ' + @firstname + ' ' + @lastname + ' is not included in the university database'
		END

-- The store procedure behaves as follows:
-- •	 The Person does not exist in the University database
EXEC pr2.UnivHealthBenefits 'Aishwarya', 'Nair', 900, 'Family';


-- • The Person is not an Employee
EXEC pr2.UnivHealthBenefits 'Jamie', 'Zawinski', 900, 'Family';


-- • The mandatory university health plan is already in the list of plans and the Person is already enrolled in the plan.
EXEC pr2.UnivHealthBenefits 'Herbert', 'Spencer', 900, 'Family';


-- • The mandatory university health plan is already in the list of plans but the Person is not enrolled in the plan.
EXEC pr2.UnivHealthBenefits 'Devendra', 'Banhart', 900, 'Family';


-- • The mandatory university health plan not in the list of plans, enroll the person in the new plan
EXEC pr2.UnivHealthBenefits 'Mariella', 'Frostrup', 1000, 'Family';

DROP PROCEDURE pr2.UnivHealthBenefits;
