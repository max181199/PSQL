
psql -U test -d lab6 -h 127.0.0.1 -- Доступ к базе данных.

-- FIRST PART :

CREATE ROLE test WITH LOGIN PASSWORD '1234';

GRANT SELECT,UPDATE,INSERT ON TABLE groups TO test;

GRANT SELECT (autor_id,users,autor_describe) ON TABLE autor_data TO test;
GRANT UPDATE (users,autor_describe) ON TABLE autor_data TO test;

GRANT SELECT ON TABLE autor TO test;

--TEST FIRST PART :

SELECT * FROM groups LIMIT 10;
INSERT INTO groups VALUES(0,'ggg',0,0);
SELECT * FROM groups ORDER BY group_id LIMIT 10;


UPDATE autor_data SET autor_describe = autor_describe || '+' WHERE autor_id <100;
SELECT autor_time_delete FROM autor_data LIMIT 10;
SELECT autor_describe FROM autor_data ORDER BY autor_id LIMIT 100;

SELECT * FROM autor_data LIMIT 10;

-- GRANT VIEW

 GRANT SELECT ON autor_user TO test;
 SELECT * FROM autor_user LIMIT 10;
 UPDATE autor_user SET autor_id =0 ;

-- BASE ROLE

CREATE ROLE base_role WITH PASSWORD '1234' LOGIN NOINHERIT;
GRANT UPDATE ON  autor_user TO base_role;
UPDATE autor_user SET users = '{1,2,3}'  WHERE autor_id=1;
SELECT * FROM autor_user ORDER BY autor_id LIMIT 10;

-- GRANT GROUP ROLE base_role and test
CREATE ROLE base_test WITH PASSWORD '1234' LOGIN NOINHERIT;
GRANT base_role TO base_test;
UPDATE autor_user SET users = '{1,2,3}'  WHERE autor_id=1;
SELECT * FROM autor_user ORDER BY autor_id LIMIT 10;
SET ROLE base_role;
UPDATE autor_user SET users = '{0,0,0,0,0,0,0,0}'  WHERE autor_id=1;
SELECT * FROM autor_user ORDER BY autor_id LIMIT 10;

CREATE TABLE de
(
	article_id     int,
	users        int[]
);