create table users(id int primary key, json text);
insert into users values(111, '[{"id": 1, "name": "yamada"},{"id": 2, "name": "suzuki"}]');
insert into users values(222, '[{"id": 3, "name": "tanaka"}]');
insert into users values(333, '[]');
.headers on
.mode column
select * 
from (
    select id as users_id, value as object 
    from (
        select * from users, json_each(users.json)
    )
), json_tree(object);
