begin transaction;

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


insert into mmo.fractions (name, descripition)
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
('Kenaira''s priest', 'Kenaira''s priest - main worshiper of Kenaira. Can do powerful things with the help of Kenaira''s will.', 9, 9, 8, 10, 11, 1500),
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
 ('Race specific skill', 200, 3, 1, null, 6, '0', '1', '1', '0', null),
 ('Race specific skill', 200, 1, 1, null, 1, '0', '0', '1', '0', null),
 ('Race specific skill', 200, 4, 1, null, 3, '0', '0', '1', '0', null),
 ('Race specific skill', 200, 2, 1, null, 2, '0', '0', '1', '0', '5 seconds'),
 ('Race specific skill', 200, 6, 1, null, 5, '0', '0', '1', '0', null),
 ('Race specific skill', 0, 7, 1, null, 4, '0', '0', '1', '1', '5 seconds'),
 ('Skill #1', 100, 7, 1, 1, null, '0', '0', '1', '0', '2 seconds'),
 ('Skill #2', 200, 4, 1, 1, null, '0', '0', '1', '0', null),
 ('Skill #1', 200, 4, 1, 2, null, '0', '0', '1', '0', null),
 ('Skill #2', 200, 5, 1, 2, null, '0', '0', '1', '0', null),
 ('Skill #1', 200, 8, 1, 3, null, '0', '0', '1', '0', null),
 ('Skill #2', 200, 1, 1, 3, null, '0', '0', '1', '0', null),
 ('Skill #1', 200, 2, 1, 4, null, '0', '0', '1', '0', null),
 ('Skill #2', 200, 6, 1, 4, null, '0', '0', '1', '0', null),
 ('Skill #1', 200, 2, 1, 5, null, '0', '0', '1', '0', null),
 ('Skill #2', 200, 3, 1, 5, null, '0', '1', '0', '0', '10 seconds'),
 ('Skill #1', 200, 8, 1, 6, null, '0', '0', '1', '0', null),
 ('Skill #2', 200, 3, 1, 6, null, '0', '0', '1', '0', '5 seconds');

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
 ('One-handed weapon', '1'),
 ('Two-handed weapon', '1'),
 ('Helmet', '1'),
 ('Torso', '1'),
 ('Gloves', '1'),
 ('Pants', '1'),
 ('Boots', '1'),
 ('Chemistry', '0'),
 ('Bag', '0');

insert into mmo.characters (player_id,
                            server_id,
                            fraction_id,
                            race_id,
                            class_id,
                            name,
                            strength,
                            intelligence,
                            speed,
                            agility,
                            luck,
                            max_health,
                            cur_health,
                            xp_to_next_level,
                            cur_xp,
                            is_online,
                            created_dt,
                            level)
