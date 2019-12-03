--	ALTER SYSTEM SET wal_level='minimal';
--	ALTER SYSTEM SET archive_mode='off' ;
--	ALTER SYSTEM SET max_wal_senders='0';
--	ALTER SYSTEM SET max_wal_size= '800MB';
--	ALTER SYSTEM SET wal_level=default;
--	ALTER SYSTEM SET archive_mode=default;
--	ALTER SYSTEM SET max_wal_senders=default;
--	ALTER SYSTEM SET max_wal_size= default;

CREATE TABLE  article
(
	article_id     int,
	article_state  varchar(10),
	article_view   int,
	article_role   int,
	article_rate   int,
	article_ngroup int,
	groups         int[]
);

CREATE TABLE article_data
(
	article_id       int,
	article_json     json,
	article_describe text,
	autor_id         int,
	articel_time_creation timestamp,
	article_time_delete   timestamp
);

CREATE TABLE autor
(
	autor_id   int,
	autor_role int,
	autor_rate int,
	autor_state varchar(10)
);

CREATE TABLE autor_data
(
	autor_id int,
	users     int[],
	autor_describe text,
	autor_narticles int ,
	autor_time_creation timestamp,
	autor_time_delete timestamp
);

CREATE TABLE user_id
(
	user_id int,
	user_role      int,
	user_state varchar(10)
);

CREATE TABLE user_data
(
	user_id int,
	user_birthday date,
	user_gender   boolean,
	user_age      int,
	user_time_create timestamp,
	user_time_delete timestamp,
	user_degree   varchar(123)
);

CREATE TABLE groups
(
	group_id int,
	group_state varchar(10),
	group_rate  int,
	group_role  int
);

CREATE TABLE group_data
(
	group_id int,
	group_user_create int,
	group_time_create timestamp ,
	group_time_delete timestamp ,
	group_describe text
);
BEGIN;

SET maintenance_work_mem to '512MB';

COPY article(article_id,article_state,article_view,article_role,article_rate,groups) 
FROM '/home/max/sql/lab5/article.txt';

COPY article_data(article_id,article_json,article_describe,autor_id,
articel_time_creation,article_time_delete) FROM '/home/max/sql/lab5/article_data.txt';

COPY autor(autor_id,autor_role,autor_rate,autor_state)
FROM '/home/max/sql/lab5/autor.txt';

COPY autor_data(autor_id,autor_describe,users,autor_time_creation,autor_time_delete) 
FROM '/home/max/sql/lab5/autor_data.txt';

COPY user_id(user_id,user_role,user_state) FROM '/home/max/sql/lab5/user_id.txt';

COPY user_data(user_id,user_birthday,user_gender,user_age,user_time_create,user_time_delete,user_degree)
FROM '/home/max/sql/lab5/user_id_data.txt';


COPY groups(group_id,group_state,group_rate,group_role)
FROM '/home/max/sql/lab5/group.txt';

COPY group_data(group_id,group_user_create,group_time_create,group_time_delete,group_describe)
FROM '/home/max/sql/lab5/group_data.txt';

SET maintenance_work_mem to '64MB';

COMMIT;