-- The following function calculates the total number of equipment(White Boards, Projectors, Smart Boards) 
-- in particular building where courses are scheduled. The function accepts BuildingName as input. 
-- The function outputs the number of white boards, projectors and smartboards.


CREATE FUNCTION pr2.TotalEquipment(@buildingName VARCHAR(50))
	RETURNS @equipment TABLE
	(
		BuildingName VARCHAR(50) PRIMARY KEY,
		WhiteBoards INT,
		Projectors INT,
		SmartBoards INT
	)
	AS
	BEGIN
		DECLARE @whiteboards INT
		SET @whiteboards = 0
		DECLARE @projectors INT
		SET @projectors = 0
		DECLARE @smartboards INT
		SET @smartboards = 0
		DECLARE @buildId VARCHAR(10)
		DECLARE @templocid VARCHAR(10)
		DECLARE @tempbuildid VARCHAR(10)
		DECLARE @tempprojtype VARCHAR(20)
		IF NOT EXISTS(SELECT * 
						FROM pr2.BuildingName
						WHERE Name = @buildingName)
			BEGIN
				SET @whiteboards = -1
				SET @projectors = -1
				SET @smartboards = -1
			END
		ELSE
			BEGIN
				SET @buildId = (SELECT BuildingId
									FROM pr2.BuildingName
									WHERE Name = @buildingName)
				DECLARE LocCursor CURSOR FOR
					SELECT LocationId, BuildingName FROM pr2.Location
				OPEN LocCursor;
				FETCH NEXT FROM LocCursor INTO @templocid, @tempbuildid

				WHILE @@FETCH_STATUS = 0
					BEGIN
						-- processing
						IF @tempbuildid = @buildId
							BEGIN
								SET @whiteboards = @whiteboards + (SELECT NoOfWhiteBoards
																		FROM pr2.Classroom
																		WHERE Location = @templocid)
								DECLARE @projid INT
								SET @projid = (SELECT Projector
													FROM pr2.Classroom
													WHERE Location = @templocid)
								SET @tempprojtype = (SELECT ProjectorText
														FROM pr2.Projector
														WHERE ProjectorId = @projid)
								IF @tempprojtype = 'Smart Board'
									BEGIN
										SET @smartboards = @smartboards + 1
									END
								IF @tempprojtype = 'Yes'
									BEGIN
										SET @projectors = @projectors + 1
									END
							END	
						FETCH NEXT FROM LocCursor INTO @templocid, @tempbuildid
					END
			END
		INSERT INTO @equipment(BuildingName, WhiteBoards, Projectors, SmartBoards)
			VALUES (@buildingName, @whiteboards, @projectors, @smartboards)
		RETURN
	END;

-- The functions returns the following:
-- • Returns -1 if the building does not exist
SELECT * FROM pr2.TotalEquipment('College Place');

-- • Returns number of equipments if building exists
SELECT * FROM pr2.TotalEquipment('Life Sciences Complex');

DROP FUNCTION pr2.TotalEquipment;

