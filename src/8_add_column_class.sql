create table users(id int primary key, class text, json text);
insert into users values(111, 'A', '[{"id": 1, "name": "yamada"},{"id": 2, "name": "suzuki"}]');
insert into users values(222, 'A', '[{"id": 3, "name": "tanaka"}]');
insert into users values(333, 'A', '[]');
insert into users values(444, 'B', '[{"id": 1, "name": "suzuki"}]');
.headers on
.mode column

select * 
from (
    select users_id, objects_id, key, value, type 
    from (
        select id as users_id, key as objects_id, value as object 
        from (
            select * from users, json_each(users.json)
        )
    ), json_tree(object)
    where atom!=''
)
where key='name' and value='suzuki';

