insert into mmo.server_types (name)
values
('PvP'),
('PvE'),
('RP');

insert into mmo.servers (name, type_id, max_loading, country_id)
values
('Russian PvP #1', 1, 1000, (select id from mmo.countries where alpha_3 = 'RUS')),
('Russian PvP #2', 1, 900, (select id from mmo.countries where alpha_3 = 'RUS')),
('Russian PvP #3', 1, 800, (select id from mmo.countries where alpha_3 = 'RUS')),
('Russian PvE #1', 2, 1000, (select id from mmo.countries where alpha_3 = 'RUS')),
('Russian RP #1', 3, 1000, (select id from mmo.countries where alpha_3 = 'RUS')),
('American PvP #1', 1, 1000, (select id from mmo.countries where alpha_3 = 'USA')),
('American PvP #2', 1, 900, (select id from mmo.countries where alpha_3 = 'USA')),
('American PvP #3', 1, 800, (select id from mmo.countries where alpha_3 = 'USA')),
('American PvE #1', 2, 1000, (select id from mmo.countries where alpha_3 = 'USA')),
('American RP #1', 3, 1000, (select id from mmo.countries where alpha_3 = 'USA'));

insert into mmo.players (email, nickname, country_id, created_dt)
values
('slavonn1@gmail.com', 'SLAVONchick', (select id from mmo.countries where alpha_3 = 'RUS'), now()),
('mramerican@icloud.com', 'Dr.DRE', (select id from mmo.countries where alpha_3 = 'USA'), now()),
('slavik@gmail.com', 'viacheslavik', (select id from mmo.countries where alpha_3 = 'RUS'), now()),
('gera@gmail.com', 'gera_in', (select id from mmo.countries where alpha_3 = 'RUS'), now()),
('liza@gmail.com', 'lizon', (select id from mmo.countries where alpha_3 = 'RUS'), now()),
('mariya@gmail.com', 'MaShUlYa', (select id from mmo.countries where alpha_3 = 'RUS'), now()),
('lena@gmail.com', 'lenok', (select id from mmo.countries where alpha_3 = 'USA'), now()),
('michael@gmail.com', 'Mr. Jackson', (select id from mmo.countries where alpha_3 = 'USA'), now()),
('rihana@gmail.com', 'Rihanna', (select id from mmo.countries where alpha_3 = 'USA'), now()),
('jayz@gmail.com', 'Method Man', (select id from mmo.countries where alpha_3 = 'USA'), now());


insert into mmo.fractions (name, description)
values
('Justice League', 'The Justice League - great aliance with Batman and Superman as head, is recruiting new members to face The Avengers after "The Great World Dividing".'),
('Avengers', 'The Avengers - an assembly of well known heroes (e.g. Iron Man, Dr. Strange) from Earth-51 coordinated by Nick Fury is going to get new men in crew.');

insert into mmo.skill_types (name)
values
('Melee Attack'),
('Remote Attack'),
('Healing'),
('Burning'),
('Freezing'),
('Poisoning'),
('Mind Control');

insert into mmo.roles (name)
values
('Tank'),
('Fighter'),
('Healer');

insert into mmo.classes (name, role_id, description, strength, intelligence, speed, agility, luck, health)
values
('Funny Guy', 2, 'Funny Guy is a skillfull warrior, that relys on his agility and luck, with good sense of humor, that exists in every super hero squad.', 10, 7, 9, 12, 11, 1000);
--('', 2, ' is a skillfull warrior with good sense of humor, that exists in every super hero squad.', 12, 7, 9, 9, 11, 1000),

