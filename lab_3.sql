 CREATE TABLE users
 (
 	user_name varchar(33)  NOT NULL UNIQUE,
 	password  varchar(18)  NOT NULL UNIQUE,
 	email     varchar(33)  NOT NULL UNIQUE,
 	real_name varchar(512) NOT NULL UNIQUE,
 	auto_enter boolean     NOT NULL DEFAULT(FALSE),
 	shrift_size int        NOT NULL DEFAULT(12) CHECK (shrift_size>=0 AND shrift_size<=100),
 	shrift_type int        NOT NULL DEFAULT(12) CHECK (shrift_type>=0 AND shrift_type<=100),
 	notification boolean   NOT NULL DEFAULT(TRUE),
 	sleep_time   boolean   NOT NULL DEFAULT(FALSE),
 	sleep_time_b time      NOT NULL DEFAULT('07:00:00'),
 	sleep_time_e time      NOT NULL DEFAULT('21:00:00'),
 	recomendation boolean  NOT NULL DEFAULT(TRUE),	
 
 	user_id SERIAL PRIMARY KEY
 );

INSERT INTO users VALUES('Никдегар'  ,'eICh8e6u7kgMG','NIKDEAGR@mail.ru'  ,'СвиридКирилов'   ); --adm
INSERT INTO users VALUES('Саллинар'  ,'YhNq3dFQZ4fOC','SALLINAR@gamil.com','ИльяКонстантинов'); --prog
INSERT INTO users VALUES('Мэттсон'   ,'iRPJgap9VlINq','METTSON@yandex.ru' ,'ЮрийКулаков'     ); --prof
INSERT INTO users VALUES('Гэршурен'  ,'pwtvFE8xKm8KE','GERSHUEN@bk.ru'    ,'АфанасийСубботин'
	,TRUE);
INSERT INTO users VALUES('Сидджериот','qLYnrYgBNPQMn','SIDDGERIOT@list.ru','АртамонЕгоров'
	,TRUE,13);
INSERT INTO users VALUES('Теоверкс'  ,'CIn1d3fEfjlmg','TEOVERKS@mail.ru'  ,'АфанасийКолесников'
	,TRUE,13,13);
INSERT INTO users VALUES('Дафергс'   ,'3ryDxmYDGO22r','DAFERGS@mail.ru'   ,'СавватийКотов'
	,TRUE,13,13,FALSE);
INSERT INTO users VALUES('Уэсонус'   ,'PRPalr3NGlHZ9','YESONUS@mail.ru'   ,'ЕфремНосков'
	,TRUE,13,13,FALSE,TRUE);
INSERT INTO users VALUES('Себсанэль' ,'XS2A0dO0xUgNe','SEBSANEL@mail.ru'  ,'КорнейБорисов'
	,TRUE,13,13,FALSE,TRUE,'10:30:00');
INSERT INTO users VALUES('Бенмадам'  ,'R2FLnbWHN7p6S','BENMADAM@mail.ru'  ,'МакарЩукин'
	,TRUE,13,13,FALSE,TRUE,'10:30:00','00:00:00');
INSERT INTO users VALUES('Венгиниот' ,'FHGj8gMnSYt3p','VENGELIOT@mail.ru' ,'ПарфёнНиколаевы',TRUE,13,13,FALSE,TRUE,'10:30:00','00:00:00',FALSE);

CREATE TABLE mask
(
	mask_name  varchar(33)     NOT NULL UNIQUE,
	photo_w    varchar(50)     DEFAULT('/s/photo/default_mask.png'),
	descr_w    varchar(50)     DEFAULT('/s/descr/default_desc.txt'),
	privilege  int             DEFAULT(1)    CHECK ((privilege >= 1) AND (privilege<=4)),
	department varchar(33)	   DEFAULT(NULL),
	course     int             DEFAULT(NULL) CHECK ((course IS NULL) OR (course>=1 AND course <=6)),

	mask_id SERIAL PRIMARY KEY
);

