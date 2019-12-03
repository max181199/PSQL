
BEGIN;
ALTER TABLE article ADD PRIMARY KEY (article_id);
ALTER TABLE article ALTER COLUMN article_state SET NOT NULL;
ALTER TABLE article ALTER COLUMN article_state SET DEFAULT 'HIDE';
ALTER TABLE article ALTER COLUMN article_view  SET DEFAULT 0;
ALTER TABLE article ALTER COLUMN autor_id      SET NOT NULL;
ALTER TABLE article ALTER COLUMN article_group SET DEFAULT 0;
ALTER TABLE article ALTER COLUMN article_time_creation SET DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE article ALTER COLUMN article_time_delete   SET DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE article ALTER COLUMN article_rate  SET DEFAULT 0;
ALTER TABLE article ADD CHECK(article_view>=0);
ALTER TABLE article ADD CHECK(article_role>=0 and article_role<=4);
ALTER TABLE article ADD CHECK(article_time_creation <= article_time_delete);
ALTER TABLE article ADD CHECK(article_rate>=1 and article_rate<=5);
ALTER TABLE article ADD CHECK(article_group>=0);
ALTER TABLE article ADD FOREIGN KEY (autor_id);
COMMIT;

BEGIN;
ALTER TABLE article_date ADD FOREIGN KEY (article_id) REFERENCES article(article_id);
ALTER TABLE article_date ALTER COLUMN article_id SET NOT NULL;
--ALTER TABLE article_date ALTER COLUMN article_id SET UNIQUE;
ALTER TABLE article_date ALTER COLUMN article_json SET NOT NULL;
END;

BEGIN;
ALTER TABLE article_discribe ADD FOREIGN KEY (article_id) REFERENCES article(article_id);
ALTER TABLE article_discribe ALTER COLUMN article_id SET NOT NULL;
--ALTER TABLE article_discribe ALTER COLUMN article_id SET UNIQUE;
ALTER TABLE article_discribe ALTER COLUMN describe SET NOT NULL;
END;

BEGIN;
ALTER TABLE autor_describe ADD FOREIGN KEY (autor_id) REFERENCES autor(autor_id);
ALTER TABLE autor_describe ALTER COLUMN autor_id SET NOT NULL;
--ALTER TABLE autor_describe ALTER COLUMN autor_id SET UNIQUE;
ALTER TABLE autor_describe ALTER COLUMN autor_describe SET NOT NULL;
END;

BEGIN;
ALTER TABLE autor ADD PRIMARY KEY (autor_id);
ALTER TABLE autor ALTER COLUMN user_id SET NOT NULL;
ALTER TABLE autor ALTER COLUMN autor_role SET DEFAULT(0);
ALTER TABLE autor ADD CHECK(autor_role>=0 and autor_role<=4);
ALTER TABLE autor ALTER COLUMN autor_rate SET DEFAULT(0);
ALTER TABLE autor ADD CHECK(autor_rate>=0 and autor_rate<=5);
ALTER TABLE autor ALTER COLUMN autor_narticle SET DEFAULT(0);
ALTER TABLE autor ADD CHECK(autor_narticle>=0);
ALTER TABLE autor ALTER COLUMN autor_time_creation SET DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE autor ALTER COLUMN autor_time_delete   SET DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE autor ADD CHECK(autor_time_delete>=autor_time_creation);
ALTER TABLE autor ALTER COLUMN autor_state SET DEFAULT 'HIDE';
COMMIT;

BEGIN;
ALTER TABLE user_id ADD PRIMARY KEY (user_id);
ALTER TABLE user_id ALTER COLUMN user_gender SET NOT NULL;
ALTER TABLE user_id ALTER COLUMN user_age         SET NOT NULL;
ALTER TABlE user_id ADD CHECK(user_age>=1 and user_age<=123);
ALTER TABLE user_id ALTER COLUMN user_birthday SET NOT NULL;
ALTER TABLE user_id ADD CHECK(array_length(user_birthday,1)=3);
ALTER TABLE user_id ADD CHECK(user_birthday[1]<=31 and user_birthday[1]>=1);
ALTER TABLE user_id ADD CHECK(user_birthday[2]<=12 and user_birthday[2]>=1);
ALTER TABLE user_id ADD CHECK(user_birthday[1]<=3333 and user_birthday[1]>=0);
ALTER TABLE user_id ALTER COLUMN user_state SET  DEFAULT 'USE';
ALTER TABLE user_id ALTER COLUMN user_time_create SET DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE user_id ALTER COLUMN user_time_delete SET DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE user_id ADD CHECK(user_time_create<=user_time_delete);
ALTER TABLE user_id ALTER COLUMN user_degree SET NOT NULL;
ALTER TABLE user_id ALTER COLUMN user_role SET DEFAULT(0);
ALTER TABLE user_id ADD CHECK(user_role<=4 and user_role>=0);
COMMIT;

BEGIN;
ALTER TABLE group_discribe ADD FOREIGN KEY (group_id) REFERENCES groups(group_id);
ALTER TABLE group_discribe ALTER COLUMN group_id SET NOT NULL;
--ALTER TABLE group_discribe ALTER COLUMN group_id UNIQUE;
ALTER TABLE group_discribe ALTER COLUMN discribe SET NOT NULL;
COMMIT;

BEGIN;
ALTER TABLE groups ADD PRIMARY KEY (group_id);
ALTER TABLE groups ADD FOREIGN KEY (group_user_create) REFERENCES user_id(user_id);
ALTER TABLE groups ALTER COLUMN group_user_create SET NOT NULL; 
ALTER TABLE groups ALTER COLUMN group_time_create SET DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE groups ALTER COLUMN group_time_delete SET DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE groups ADD CHECK(group_time_create<=group_time_delete);
ALTER TABLE groups ALTER COLUMN group_rate SET DEFAULT(0);
ALTER TABLE groups ALTER COLUMN group_state SET NOT NULL;
ALTER TABLE groups ALTER COLUMN group_role SET DEFAULT(0);
COMMIT;

BEGIN;
ALTER TABLE group_date ADD FOREIGN KEY (group_id) REFERENCES groups(group_id);
ALTER TABLE group_date ALTER COLUMN group_id SET NOT NULL;
--ALTER TABLE group_date ALTER COLUMN group_id SET  UNIQUE;
ALTER TABLE group_date ALTER COLUMN article_id SET NOT NULL;
COMMIT;

ANALYZE VERBOSE;