values (1,                                                   --player_id,
        2,                                                   --server_id,
        2,                                                   --fraction_id,
        2,                                                   --race_id,
        2,                                                   --class_id,
        'mr. X',                                             --name,
        (select strength from mmo.classes where id = 2),     --strength,
        (select intelligence from mmo.classes where id = 2), --intelligence,
        (select speed from mmo.classes where id = 2),        --speed,
        (select agility from mmo.classes where id = 2),      --agility,
        (select luck from mmo.classes where id = 2),         --luck,
        (select health from mmo.classes where id = 2),       --max_health,
        (select health from mmo.classes where id = 2),       --cur_health,
        1000,                                                --xp_to_next_level,
        0,                                                   --cur_xp,
        '0',                                                 --is_online,
        now(),                                               --created_dt,
        1),                                                  --level

       (2,
        2,
        1,
        3,
        1,
        '47th agent',
        (select strength from mmo.classes where id = 1),
        (select intelligence from mmo.classes where id = 1),
        (select speed from mmo.classes where id = 1),
        (select agility from mmo.classes where id = 1),
        (select luck from mmo.classes where id = 1),
        (select health from mmo.classes where id = 1),
        (select health from mmo.classes where id = 1),
        1000,
        0,
        '0',
        now(),
        1),

       (3,                                                   --player_id,
        2,                                                   --server_id,
        2,                                                   --fraction_id,
        6,                                                   --race_id,
        4,                                                   --class_id,
        'Elf Player',                                        --name,
        (select strength from mmo.classes where id = 4),     --strength,
        (select intelligence from mmo.classes where id = 4), --intelligence,
        (select speed from mmo.classes where id = 4),        --speed,
        (select agility from mmo.classes where id = 4),      --agility,
        (select luck from mmo.classes where id = 4),         --luck,
        (select health from mmo.classes where id = 4),       --max_health,
        (select health from mmo.classes where id = 4),       --cur_health,
        1000,                                                --xp_to_next_level,
        0,                                                   --cur_xp,
        '0',                                                 --is_online,
        now(),                                               --created_dt,
        1),

       (4,                                                   --player_id,
        2,                                                   --server_id,
        2,                                                   --fraction_id,
        1,                                                   --race_id,
        3,                                                   --class_id,
        'Human Player',                                        --name,
        (select strength from mmo.classes where id = 3),     --strength,
        (select intelligence from mmo.classes where id = 3), --intelligence,
        (select speed from mmo.classes where id = 3),        --speed,
        (select agility from mmo.classes where id = 3),      --agility,
        (select luck from mmo.classes where id = 3),         --luck,
        (select health from mmo.classes where id = 3),       --max_health,
        (select health from mmo.classes where id = 3),       --cur_health,
        1000,                                                --xp_to_next_level,
        0,                                                   --cur_xp,
        '0',                                                 --is_online,
        now(),                                               --created_dt,
        1),                                                  --level

       (5,                                                   --player_id,
        2,                                                   --server_id,
        2,                                                   --fraction_id,
        5,                                                   --race_id,
        5,                                                   --class_id,
        'Witcher Player',                                        --name,
        (select strength from mmo.classes where id = 5),     --strength,
        (select intelligence from mmo.classes where id = 5), --intelligence,
        (select speed from mmo.classes where id = 5),        --speed,
        (select agility from mmo.classes where id = 5),      --agility,
        (select luck from mmo.classes where id = 5),         --luck,
        (select health from mmo.classes where id = 5),       --max_health,
        (select health from mmo.classes where id = 5),       --cur_health,
        1000,                                                --xp_to_next_level,
        0,                                                   --cur_xp,
        '0',                                                 --is_online,
        now(),                                               --created_dt,
        1),

       (6,                                                   --player_id,
        2,                                                   --server_id,
        2,                                                   --fraction_id,
        2,                                                   --race_id,
        2,                                                   --class_id,
        'Mech Player',                                        --name,
        (select strength from mmo.classes where id = 2),     --strength,
        (select intelligence from mmo.classes where id = 2), --intelligence,
        (select speed from mmo.classes where id = 2),        --speed,
        (select agility from mmo.classes where id = 2),      --agility,
        (select luck from mmo.classes where id = 2),         --luck,
        (select health from mmo.classes where id = 2),       --max_health,
        (select health from mmo.classes where id = 2),       --cur_health,
        1000,                                                --xp_to_next_level,
        0,                                                   --cur_xp,
        '0',                                                 --is_online,
        now(),                                               --created_dt,
        1),

       (7,                                                   --player_id,
        2,                                                   --server_id,
        1,                                                   --fraction_id,
        4,                                                   --race_id,
        4,                                                   --class_id,
        'Cannon Fodder Player',                                        --name,
        (select strength from mmo.classes where id = 4),     --strength,
        (select intelligence from mmo.classes where id = 4), --intelligence,
        (select speed from mmo.classes where id = 4),        --speed,
        (select agility from mmo.classes where id = 4),      --agility,
        (select luck from mmo.classes where id = 4),         --luck,
        (select health from mmo.classes where id = 4),       --max_health,
        (select health from mmo.classes where id = 4),       --cur_health,
        1000,                                                --xp_to_next_level,
        0,                                                   --cur_xp,
        '0',                                                 --is_online,
        now(),                                               --created_dt,
        1),

       (8,                                                   --player_id,
        2,                                                   --server_id,
        1,                                                   --fraction_id,
        3,                                                   --race_id,
        3,                                                   --class_id,
        'Man of Steel Player',                                        --name,
        (select strength from mmo.classes where id = 3),     --strength,
        (select intelligence from mmo.classes where id = 3), --intelligence,
        (select speed from mmo.classes where id = 3),        --speed,
        (select agility from mmo.classes where id = 3),      --agility,
        (select luck from mmo.classes where id = 3),         --luck,
        (select health from mmo.classes where id = 3),       --max_health,
        (select health from mmo.classes where id = 3),       --cur_health,
        1000,                                                --xp_to_next_level,
        0,                                                   --cur_xp,
        '0',                                                 --is_online,
        now(),                                               --created_dt,
        1),                                                  --level

       (9,                                                   --player_id,
        2,                                                   --server_id,
        1,                                                   --fraction_id,
        5,                                                   --race_id,
        1,                                                   --class_id,
        'Super Player',                                        --name,
        (select strength from mmo.classes where id = 1),     --strength,
        (select intelligence from mmo.classes where id = 1), --intelligence,
        (select speed from mmo.classes where id = 1),        --speed,
        (select agility from mmo.classes where id = 1),      --agility,
        (select luck from mmo.classes where id = 1),         --luck,
        (select health from mmo.classes where id = 1),       --max_health,
        (select health from mmo.classes where id = 1),       --cur_health,
        1000,                                                --xp_to_next_level,
        0,                                                   --cur_xp,
        '0',                                                 --is_online,
        now(),                                               --created_dt,
        1),

       (10,                                                   --player_id,
        2,                                                   --server_id,
        1,                                                   --fraction_id,
        2,                                                   --race_id,
        6,                                                   --class_id,
        'Mega Player',                                        --name,
        (select strength from mmo.classes where id = 6),     --strength,
        (select intelligence from mmo.classes where id = 6), --intelligence,
        (select speed from mmo.classes where id = 6),        --speed,
        (select agility from mmo.classes where id = 6),      --agility,
        (select luck from mmo.classes where id = 6),         --luck,
        (select health from mmo.classes where id = 6),       --max_health,
        (select health from mmo.classes where id = 6),       --cur_health,
        1000,                                                --xp_to_next_level,
        0,                                                   --cur_xp,
        '0',                                                 --is_online,
        now(),                                               --created_dt,
        1);