INSERT INTO mask VALUES('NATURE  STUDENTS GROUP','/s/photo/NSG.png','/s/descr/NSG.txt');
INSERT INTO mask VALUES('HISTORY STUDENTS GROUP','/s/photo/HSG.png','/s/descr/HSG.txt');
INSERT INTO mask VALUES('PROFESSOR','/s/photo/PROTON.png','/s/descr/PROFF.txt',2,'SP' );
INSERT INTO mask VALUES('HEADofCOURSE','/s/photo/boss.png','/s/descr/boss.txt',3);
INSERT INTO mask VALUES('ADMIN','/s/photo/adm.png','/s/descr/adm.txt',4);
INSERT INTO mask VALUES('A.Subbotin','/s/photo/a_s.png','/s/descr/a_s.txt',1,'SP',3);
INSERT INTO mask VALUES('A.Egorov'  ,'/s/photo/a_e.png','/s/descr/a_e.txt',1,'SP',2);
INSERT INTO mask VALUES('A.Kolesnik','/s/photo/a_k.png','/s/descr/a_k.txt',1,'SP',1);
INSERT INTO mask VALUES('S.Kotov   ','/s/photo/s_k.png','/s/descr/s_k.txt',1,'ASVK',3);
INSERT INTO mask VALUES('E.Noskov'  ,'/s/photo/e_n.png','/s/descr/e_n.txt',1,'ASVK',2);
INSERT INTO mask VALUES('K.Borisov' ,'/s/photo/k_b.png','/s/descr/k_b.txt',1,'ASVK',1);
INSERT INTO mask VALUES('M.Shukin'  ,'/s/photo/m_s.png','/s/descr/m_s.txt',1,'IIT',3);
INSERT INTO mask VALUES('P.Nikolaev','/s/photo/p_n.png','/s/descr/p_n.txt',1,'IIT',1);

CREATE TABLE U_M
(
	user_id int NOT NULL REFERENCES users(user_id) ON DELETE RESTRICT,
	mask_id int NOT NULL REFERENCES  mask(mask_id) ON DELETE RESTRICT,
	PRIMARY KEY (user_id,mask_id)
);

INSERT INTO U_M VALUES (4,6);
INSERT INTO U_M VALUES (5,7);
INSERT INTO U_M VALUES (6,8);
INSERT INTO U_M VALUES (7,9);
INSERT INTO U_M VALUES (8,10);
INSERT INTO U_M VALUES (9,11);
INSERT INTO U_M VALUES (10,12);
INSERT INTO U_M VALUES (11,13);

INSERT INTO U_M VALUES (1,4);
INSERT INTO U_M VALUES (2,3);
INSERT INTO U_M VALUES (3,5);

INSERT INTO U_M VALUES (4,1);
INSERT INTO U_M VALUES (5,1);
INSERT INTO U_M VALUES (6,1);
INSERT INTO U_M VALUES (7,1);
INSERT INTO U_M VALUES (8,1);

INSERT INTO U_M VALUES (4,2);
INSERT INTO U_M VALUES (5,2);
INSERT INTO U_M VALUES (6,2);
INSERT INTO U_M VALUES (7,2);


CREATE TABLE article
(
	article_name varchar(33)  NOT NULL UNIQUE,
	read_pr_min  int          DEFAULT(0) CHECK (read_pr_min>=0 AND read_pr_min<=4),
	text_p       varchar(256) NOT NULL DEFAULT('/s/art/text/exmpl.txt'), 
	pict_p       varchar(256) NOT NULL DEFAULT('/s/art/pict/exmpl'),
	scrp_p       varchar(256) NOT NULL DEFAULT('/s/art/scrp/exmpl'),
	data_cr      date         NOT NULL DEFAULT(CURRENT_TIMESTAMP),
	time_cr		 time	      NOT NULL DEFAULT(CURRENT_TIMESTAMP),

	article_id SERIAL PRIMARY KEY
);

