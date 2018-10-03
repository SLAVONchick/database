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
('Adherents of Kenaira', 'Adherents believes that goddess Kenaira will come in our world and take what they think belongs to her - souls of livings. No one gave meaning to those religios fanatics, untill 27 years ago their leader has realized that it''s time for Kenaira to come.'),
('Enlighteners', 'Theese are scientists, but what''s more important, they are last hope of this world. Since they are scientists, they shouldn''t belive in any god, but there eyes tell them that Kenaira is not a character from some tale, when they see what Adherents'' prays can do.. ');

insert into mmo.skill_types (name)
values
('Melee Attack'),
('Remote Attack'),
('Healing'),
('Burning'),
('Freezing'),
('Poisoning'),
('Mind Control'),
('Damage absorbing');

insert into mmo.roles (name)
values
('Tank'),
('Fighter'),
('Healer');

insert into mmo.classes (name, description, strength, intelligence, speed, agility, luck, health)
values
('Kenaira''s priest', 'Kenaira''s priest - main worshiper of Kenaira. Can do powerful things with the help of Kenaira''s will.', 9, 9, 8, 10, 11, 1500);
('Doctor of Philosophy', 'This is a highly educated scientist, who had to learn war craft to defend his world.', 12, 7, 9, 9, 11, 1500),
('Man of steel', 'Warrior that has great health to absorb damage', 10, 7, 8, 8, 10, 2000),
('Cannon fodder', 'He goes to the battleright after the Man of steel to inflict more damage.', 14, 7, 10, 9, 8, 1000),
('Carrier', 'It is important member of team, ''cause he can heal teammates.', 9, 14, 8, 8, 9, 1200),
('Defender', 'Warrior that can abcorb damage and heal teammates.', 11, 12, 8, 9, 9, 1800);
 
 insert into mmo.roles_classes(role_id, class_id)
 values
 (2, 1),
 (3, 1),
 (1, 2),
 (2, 2),
 (1, 3),
 (2, 4),
 (3, 5),
 (1, 6),
 (3, 6);
 
 insert into mmo.races(name, description)
 values
 ('Humans', null),
 ('Mechs', null),
 ('Space Orcs', null),
 ('Cannibals of Tarris', null),
 ('Witchers', null),
 ('Space Elves', null);
 
 insert into mmo.races_classes_fractions(race_id, fraction_id, class_id)
 values
 (1, 2, 2),
 (1, 2, 3),
 (1, 2, 4),
 (1, 2, 5),
 (2, 1, 1),
 (2, 1, 3),
 (2, 1, 4),
 (2, 1, 6),
 (2, 2, 2),
 (2, 2, 3),
 (2, 2, 4),
 (2, 2, 6),
 (3, 1, 1),
 (3, 1, 3),
 (3, 1, 4),
 (3, 1, 6),
 (4, 1, 1),
 (4, 1, 4),
 (4, 1, 5),
 (4, 1, 6),
 (5, 1, 1),
 (5, 1, 4),
 (5, 1, 5),
 (5, 1, 6),
 (5, 2, 2),
 (5, 2, 4),
 (5, 2, 5),
 (5, 2, 6),
 (6, 2, 2),
 (6, 2, 4),
 (6, 2, 5),
 (6, 2, 6);
 
 insert into mmo.skills 
 (name, practical_stats, skill_type, min_level, class_id, race_id, is_passive, self, for_enemy, is_stubbing, duration) 
 values
 ('Race specific skill', 200, 3, 1, null, 6, 0, 1, 1, 0, null),
 ('Race specific skill', 200, 1, 1, null, 1, 0, 0, 1, 0, null),
 ('Race specific skill', 200, 4, 1, null, 3, 0, 0, 1, 0, null),
 ('Race specific skill', 200, 2, 1, null, 2, 0, 0, 1, 0, '5 seconds'),
 ('Race specific skill', 200, 6, 1, null, 5, 0, 0, 1, 0, null),
 ('Race specific skill', 0, 7, 1, null, 4, 0, 0, 1, 1, '5 seconds'),
 ('Skill #1', 100, 7, 1, 1, null, 0, 0, 1, 0, '2 seconds'),
 ('Skill #2', 200, 4, 1, 1, null, 0, 0, 1, 0, null),
 ('Skill #1', 200, 4, 1, 2, null, 0, 0, 1, 0, null),
 ('Skill #2', 200, 5, 1, 2, null, 0, 0, 1, 0, null),
 ('Skill #1', 200, 8, 1, 3, null, 0, 0, 1, 0, null),
 ('Skill #2', 200, 1, 1, 3, null, 0, 0, 1, 0, null),
 ('Skill #1', 200, 2, 1, 4, null, 0, 0, 1, 0, null),
 ('Skill #2', 200, 6, 1, 4, null, 0, 0, 1, 0, null),
 ('Skill #1', 200, 2, 1, 5, null, 0, 0, 1, 0, null),
 ('Skill #2', 200, 3, 1, 5, null, 0, 1, 0, 0, '10 seconds'),
 ('Skill #1', 200, 8, 1, 6, null, 0, 0, 1, 0, null),
 ('Skill #2', 200, 3, 1, 6, null, 0, 0, 1, 0, '5 seconds');
 
 insert into mmo.level_types (name, gained_xp_multiplier)
 values
 ('Common', 1),
 ('Special', 2),
 ('Rare', 3),
 ('Legendary', 4),
 ('Epic', 5),
 ('Exotic', 6);
  
 insert into mmo.equipment_types (name, can_be_equipped)
 values
 ('One-handed weapon', 1),
 ('Two-handed weapon', 1),
 ('Helmet', 1),
 ('Torso', 1),
 ('Gloves', 1),
 ('Pants', 1),
 ('Boots', 1),
 ('Chemistry', 0),
 ('Bag', 0);
 
 insert into mmo.characters (
  player_id, server_id, fraction_id, race_id, class_id, name, strength, intelligence, speed,
  agility, luck, max_health, cur_health, xp_to_next_level, cur_xp, is_online, created_dt
 )
 values
 (
  1, server_id, fraction_id, race_id, class_id, name, strength, intelligence, speed,
  agility, luck, max_health, cur_health, xp_to_next_level, cur_xp, is_online, created_dt
 ),
 
 
 
 
 
 
 
 
