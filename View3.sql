-- The following view shows Person information who are both Students as well as Employee.
-- The view includes the following data:
-- PersonName as FirstName + LastName
-- NetId
-- LocalAddress
-- JobTitle
-- EmployeeStatus
-- StudentStatus

CREATE VIEW pr2.StudentAndEmployee AS
	SELECT p.FirstName + ' ' + p.LastName AS PersonName, p.NetID, ad.AddressLine1, ad.AddressLine2, ad.City, ad.State, ad.Country, 
		   ad.PostalCode, ps.PersonStatus, ji.JobTitle, ss.StudentStatus
		FROM pr2.Person p INNER JOIN pr2.Students s
			ON p.PersonId = s.PersonId
			INNER JOIN pr2.Employees emp
				ON p.PersonId = emp.PersonId
			INNER JOIN pr2.Addresses ad
				ON p.LocalAddress = ad.AddressId
			INNER JOIN pr2.PersonStatus ps
				ON p.PersonStatus = ps.StatusId
			INNER JOIN pr2.JobInformation ji
				ON ji.JobInformationId = emp.JobInformation
			INNER JOIN pr2.StudentStatus ss
				ON ss.StatusId = s.StudentStatusId

SELECT * FROM pr2.StudentAndEmployee

DROP VIEW pr2.StudentAndEmployee

