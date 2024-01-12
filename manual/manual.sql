-- show all tables
select name from sqlite_master where type = 'table';
/*
+----------------------+
|         name         |
+----------------------+
| knex_migrations      |
| sqlite_sequence      |
| knex_migrations_lock |
| countries            |
| users                |
| sessions             |
| cats                 |
| photos               |
+----------------------+
*/

SELECT name FROM sqlite_master WHERE type = 'table' AND name NOT LIKE '%knex_%' AND name != 'sqlite_sequence';

-- show all identity indexs
select name from sqlite_master where type = 'index';
/*
+--------------------------------------------+
|                    name                    |
+--------------------------------------------+
| users_email_unique                         |
| sessions_user_id_index                     |
| sessions_access_token_index                |
| sessions_is_revoked_index                  |
| sessions_expired_at_index                  |
| cats_user_id_index                         |
| photos_title_index                         |
| photos_cat_id_index                        |
| users_followers_user_id_index              |
| users_followers_follower_id_index          |
| users_followers_user_id_follower_id_unique |
+--------------------------------------------+
*/

-- show max index for each table
select name, max(seq) from sqlite_sequence;

-- show schema for table users
PRAGMA table_info(users);

select id, created_at, updated_at from users limit 5;

select * from users limit 5;
select * from sessions limit 5;
select * from cats limit 5;
select * from countries limit 5;
select * from photos limit 5;

select count(*) as total_cats from cats;
/*
+------------+
| total_cats |
+------------+
| 228        |
+------------+
*/

select count(*) as total_users from users;
/*
+-------------+
| total_users |
+-------------+
| 50          |
+-------------+
*/

select count(*) as total_sessions from sessions;
/*
+----------------+
| total_sessions |
+----------------+
| 0              |
+----------------+
*/

select count(*) as total_countries from countries;
/*
+-----------------+
| total_countries |
+-----------------+
| 249             |
+-----------------+
*/

select count(*) as total_photos from photos;
/*
+--------------+
| total_photos |
+--------------+
| 11680        |
+--------------+
*/

select count(*) as total_users_followers from users_followers;
/*
+-----------------------+
| total_users_followers |
+-----------------------+
| 714                   |
+-----------------------+
*/

-- list all users with role 'admin'
select email from users where role='admin' limit 5;

-- list all users with role 'user'
select email from users where role='user' limit 5;

-- display all columns
PRAGMA table_info(cats);
PRAGMA table_info(users);
PRAGMA table_info(sessions);
PRAGMA table_info(countries);
PRAGMA table_info(photos);
PRAGMA table_info(users_followers);


select users.id, count(cats.id) as total_cats from users
    left join cats on users.id = cats.user_id
    group by users.id;

select users.id, users.name, countries.name as country_name from users left join countries on
    users.country_id = countries.id where users.id in (43, 11, 29, 16);

select users.id, users.name, count(cats.id) as total_cats from users left join cats on
    users.id = cats.user_id where users.id in (43, 11, 29, 16) group by users.id;

select id, name, status from cats where user_id in (43);
select id, name, status from cats where user_id in (11);

update users set status = 0 where id in (45);
select id from cats where user_id in (33);
update cats set status = 0 where id in (177);
select id from photos where cat_id in (180);
select id from photos where cat_id in (177);
update photos set status = 0 where id in (7205); -- cat_id in (180);

select email from users where id in (43);
select id from photos where cat_id in (162);

select cat_id, count(id) from photos where cat_id in (161, 213, 216) group by cat_id;

select count(id) from photos where cat_id in (213);
select id, title, cat_id from photos where cat_id in (161);

select count(cats.id), cats.name, cats.id, cats.status from photos left join cats on photos.cat_id = cats.id
    where cats.user_id in (43) group by cats.id;

select cats.id, count(photos.id) from photos left join cats on photos.cat_id = cats.id
    where cats.id in (220) group by cats.id;

select users.id, count(photos.id) from photos left join cats on photos.cat_id = cats.id
    left join users on cats.user_id = users.id where users.id in (43) group by users.id;

select users.id, count(photos.id) from photos left join cats on photos.cat_id = cats.id
    left join users on cats.user_id = users.id
    where users.id in (43) and photos.status = 1 and cats.status = 1
    group by users.id;


-- followers test query

select users.id, count(*) from users left join users_followers on users.id = users_followers.user_id
    where users.id in (43, 3, 1) group by users.id;

select users_followers.follower_id from users_followers
    where users_followers.user_id in (3);

select count(*) from users_followers where user_id in (3);

select `users`.`id` as `userId`, count(*) as `count` from `users` left join `users_followers`
on `users`.`id` = `users_followers`.`user_id` where
`users`.`id` in (45) group by `userId`, `users_followers`.`user_id`;

select user_id, count(*) as count_followers from users_followers group by user_id limit 100;

select * from users_followers where user_id = 1;

select `users`.`name`, `users`.`id` from `users_followers` inner join `users`
    on `users`.`id` = `users_followers`.`follower_id`
    where `users_followers`.`user_id` = 1 and follower_id in (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);

-- followers test query
