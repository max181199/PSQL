CREATE VIEW autor_user AS SELECT autor.autor_id , users FROM autor LEFT OUTER JOIN autor_data ON (autor.autor_id = autor_data.autor_id);
DROP VIEW autor_user_only;

CREATE RULE _Rule_Update AS ON UPDATE TO autor_user 
	DO INSTEAD 
	UPDATE autor_data 
		SET users=NEW.users WHERE autor_id=NEW.autor_id;

CREATE TABLE delete_log
(
	article_id     int,
	users        int[]
);

CREATE RULE _Rule_DELETE AS ON DELETE TO autor_user
	DO INSTEAD
	INSERT INTO delete_log
		VALUES(OLD.autor_id,OLD.users) ;

CREATE TABLE insert_log
(
	autor_id int,
	users int[]
)				

CREATE RULE _Rule_INSERT AS ON INSERT  TO autor_user
	DO INSTEAD
	INSERT INTO insert_log
		VALUES(NEW.autor_id,NEW.users) ;

CREATE VIEW autor_user_only AS SELECT autor_id,users FROM   autor_user WHERE array_length(users,1) = 1 ;
DROP VIEW autor_user_only;

CREATE RULE one_Rule_Update AS ON UPDATE TO autor_user_only 
	DO INSTEAD 
	UPDATE autor_user
		SET users=NEW.users WHERE autor_id=NEW.autor_id;

CREATE RULE one_Rule_DELETE AS ON DELETE TO autor_user_only
	DO INSTEAD NOTHING;		

CREATE RULE one_Rule_INSERT AS ON INSERT TO autor_user_only
	DO INSTEAD NOTHING;


CREATE MATERIALIZED VIEW autor_des AS SELECT autor_id,autor_describe FROM autor_data ;
SELECT * FROM autor_des ORDER BY autor_id LIMIT 10;

CREATE RULE _Rule_autor_des AS ON UPDATE TO autor_des
	DO INSTEAD 
	UPDATE autor_data 
		SET autor_describe=NEW.users WHERE autor_id=NEW.autor_id; 
--- Не должно работать!!!

 UPDATE autor_data SET autor_describe='some_funny_text' WHERE autor_id < 10;
REFRESH MATERIALIZED VIEW autor_des;
SELECT * FROM autor_des ORDER BY autor_id LIMIT 10;


--- part 2


SELECT autor_id,autor_data_predelet(autor_data.*,202363) FROM autor_data LIMIT 10;

CREATE OR REPLACE FUNCTION autor_data_predelet(autor_data,IN user_id int) RETURNS int[]
AS $$
UPDATE autor_data SET users=array_remove($1.users, $2) WHERE autor_id=$1.autor_id;
SELECT array_remove($1.users, $2);
$$ LANGUAGE SQL;


CREATE OR REPLACE FUNCTION autor_describe_banned(IN word text) RETURNS SETOF int
AS $$
UPDATE autor_data  set autor_describe='Was Banned'
WHERE (to_tsvector('english',autor_describe) @@ to_tsquery('english',$1)) AND(autor_id < 100) RETURNING autor_id;
$$ LANGUAGE SQL;


	CREATE OR REPLACE FUNCTION service() RETURNS int[]
	AS $$
	DECLARE 
		xp int;
		arr int[];
	BEGIN
		arr:= ARRAY (SELECT DISTINCT user_role FROM user_id);
	 	FOREACH xp IN ARRAY arr
	 	LOOP
	    	IF xp=1 THEN CREATE INDEX name_1 ON user_id (user_role) WHERE user_role=1;
	    	END IF;
	    	IF xp=2 THEN CREATE INDEX name_2 ON user_id (user_role) WHERE user_role=2;
	    	END IF;
	    	IF xp=3 THEN CREATE INDEX name_3 ON user_id (user_role) WHERE user_role=3;
	    	END IF;
	    	IF xp=4 THEN CREATE INDEX name_4 ON user_id (user_role) WHERE user_role=4;
	    	END IF;
	  	END LOOP;
	 	RETURN arr;
	END;
	$$ LANGUAGE plpgsql;

	CREATE OR REPLACE FUNCTION service() RETURNS int[]
	AS $$
	DECLARE 
		xp int;
		arr int[];
		name text;
	BEGIN
		arr:= ARRAY (SELECT DISTINCT user_role FROM user_id);
	 	name:='some_name';
	 	FOREACH xp IN ARRAY arr
	 	LOOP
	    	name:=name||xp;
	    	CREATE INDEX name ON user_id ("user_role") WHERE "user_role"= xp;
	  	END LOOP;
	 	RETURN arr;
	END;
	$$ LANGUAGE plpgsql;