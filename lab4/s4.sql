-- article and mask who can read it

SELECT article_name , mask_name FROM article INNER JOIN mask ON privilege >= read_pr_min ORDER BY mask_name;