INSERT INTO article VALUES ('AFRICA NATURE'   ,0,'/s/art/text/afr.txt','/s/art/pict/afr','/s/art/scrp/afr');
INSERT INTO article VALUES ('AMERICA NATURE'  ,0,'/s/art/text/ame.txt','/s/art/pict/ame','/s/art/scrp/ame');
INSERT INTO article VALUES ('EUROPE NATURE'   ,0,'/s/art/text/eur.txt','/s/art/pict/eur','/s/art/scrp/eur');
INSERT INTO article VALUES ('AUSTRALIA NATURE',0,'/s/art/text/aus.txt','/s/art/pict/aus','/s/art/scrp/aus');
INSERT INTO article VALUES ('NORT NATURE'     ,0,'/s/art/text/nor.txt','/s/art/pict/nor','/s/art/scrp/nor');

INSERT INTO article VALUES ('HISTORY'  ,0,'/s/art/text/his.txt','/s/art/pict/his','/s/art/scrp/his');
INSERT INTO article VALUES ('TIMETABLE',1,'/s/art/text/tmr.txt','/s/art/pict/tmr','/s/art/scrp/tmr');
INSERT INTO article VALUES ('MATERIAL' ,1,'/s/art/text/mat.txt','/s/art/pict/mat','/s/art/scrp/mat');
INSERT INTO article VALUES ('DISPUT'   ,2,'/s/art/text/dis.txt','/s/art/pict/dis','/s/art/scrp/dis');

INSERT INTO article VALUES ('DANCE CLUB',1,'/s/art/text/dan.txt','/s/art/pict/dan','/s/art/scrp/dan');
INSERT INTO article VALUES ('CHESS CLUB',1,'/s/art/text/chs.txt','/s/art/pict/chs','/s/art/scrp/chs');
INSERT INTO article VALUES ('MATH  CLUB',1,'/s/art/text/mth.txt','/s/art/pict/mth','/s/art/scrp/mth');

CREATE TABLE M_A 
(
	mask_id    int NOT NULL REFERENCES  mask(mask_id)      ON DELETE RESTRICT,
	article_id int NOT NULL REFERENCES article(article_id) ON DELETE RESTRICT,
	PRIMARY KEY (mask_id,article_id)
);

INSERT INTO M_A VALUES(1,1);
INSERT INTO M_A VALUES(1,2);
INSERT INTO M_A VALUES(1,3);
INSERT INTO M_A VALUES(1,4);
INSERT INTO M_A VALUES(1,5);

INSERT INTO M_A VALUES(2,6);
INSERT INTO M_A VALUES(4,7);
INSERT INTO M_A VALUES(3,8);
INSERT INTO M_A VALUES(5,9);

INSERT INTO M_A VALUES(10,10);
INSERT INTO M_A VALUES(11,10);
INSERT INTO M_A VALUES(12,10);
INSERT INTO M_A VALUES(13,10);

INSERT INTO M_A VALUES(6,11);
INSERT INTO M_A VALUES(7,11);
INSERT INTO M_A VALUES(8,11);
INSERT INTO M_A VALUES(9,11);
INSERT INTO M_A VALUES(10,11);

INSERT INTO M_A VALUES(10,12);
INSERT INTO M_A VALUES(11,12);

CREATE TABLE Groups
(
	group_name varchar(33)  NOT NULL UNIQUE,
	group_priv int          NOT NULL DEFAULT(0) CHECK (group_priv>=0 AND group_priv <=4),
	write_priv boolean      NOT NULL DEFAULT(FALSE),
	photo_p    varchar(256) NOT NULL DEFAULT('/s/gphoto/default.png'),
	descr_p    varchar(256) NOT NULL DEFAULT('/s/gdes/default.txt'),

	group_id SERIAL PRIMARY KEY
);

INSERT INTO Groups VALUES('NATURE',0,FALSE,'/s/gphoto/nature.png','/s/gdes/nature.txt');
INSERT INTO Groups VALUES('GEOLOGICAL FACULTY',1,TRUE,'/s/gphoto/geofac.png','/s/gdes/geofac.txt');
INSERT INTO Groups VALUES('CLUB',1,FALSE,'/s/gphoto/cla.png','/s/gdes/cla.txt');
INSERT INTO Groups VALUES('CLUB_STUDENTS',1,TRUE,'/s/gphoto/cls.png','/s/gdes/cls.txt');
INSERT INTO Groups VALUES('OTHER',0,TRUE,'/s/gphoto/oth.png','/s/gdes/oth.txt');