insert into mmo.dificulties (name, min_level)
values
       ('Normal', 1),
       ('Hard', 10),
       ('Imposiible', 15),
       ('Madness', 20);

insert into mmo.dungeons (name, description, is_raid, level_type, match_duration)
values
       ('Hell', null, '0', 1, '30 minutes'),
       ('Blood Bath', null, '1', 6, '45 minutes');

insert into mmo.npcs (name, description, fraction_id, level, is_boss, level_type, health, damage)
values
       ('Mr. Devil Jr.', null, 1, 1, '1', 1, 10000, 100),
       ('Mr. Devil', null, 1, 3, '1', 2, 18899, 178),
       ('Mrs. Devil', null, 1, 5, '1', 3, 23000, 250),
       ('Boss #1', null, 2, 3, '1', 2, 20000, 190),
       ('Boss #2', null, 2, 6, '1', 3, 25000, 277),
       ('Boss #3', null, 2, 9, '1', 4, 30000, 350);

insert into mmo.dungeons_bosses (dungeon_id, boss_id, oreder_num)
values
       (1, 1, 1),
       (1, 2, 2),
       (1, 3, 3),
       (2, 4, 1),
       (2, 5, 2),
       (2, 6, 3);

insert into mmo.dungeons_roles(dungeon_id, role_id, amount)
values
       (1, 1, 2),
       (1, 2, 2),
       (1, 3, 1),
       (2, 1, 1),
       (2, 2, 2),
       (2, 3, 2);

insert into mmo.pvp_maps(name, description)
values
       ('Map #1', null),
       ('Map #2', null);

insert into mmo.pvp_modes (name, flags_to_win, groups_amount, players_in_groups, are_groups_binded_to_fractions, match_duration, kills_to_win)
values
       ('Flags capturing', 3, 2, 5, '1', '10 minutes', null),
       ('Team deathmatch', null, 2, 5, '1', '10 minutes', 50),
       ('Deathmatch', null, 10, 1, '0', '15 minutes', 15);

rollback;