USE AdventureWorks
SELECT COUNT(*), COUNT(CASE WHEN ManagerID IS NOT NULL THEN 1 END)
FROM HumanResources.Employee
