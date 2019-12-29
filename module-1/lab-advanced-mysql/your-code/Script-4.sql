create TEMPORARY table Most_profiting_authors
with
table1 AS
(
select titles.title_id,
titleauthor.au_id,
titles.advance,
titles.price *
sales.qty *
titles.royalty/100 *
titleauthor.royaltyper/100 as sales_royalty
FROM titles
left join sales on titles.title_id = sales.title_id
left join titleauthor on titles.title_id = titleauthor.title_id
) /*Step1 from lab*/
SELECT table1.title_id,
table1.au_id,
table1.advance,
sum(table1.sales_royalty) as total_royalties
FROM table1
GROUP BY table1.au_id,
table1.title_id
ORDER BY table1.title_id DESC /*Step2 from lab*/;
/*Step3 from lab*/
with 
table2
as
(
with
table1 AS
(
select titles.title_id,
titleauthor.au_id,
titles.advance,
titles.price *
sales.qty *
titles.royalty/100 *
titleauthor.royaltyper/100 as sales_royalty
FROM titles
left join sales on titles.title_id = sales.title_id
left join titleauthor on titles.title_id = titleauthor.title_id
)
SELECT table1.title_id,
table1.au_id,
table1.advance,
sum(table1.sales_royalty) as total_royalties
FROM table1
GROUP BY table1.au_id,
table1.title_id
)
SELECT table2.au_id,
table2.total_royalties +
table2.advance as profits
from table2
ORDER BY profits DESC
limit 3;
