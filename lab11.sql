DROP TABLE HumanResources.JobCandidateHistory
--Упражнение 1
CREATE TABLE [HumanResources].[JobCandidateHistory] (
    [JobCandidateID] [INT] NOT NULL UNIQUE,
    [Resume] [xml] NULL,
    [Rating] [INT] NOT NULL CONSTRAINT
[DF_JobCandidateHistory_Rating] DEFAULT (5),
    [RejectedDate] [DATETIME] NOT NULL,
    [ContactID] [INT] NULL,
    CONSTRAINT [FK_JobCandidateHistory_Contact_ContactID]
    FOREIGN KEY (ContactID) REFERENCES [Person].[Contact] (ContactID),
    CONSTRAINT  [CK_JobCandidateHistory_Rating]
    CHECK ([Rating] >= 0 AND [Rating] <= 10)
) ON [PRIMARY]

--Упражнение 2
CREATE TRIGGER dJobCandidate
    ON HumanResources.JobCandidate
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON

    INSERT INTO HumanResources.JobCandidateHistory (JobCandidateID, Resume, RejectedDate)
    SELECT d.JobCandidateID,
           d.Resume,
           GETDATE()
    FROM deleted d
END

--Упражнение 3
DELETE FROM HumanResources.JobCandidate
WHERE JobCandidateID = (
    SELECT MIN(JobCandidateID) FROM HumanResources.JobCandidate
    )

SELECT * FROM HumanResources.JobCandidateHistory

TRUNCATE TABLE HumanResources.JobCandidateHistory


--Упражнение 4
CREATE TRIGGER OrderDetailNotDiscontinued
    ON Sales.SalesOrderDetail
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON
    DECLARE @ProdID INT
    SET @ProdID = (SELECT i.ProductID FROM inserted i)

    IF (@ProdID IN (
        SELECT ProductID
        FROM Production.Product
        WHERE DiscontinuedDate IS NOT NULL
    ))
    BEGIN
        RAISERROR('ERROR LAB11', 16, 1)
        ROLLBACK
    END

END

SELECT ProductID,
       Name
FROM Production.Product
WHERE DiscontinuedDate IS NOT NULL

UPDATE Production.Product
SET DiscontinuedDate = GETDATE()
WHERE ProductID = 680

INSERT INTO Sales.SalesOrderDetail
    (SalesOrderID, OrderQty, ProductID, SpecialOfferID, UnitPrice, UnitPriceDiscount)
VALUES(43660, 5, 680, 1, 1431, 0)