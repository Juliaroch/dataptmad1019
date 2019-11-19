SELECT authors.au_id,
authors.au_lname,
authors.au_fname,
titles.title,
publishers.pub_name
from titles
join publishers on titles.pub_id = publishers.pub_id
join titleauthor on titleauthor.title_id = titles.title_id
join authors on authors.au_id = titleauthor.au_id;


SELECT authors.au_id,
authors.au_lname,
authors.au_fname,
publishers.pub_name,
COUNT (*) FROM titles
join titleauthor on titleauthor.title_id = titles.title_id
join authors on authors.au_id = titleauthor.au_id
join publishers on publishers.pub_id = titles.pub_id
GROUP BY authors.au_id;

SELECT authors.au_id,
authors.au_lname,
authors.au_fname,
SUM(sales.qty) AS total
FROM sales
join titles on titles.title_id = sales.title_id
join titleauthor on titleauthor.title_id = titles.title_id
join authors on authors.au_id = titleauthor.au_id
GROUP BY authors.au_id
ORDER BY total DESC
LIMIT 3;

WITH 
tit_sold AS
(
SELECT *
FROM titles
LEFT join sales on titles.title_id = sales.title_id
)
SELECT authors.au_id,
authors.au_lname,
authors.au_fname,
SUM(tit_sold.qty) AS total
FROM authors
LEFT outer join titleauthor on authors.au_id = titleauthor.au_id
LEFT outer join tit_sold on titleauthor.title_id = tit_sold.title_id
GROUP BY authors.au_id
ORDER BY total DESC;
