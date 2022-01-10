-- Lab 'Advanced SQL'
-- CHALLENGE 1
-- STEP 1
SELECT t.title_id AS 'Title ID', a.au_id AS 'Author ID', ((t.advance * ta.royaltyper)/100) AS 'Advance', ((t.price*s.qty*t.royalty)/100) * (ta.royaltyper/100) AS 'Royalty/sale'
FROM dbo.titles t
INNER JOIN dbo.titleauthor ta ON ta.title_id = t.title_id
INNER JOIN dbo.authors a ON a.au_id = ta.au_id
INNER JOIN dbo.sales s ON s.title_id = t.title_id

-- STEP 2
SELECT step1.[Title ID], step1.[Author ID], SUM(step1.[Royalty/sale]) AS 'Agg Royalties'
FROM (SELECT t.title_id AS 'Title ID', a.au_id AS 'Author ID', ((t.advance * ta.royaltyper)/100) AS 'Advance', ((t.price*s.qty*t.royalty)/100) * (ta.royaltyper/100) AS 'Royalty/sale'
FROM dbo.titles t
INNER JOIN dbo.titleauthor ta ON ta.title_id = t.title_id
INNER JOIN dbo.authors a ON a.au_id = ta.au_id
INNER JOIN dbo.sales s ON s.title_id = t.title_id) step1
GROUP BY step1.[Title ID], step1.[Author ID]

-- STEP 3
SELECT TOP(3) step2.[Author ID], SUM(step2.[Agg Royalties]) AS 'Author total royalties', SUM(step2.[Agg Advance]) AS 'Author total advance', SUM(step2.[Agg Advance] + step2.[Agg Royalties]) AS 'Total Profit'
FROM (SELECT step1.[Title ID], step1.[Author ID], SUM(step1.[Royalty/sale]) AS 'Agg Royalties', SUM(step1.Advance) AS 'Agg Advance'
FROM (SELECT t.title_id AS 'Title ID', a.au_id AS 'Author ID', ((t.advance * ta.royaltyper)/100) AS 'Advance', ((t.price*s.qty*t.royalty)/100) * (ta.royaltyper/100) AS 'Royalty/sale'
FROM dbo.titles t
INNER JOIN dbo.titleauthor ta ON ta.title_id = t.title_id
INNER JOIN dbo.authors a ON a.au_id = ta.au_id
INNER JOIN dbo.sales s ON s.title_id = t.title_id) step1
GROUP BY step1.[Title ID], step1.[Author ID]) step2
GROUP BY step2.[Author ID]
ORDER BY [Total Profit] DESC

-- CHALLENGE 2
-- STEP 1
SELECT t.title_id AS 'Title ID', a.au_id AS 'Author ID', ((t.advance * ta.royaltyper)/100) AS 'Advance', ((t.price*s.qty*t.royalty)/100) * (ta.royaltyper/100) AS 'Royalty/sale'
INTO #step1
FROM dbo.titles t
INNER JOIN dbo.titleauthor ta ON ta.title_id = t.title_id
INNER JOIN dbo.authors a ON a.au_id = ta.au_id
INNER JOIN dbo.sales s ON s.title_id = t.title_id

-- STEP 2
SELECT step1.[Title ID], step1.[Author ID], SUM(step1.[Royalty/sale]) AS 'Agg Royalties', SUM(step1.Advance) AS 'Agg Advance'
INTO #step2
FROM dbo.#step1 step1
GROUP BY step1.[Title ID], step1.[Author ID] 

-- STEP 3
SELECT TOP(3) step2.[Author ID], SUM(step2.[Agg Royalties]) AS 'Author total royalties', SUM(step2.[Agg Advance]) AS 'Author total advance', SUM(step2.[Agg Advance] + step2.[Agg Royalties]) AS 'Total Profit'
INTO #final_result
FROM dbo.#step2 step2
GROUP BY step2.[Author ID]
ORDER BY [Total Profit] DESC

SELECT *
FROM dbo.#final_result
