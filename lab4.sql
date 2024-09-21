--Упражнение 1 (1)
INSERT INTO item (isbn, title_no, cover, loanable, translation)
VALUES(10001, 8, 'HARDBACK', 'Y', 'ENGLISH'),
      (10101, 8, 'SOFTBACK', 'Y', 'ENGLISH')

SELECT * FROM item
--Упражнение 1 (2)
INSERT INTO copy (isbn, copy_no, title_no, on_loan)
VALUES(10001, 1, 8, 'N')

SELECT * FROM copy

--Упражнение 1 (3)
SELECT translation
FROM item
WHERE isbn IN (10001, 10101)

--Упражнение 2 (1)
EXEC sp_help 'dbo.title'

--Упражнение 2 (2)
INSERT INTO title (title, author, synopsis)
VALUES ('The Art of Lawn Tennis', 'William T. Tilden', DEFAULT)

SELECT * FROM title

--Упражнение 2 (3)
SELECT TOP (1) title_no
FROM title
ORDER BY title_no DESC

--Упражнение 2 (4)
SELECT TOP (1) *
FROM title
ORDER BY title_no DESC

--Упражнение 2 (5)
INSERT INTO title (title, author)
VALUES ('Riders of the Purple Sage', 'Zane Grey')

--Упражнение 2 (6)
SELECT * FROM title

--Упражнение 3 (1)
CREATE TABLE sample1 (
    Cust_id int NOT NULL IDENTITY(100, 5),
    Name    char(10) NULL
)

--Упражнение 3 (2)
INSERT INTO sample1
DEFAULT VALUES

SELECT * FROM sample1

--Упражнение 4 (1)
SELECT *
FROM item
WHERE cover = 'SOFTBACK' AND isbn = 10101 AND title_no = 8

--Упражнение 4 (2)
DELETE FROM item
WHERE cover = 'SOFTBACK' AND isbn = 10101 AND title_no = 8

--Упражнение 5 (1)
SELECT *
FROM member
WHERE member_no = 507

--Упражнение 5 (2)
UPDATE member
SET lastname = 'AKISHIN'
WHERE member_no = 507

--Упражнение 6 (1)
BEGIN TRANSACTION
SET IDENTITY_INSERT  member ON
INSERT member (member_no, lastname, firstname, middleinitial)
VALUES (16101, 'Walters', 'B.', 'L')
SET IDENTITY_INSERT  member OFF
INSERT juvenile
VALUES (16101, 1, DATEADD(YY, -18, DATEADD(DD, -1, GETDATE())))
COMMIT TRANSACTION

--Упражнение 6 (2)
SELECT juvenile.member_no,
       adult.street,
       adult.city,
       adult.state,
       adult.zip,
       adult.phone_no,
       DATEADD(YY, 1, GETDATE()) AS year
FROM juvenile
    JOIN adult ON juvenile.adult_member_no = adult.member_no
WHERE DATEADD(YY, 18, juvenile.birth_date) <= DATEADD(YY, 1, GETDATE())

--Упражнение 6 (3)
INSERT INTO adult
SELECT juvenile.member_no,
       adult.street,
       adult.city,
       adult.state,
       adult.zip,
       adult.phone_no,
       DATEADD(YY, 1, GETDATE()) AS year
FROM juvenile
    JOIN adult ON juvenile.adult_member_no = adult.member_no
WHERE DATEADD(YY, 18, juvenile.birth_date) <= DATEADD(YY, 1, GETDATE())

SELECT *
FROM adult
WHERE member_no = 16101

--Упражнение 6 (4)
DELETE juvenile
FROM juvenile
    JOIN adult ON juvenile.member_no = adult.member_no

SELECT * FROM juvenile