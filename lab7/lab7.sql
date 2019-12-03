
EXPLAIN (BUFFERS , ANALYZE) SELECT users FROM autor_data LEFT OUTER JOIN  autor ON (autor.autor_id = autor_data.autor_id)
WHERE (autor_time_creation < '1000-01-01 12:34:56' ) AND (autor_state = 'USE' OR autor_state = 'HIDE') AND (autor_rate >3);

CREATE INDEX autor_time ON autor_data (autor_time_creation) INCLUDE (users);
DROP INDEX autor_time;



EXPLAIN (BUFFERS , ANALYZE) SELECT DISTINCT user_age AS male_age_last_100_years , count(user_id) OVER (PARTITION BY user_age)
FROM user_data
WHERE (user_gender = true) AND	(user_time_create > '1900.01.01') AND (user_time_create < '2000.01.01');


CREATE INDEX user_try  ON user_data (user_gender,user_time_create) INCLUDE (user_age) 
WHERE (user_time_create > '1899.01.01') AND (user_time_create < '2001.01.01');
DROP INDEX user_try;

EXPLAIN (BUFFERS , ANALYZE) SELECT autor_describe as text , to_tsvector('english',autor_describe) FROM autor_data
WHERE to_tsvector('english',autor_describe) @@ to_tsquery('english','BAD & VERY');

CREATE INDEX describe_data ON autor_data USING GIN (to_tsvector('english',autor_describe));
DROP INDEX describe_data;

EXPLAIN (BUFFERS , ANALYZE) SELECT autor_id FROM autor_data WHERE users <@ ARRAY [333333,222222,111111];
CREATE INDEX autor_hell ON autor_data USING GIN (users);
DROP INDEX autor_hell;

EXPLAIN (BUFFERS,ANALYZE) SELECT article_id FROM article_data WHERE article_json->>'UNIQUE_KEY' = '12345678';
CREATE INDEX turtle ON article_data  ((article_json->>'UNIQUE_KEY'));
DROP INDEX turtle;


CREATE TABLE  article
(
	article_id     int,
	article_state  varchar(10),
	article_view   int,
	article_role   int,
	article_rate   int,
	article_ngroup int,
	groups         int[]
) PARTITION BY LIST (article_state);

CREATE TABLE article_USE PARTITION OF article
	FOR VALUES IN ('USE')
		PARTITION BY LIST (article_role);

	CREATE TABLE article_USE_0 PARTITION OF article_USE
		FOR VALUES IN (0);

	CREATE TABLE article_USE_1 PARTITION OF article_USE
		FOR VALUES IN (1);

	CREATE TABLE article_USE_2 PARTITION OF article_USE
		FOR VALUES IN (2);

	CREATE TABLE article_USE_3 PARTITION OF article_USE
		FOR VALUES IN (3);

	CREATE TABLE article_USE_4 PARTITION OF article_USE
		FOR VALUES IN (4);			

CREATE TABLE article_HIDE PARTITION OF article
	FOR VALUES IN ('HIDE')
		PARTITION BY LIST (article_role);

	CREATE TABLE article_HIDE_0 PARTITION OF article_HIDE
		FOR VALUES IN (0);

	CREATE TABLE article_HIDE_1 PARTITION OF article_HIDE
		FOR VALUES IN (1);

	CREATE TABLE article_HIDE_2 PARTITION OF article_HIDE
		FOR VALUES IN (2);

	CREATE TABLE article_HIDE_3 PARTITION OF article_HIDE
		FOR VALUES IN (3);

	CREATE TABLE article_HIDE_4 PARTITION OF article_HIDE
		FOR VALUES IN (4);			

CREATE TABLE article_DELETE PARTITION OF article
	FOR VALUES IN ('DELETE')
		PARTITION BY LIST (article_role);

	CREATE TABLE article_DELETE_0 PARTITION OF article_DELETE 
		FOR VALUES IN (0);

	CREATE TABLE article_DELETE_1 PARTITION OF article_DELETE 
		FOR VALUES IN (1);

	CREATE TABLE article_DELETE_2 PARTITION OF article_DELETE 
		FOR VALUES IN (2);

	CREATE TABLE article_DELETE_3 PARTITION OF article_DELETE 
		FOR VALUES IN (3);

	CREATE TABLE article_DELETE_4 PARTITION OF article_DELETE 
		FOR VALUES IN (4);				

CREATE INDEX panic_room ON article USING GIN (groups);
CREATE INDEX zero       ON article  (article_rate);
CREATE UNIQUE INDEX art ON article (article_id,article_state,article_role);

COPY article(article_id,article_state,article_view,article_role,article_rate,groups) 
FROM '/home/max/sql/lab5/article.txt';





SET enable_indexscan = off;
SET enable_indexscan = on;
SET enable_indexonlyscan = off;
SET enable_indexonlyscan = on;
SET enable_seqscan = off;