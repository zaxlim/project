SET time_zone = '+8:00';

drop table if exists affiliate_category_map;
drop table if exists affiliate_action;
drop table if exists score;
drop table if exists video_keyword;
drop table if exists video_category_map;
drop table if exists video;
drop table if exists contract;
drop table if exists user;
drop table if exists profile_name;

create table profile_name (
    profile_id INT NOT NULL auto_increment,
    p_value VARCHAR(10),
    PRIMARY KEY (profile_id)
);

insert into profile_name (p_value) values ('child');
insert into profile_name (p_value) values ('parent');
insert into profile_name (p_value) values ('creator');

drop table if exists literacy_level;

create table literacy_level (
    level_id INT NOT NULL auto_increment,
    name VARCHAR(50),
    PRIMARY KEY (level_id)
);

insert into literacy_level (name) values ('caveman');
insert into literacy_level (name) values ('looking around');
insert into literacy_level (name) values ('has finance background');
insert into literacy_level (name) values ('has investment portfolio');
insert into literacy_level (name) values ('warren buffet');

create table user (
    user_id INT NOT NULL auto_increment,
    parent_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birth_date date,
    gender ENUM('M','F'),
    contact VARCHAR(20),
    email VARCHAR(50),
    u_password VARCHAR(15),
    access_token VARCHAR(255),
    profile_id INT,
    consent BOOLEAN,
    level_id INT,
    PRIMARY KEY (user_id),
    FOREIGN KEY (profile_id) REFERENCES profile_name (profile_id),
    FOREIGN KEY (level_id) REFERENCES literacy_level (level_id),
    FOREIGN KEY (parent_id) REFERENCES user (user_id)
);

insert into user (user_id, parent_id, first_name, last_name, birth_date, gender, contact, email, u_password, access_token, profile_id, consent, level_id) values (2, null, 'Yanting', 'Luen', '1976-02-10', 'F', '+65 8563 5678', 'test2@gmail.com', 'jR3lJaMUEqqT', 'fcba80bed21d804a50918814267e39a68fa193e7', 2, true, 2);
insert into user (user_id, parent_id, first_name, last_name, birth_date, gender, contact, email, u_password, access_token, profile_id, consent, level_id) values (8, null, 'Jack', 'Wong', '1976-02-07', 'M', '+65 9092 4305', 'test8@gmail.com', 'y2bYQOE', 'fcba80bed21d804a50918814267e39a68fa193e7', 2, true, 3);
insert into user (user_id, parent_id, first_name, last_name, birth_date, gender, contact, email, u_password, access_token, profile_id, consent, level_id) values (1, 2, 'Ben', 'Yeo', '2008-06-08', 'M', '+65 9835 8385', 'test1@gmail.com', 'wwwabcdefg', 'fcba80bed21d804a50918814267e39a68fa193e7', 1, true, 1);
insert into user (user_id, parent_id, first_name, last_name, birth_date, gender, contact, email, u_password, access_token, profile_id, consent, level_id) values (3, 8, 'Felicia', 'Lim', '2008-03-19', 'F', '+65 9003 2233', 'test3@gmail.com', 'EpTXcPmWpM9', 'fcba80bed21d804a50918814267e39a68fa193e7', 1, true, 3);
insert into user (user_id, parent_id, first_name, last_name, birth_date, gender, contact, email, u_password, access_token, profile_id, consent, level_id) values (4, 2, 'Ming En', 'Tan', '2007-08-15', 'M', '+65 9111 9090', 'test4@gmail.com', 'jNfsE4Y2v', 'fcba80bed21d804a50918814267e39a68fa193e7', 1, true, 4);
insert into user (user_id, parent_id, first_name, last_name, birth_date, gender, contact, email, u_password, access_token, profile_id, consent, level_id) values (5, 8, 'Chrysan', 'Tan', '2008-04-21', 'F', '+65 9190 4309', 'test5@gmail.com', 'DewgrGPyJlB', 'fcba80bed21d804a50918814267e39a68fa193e7', 1, true, 5);
insert into user (user_id, parent_id, first_name, last_name, birth_date, gender, contact, email, u_password, access_token, profile_id, consent, level_id) values (6, 2, 'Nelly', 'Tay', '2002-02-24', 'F', '+65 9099 4509', 'test6@gmail.com', 'WG1JMqcVGq', 'fcba80bed21d804a50918814267e39a68fa193e7', 1, true, 1);
insert into user (user_id, parent_id, first_name, last_name, birth_date, gender, contact, email, u_password, access_token, profile_id, consent, level_id) values (7, null, 'Nicholas', 'Lee', '1968-09-13', 'M', '+65 9096 4390', 'test7@gmail.com', 'f4DZ4dOX', 'fcba80bed21d804a50918814267e39a68fa193e7', 2, true, 2);
insert into user (user_id, parent_id, first_name, last_name, birth_date, gender, contact, email, u_password, access_token, profile_id, consent, level_id) values (9, 2, 'Sasha', 'Layla', '2008-03-15', 'F', '+65 9790 4779', 'test9@gmail.com', 'yf0pobR', 'fcba80bed21d804a50918814267e39a68fa193e7', 1, true, 4);
insert into user (user_id, parent_id, first_name, last_name, birth_date, gender, contact, email, u_password, access_token, profile_id, consent, level_id) values (10, 8, 'Ben', 'Yakovlev', '2009-09-09', 'M', '+65 9490 9043', 'test10@gmail.com', 'ZyOFI4uOR9I2', 'fcba80bed21d804a50918814267e39a68fa193e7', 1, false, 4);

