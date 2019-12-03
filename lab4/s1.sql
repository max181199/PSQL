-- article and real autors name
WITH tabl AS 
(
	SELECT article_id, user_id FROM m_a INNER JOIN u_m ON m_a.mask_id = u_m.mask_id ORDER BY article_id 
),   
	 tabl2 AS  
(
	SELECT real_name,article_id FROM users RIGHT OUTER JOIN tabl ON  users.user_id=tabl.user_id
)
	SELECT real_name,article_name FROM tabl2 LEFT OUTER JOIN article ON tabl2.article_id=article.article_id;