--Упражнение 1 (1)
WITH NewTable (adult_member_no, Co_Of_Children) AS (
    SELECT adult_member_no,
           COUNT(member_no)
    FROM juvenile
    group by adult_member_no
    HAVING COUNT(member_no) > 3
)

SELECT NewTable.adult_member_no,
       NewTable.Co_Of_Children,
       adult.expr_date
FROM NewTable
    JOIN adult ON adult.member_no = NewTable.adult_member_no

--Упражнение 1 (2)
WITH NewTable (adult_member_no, Co_Of_Children) AS (
    SELECT adult_member_no,
           COUNT(member_no)
    FROM juvenile
    group by adult_member_no
    HAVING COUNT(member_no) > 3
),
    ExprDate AS (
        SELECT member_no, expr_date
        FROM adult
        )

SELECT NewTable.adult_member_no,
       NewTable.Co_Of_Children,
       ExprDate.expr_date
FROM NewTable
    JOIN ExprDate ON ExprDate.member_no = NewTable.adult_member_no

--Упражнение 2 (1)
WITH NewTable AS (
    SELECT member.firstname,
           member.lastname,
           loanhist.isbn,
           loanhist.fine_paid
    FROM member
        JOIN loanhist ON member.member_no = loanhist.member_no
    WHERE loanhist.fine_paid IS NOT NULL
)

SELECT MAX(fine_paid)
FROM NewTable
--Упражнение 2 (2)
SELECT DISTINCT member.firstname,
       member.lastname,
       loanhist.isbn,
       loanhist.fine_paid
FROM member
    JOIN loanhist ON member.member_no = loanhist.member_no
WHERE fine_paid = (SELECT MAX(fine_paid) FROM loanhist)
--Упражнение 2 (3)
--Не понимаю, что от меня хотят

--Упражнение 2 (4)
--Не понимаю, что от меня хотят

--Упражнение 3
SELECT member_no,
       lastname,
       (SELECT SUM(fine_paid)
        FROM loanhist
        WHERE member.member_no = loanhist.member_no)
FROM member