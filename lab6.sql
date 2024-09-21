--Упражнение 1 (1)
CREATE TABLE HumanResources.JobCandidateHistory (
    JobCandidateID int NOT NULL UNIQUE,
    Resume xml NULL,
    Rating int CHECK(Rating BETWEEN 0 AND 10) NOT NULL DEFAULT 5,
    RejectedDate datetime NOT NULL,
    ContactID int NULL,
    FOREIGN KEY (ContactID) REFERENCES Person.Contact(ContactID)
    ON DELETE SET NULL ON UPDATE CASCADE
)
--Упражнение 2 (1)
GO
ALTER TABLE HumanResources.JobCandidateHistory
NOCHECK CONSTRAINT [CK__JobCandid__Ratin__041093DD]
GO
ALTER TABLE HumanResources.JobCandidateHistory
NOCHECK CONSTRAINT [DF__JobCandid__Ratin__0504B816]
GO
--Упражнение 2 (2)
GO
ALTER TABLE HumanResources.JobCandidateHistory
CHECK CONSTRAINT [CK__JobCandid__Ratin__041093DD]
GO