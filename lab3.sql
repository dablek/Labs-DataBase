--Упражнение 1
SELECT firstname + ' ' + middleinitial + ' ' + lastname AS name,
       adult.street,
       adult.city,
       adult.state,
       adult.zip
FROM member
    JOIN adult ON adult.member_no = member.member_no

--Упражнение 2
SELECT item.isbn,
       copy_no,
       on_loan,
       title,
       translation,
       cover
FROM title
    JOIN copy ON copy.title_no = title.title_no
    JOIN item ON copy.isbn = item.isbn
WHERE copy.isbn IN (1, 500, 1000)
ORDER BY copy.isbn

--Упражнение 3
SELECT member.firstname + ' ' + member.middleinitial + ' ' + member.lastname,
       reservation.isbn,
       CONVERT(char(8), reservation.log_date, 112) AS date
FROM member
    LEFT JOIN reservation ON reservation.member_no = member.member_no
WHERE member.member_no IN (250, 341, 1675)
ORDER BY member.member_no

SELECT *
FROM adult

--Упражнение 4
SELECT adult.member_no,
       COUNT(juvenile.member_no) AS numkids
FROM adult
    JOIN juvenile ON adult.member_no = juvenile.adult_member_no
WHERE adult.state = 'AZ'
GROUP BY adult.member_no
HAVING COUNT(juvenile.member_no) > 2

UNION

SELECT adult.member_no,
       COUNT(juvenile.member_no) AS numkids
FROM adult
    JOIN juvenile ON adult.member_no = juvenile.adult_member_no
WHERE adult.state = 'CA'
GROUP BY adult.member_no
HAVING COUNT(juvenile.member_no) > 2