drop table if exists contract_status;

create table contract_status (
    status_id INT NOT NULL auto_increment, 
    cs_value VARCHAR(15),
    PRIMARY KEY (status_id)
);

insert into contract_status (cs_value) values ('open');
insert into contract_status (cs_value) values ('in progress');
insert into contract_status (cs_value) values ('completed');
insert into contract_status (cs_value) values ('done');
insert into contract_status (cs_value) values ('void');

create table contract (
    contract_id INT NOT NULL auto_increment, 
    child_id INT,
    parent_id INT, 
    timestamp_created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    timestamp_completed TIMESTAMP, 
    timestamp_updated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, 
    c_description VARCHAR(100),
    status_id INT,
    c_value FLOAT(10),
    PRIMARY KEY (contract_id),
    FOREIGN KEY (child_id) REFERENCES user (user_id),
    FOREIGN KEY (parent_id) REFERENCES user (user_id),
    FOREIGN KEY (status_id) REFERENCES contract_status (status_id)
);

insert into contract (contract_id, child_id, parent_id, timestamp_created, timestamp_completed, timestamp_updated, c_description, status_id, c_value) values (1, 1, 7, '2021-05-20', '2020-11-21', '2021-02-10', 'Pick up groceries from HAO Mart', 1, 10.00);
insert into contract (contract_id, child_id, parent_id, timestamp_created, timestamp_completed, timestamp_updated, c_description, status_id, c_value) values (2, 1, 7, '2020-08-07', '2020-12-19', '2020-10-18', 'Achieve 60/100 in A Maths', 1, 100);
insert into contract (contract_id, child_id, parent_id, timestamp_created, timestamp_completed, timestamp_updated, c_description, status_id, c_value) values (3, 1, 2, '2021-03-20', '2021-03-11', '2021-02-10', '⁦家务活',2, 20.00);
insert into contract (contract_id, child_id, parent_id, timestamp_created, timestamp_completed, timestamp_updated, c_description, status_id, c_value) values (4, 5, 7, '2021-01-28', '2020-12-22', '2021-01-03', 'Dont beat sister for this week', 2, 50.00);
insert into contract (contract_id, child_id, parent_id, timestamp_created, timestamp_completed, timestamp_updated, c_description, status_id, c_value) values (5, 4, 2, '2021-04-04', '2020-12-12', '2020-10-04', 'test', 2, 123.50);

create table video (
    video_id INT NOT NULL auto_increment,
    user_id INT,
    title VARCHAR(50),
    v_description VARCHAR(100),
    v_URL VARCHAR(255),
    timestamp_uploaded TIMESTAMP,
    duration FLOAT(10),
    view_count INT(255),
    level_id INT,
    premium BOOLEAN,
    PRIMARY KEY (video_id),
    FOREIGN KEY (user_id) REFERENCES user (user_id),
    FOREIGN KEY (level_id) REFERENCES literacy_level (level_id)
);

drop table if exists affiliate_category;

create table affiliate_category (
    category_id INT NOT NULL auto_increment,
    name VARCHAR(20),
    PRIMARY KEY (category_id)
);

create table video_category_map (
    map_id INT NOT NULL auto_increment,
    video_id INT,
    category_id INT, 
    PRIMARY KEY (map_id),
    FOREIGN KEY (video_id) REFERENCES video (video_id),
    FOREIGN KEY (category_id) REFERENCES affiliate_category (category_id)
);

create table video_keyword (
    keyword_id INT NOT NULL auto_increment,
    video_id INT,
    keyword VARCHAR (50),
    PRIMARY KEY (keyword_id),
    FOREIGN KEY (video_id) REFERENCES video (video_id)
);

drop table if exists video_category;

create table video_category (
    category_id INT NOT NULL auto_increment,
    name VARCHAR(50),
    PRIMARY KEY (category_id)
);

drop table if exists affiliate;

create table affiliate (
    affiliate_id INT NOT NULL auto_increment,
    timestamp_start TIMESTAMP, 
    timestamp_expire TIMESTAMP,
    image_URL VARCHAR(255),
    redirect_URL VARCHAR(255),
    active BOOLEAN, 
    PRIMARY KEY (affiliate_id)
);

create table affiliate_category_map (
    map_id INT NOT NULL auto_increment,
    affiliate_id INT, 
    category_id INT,
    PRIMARY KEY (map_id),
    FOREIGN KEY (affiliate_id) REFERENCES affiliate (affiliate_id),
    FOREIGN KEY (category_id) REFERENCES affiliate_category (category_id)
);

create table score (
    score_id INT NOT NULL auto_increment,
    user_id INT,
    earning_XP INT,
    spending_XP INT, 
    borrowing_XP INT,
    saving_XP INT,
    PRIMARY KEY (score_id),
    FOREIGN KEY (user_id) REFERENCES user (user_id)
);

drop table if exists affiliate_status;

create table affiliate_status (
    status_id INT NOT NULL auto_increment,
    a_value VARCHAR(20),
    PRIMARY KEY (status_id)
);

create table affiliate_action (
    action_id INT NOT NULL auto_increment,
    user_id INT,
    timestamp_start TIMESTAMP, 
    affiliate_id INT, 
    status INT,
    PRIMARY KEY (action_id),
    FOREIGN KEY (user_id) REFERENCES user (user_id),
    FOREIGN KEY (affiliate_id) REFERENCES affiliate_status (status_id)
);
