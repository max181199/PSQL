-- group_name and date of last creation artice

WITH tabl AS
(
	SELECT group_name,time_cr FROM (groups RIGHT OUTER JOIN a_g ON groups.group_id = a_g.group_id)
	                               LEFT OUTER JOIN article ON a_g.article_id = article.article_id
)
	SELECT group_name,max(time_cr) FROM tabl GROUP BY (group_name);