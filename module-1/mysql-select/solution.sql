-- CHALLENGE 1

SELECT authors.au_id AS 'Author ID', authors.au_lname AS 'Last Name', authors.au_fname AS 'First Name', title.title AS 'Title', pub.pub_name AS 'Publisher'
FROM dbo.authors authors
INNER JOIN dbo.titleauthor ta ON authors.au_id = ta.au_id 
INNER JOIN dbo.titles title ON ta.title_id = title.title_id
INNER JOIN dbo.publishers pub ON title.pub_id = pub.pub_id

-- CHALLENGE 2
SELECT authors.au_id AS 'AUTHOR ID', authors.au_lname AS 'Last Name', authors.au_fname AS 'First Name', pub.pub_name AS 'Publisher', COUNT(title.title_id) AS 'Title Count'
FROM dbo.authors authors
INNER JOIN dbo.titleauthor ta ON authors.au_id = ta.au_id
INNER JOIN dbo.titles title ON ta.title_id = title.title_id
INNER JOIN dbo.publishers pub ON title.pub_id = pub.pub_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname, pub.pub_name
ORDER BY 'Title Count' DESC

SELECT COUNT(titleauthor.au_id) as TotalOfTitleAuthor
FROM dbo.titleauthor

-- Counting manually I obtain the same value in the title count column than in the number of record in the titleauthor table: 25

-- CHALLENGE 3
SELECT TOP(3) authors.au_id AS 'AUTHOR ID', authors.au_lname AS 'Last Name', authors.au_fname AS 'First Name', SUM(sales.qty) AS 'TOTAL'
FROM dbo.authors authors
INNER JOIN dbo.titleauthor ta ON authors.au_id = ta.au_id 
INNER JOIN dbo.titles title ON ta.title_id = title.title_id
INNER JOIN dbo.sales sales ON title.title_id = sales.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
ORDER BY 'TOTAL' DESC


-- CHALLENGE 4
SELECT authors.au_id AS 'AUTHOR ID', authors.au_lname AS 'Last Name', authors.au_fname AS 'First Name', COALESCE(SUM(sales.qty),0) AS 'TOTAL'
FROM dbo.authors authors
LEFT JOIN dbo.titleauthor ta ON authors.au_id = ta.au_id 
LEFT JOIN dbo.titles title ON ta.title_id = title.title_id
LEFT JOIN dbo.sales sales ON title.title_id = sales.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
ORDER BY 'TOTAL' DESC

-- LAB FINISHED