INSERT INTO Groups VALUES('TIMETABLE',1,FALSE,'/s/gphoto/tmt.png','/s/gdes/tmt.txt');
INSERT INTO Groups VALUES('SUBJECT',1,FALSE,'/s/gphoto/sun.png','/s/gdes/sun.txt');
INSERT INTO Groups VALUES('DISPUT_S',1,TRUE,'/s/gphoto/dss.png','/s/gdes/dss.txt');
INSERT INTO Groups VALUES('DISPUT_P',2,TRUE,'/s/gphoto/dsp.png','/s/gdes/dsp.txt');
INSERT INTO Groups VALUES('PROGRAMMERS',4,TRUE,'/s/gphoto/prog.png','/s/gdes/prog.txt');

CREATE TABLE A_G
(
	article_id int NOT NULL REFERENCES article(article_id) ON DELETE RESTRICT,
	  group_id int NOT NULL REFERENCES groups (group_id  ) ON DELETE RESTRICT,
	PRIMARY KEY (article_id,group_id)
);

INSERT INTO A_G VALUES(1,1);
INSERT INTO A_G VALUES(2,1);
INSERT INTO A_G VALUES(3,1);
INSERT INTO A_G VALUES(4,1);
INSERT INTO A_G VALUES(5,1);

INSERT INTO A_G VALUES(1,2);
INSERT INTO A_G VALUES(2,2);
INSERT INTO A_G VALUES(3,2);
INSERT INTO A_G VALUES(4,2);
INSERT INTO A_G VALUES(5,2);

INSERT INTO A_G VALUES(10,3);
INSERT INTO A_G VALUES(11,3);
INSERT INTO A_G VALUES(12,3);
INSERT INTO A_G VALUES(10,4);
INSERT INTO A_G VALUES(11,4);
INSERT INTO A_G VALUES(12,4);

INSERT INTO A_G VALUES(6,5);
INSERT INTO A_G VALUES(7,6);
INSERT INTO A_G VALUES(6,7);
INSERT INTO A_G VALUES(9,8);
INSERT INTO A_G VALUES(9,9);
INSERT INTO A_G VALUES(8,10);

CREATE TABLE M_G
(
	mask_id  int NOT NULL REFERENCES mask(mask_id)       ON DELETE RESTRICT,
	group_id int NOT NULL REFERENCES groups (group_id  ) ON DELETE RESTRICT,
	PRIMARY KEY (mask_id,group_id)
);

INSERT INTO M_G VALUES(1,1);
INSERT INTO M_G VALUES(1,2);
INSERT INTO M_G VALUES(6,5);
INSERT INTO M_G VALUES(7,5);
INSERT INTO M_G VALUES(8,5);

INSERT INTO M_G VALUES(9,5);
INSERT INTO M_G VALUES(10,5);
INSERT INTO M_G VALUES(11,5);
INSERT INTO M_G VALUES(12,5);
INSERT INTO M_G VALUES(13,5);

INSERT INTO M_G VALUES(5,3);
INSERT INTO M_G VALUES(6,4);
INSERT INTO M_G VALUES(7,4);
INSERT INTO M_G VALUES(8,4);
INSERT INTO M_G VALUES(9,4);

INSERT INTO M_G VALUES(4,6);
INSERT INTO M_G VALUES(4,7);

INSERT INTO M_G VALUES(6,8);
INSERT INTO M_G VALUES(7,8);
INSERT INTO M_G VALUES(8,8);
INSERT INTO M_G VALUES(9,8);
INSERT INTO M_G VALUES(10,8);

INSERT INTO M_G VALUES(3,9);
INSERT INTO M_G VALUES(5,10);