--mask and count article

WITH tabl AS
(
	SELECT mask_id, count(article_id) AS count FROM m_a  GROUP BY mask_id ORDER BY mask_id
)
	SELECT mask_name,count FROM mask LEFT OUTER JOIN tabl ON mask.mask_id=tabl.mask_id;

-- group_name and date of last creation artice