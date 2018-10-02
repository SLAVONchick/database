create schema mmo;


create table mmo.server_types (
  id   serial primary key,
  name varchar(64) not null
);

create table mmo.countries (
  id           serial primary key,
  name         varchar(256) unique,
  alpha_2      varchar(2) not NULL,
  alpha_3      varchar(3) not null,
  country_code int        not null,
  region       varchar(64)
);

create table mmo.servers (
  id      serial primary key,
  name    varchar(256) not null,
  type_id int          not null references mmo.server_types (id),
  max_loading smallint not null,
  country_id int not null references mmo.countries (id)
);

create table mmo.players(
  id bigserial PRIMARY KEY,
  email varchar(128) not null,
  nickname varchar(128) not null,
  country_id int not null references mmo.countries(id),
  created_dt timestamp not null
);

create table mmo.fractions(
  id serial primary key,
  name varchar(128) not null,
  descripition text
);

create table mmo.skill_types(
  id serial primary key,
  name varchar(64) not null
);

create table mmo.roles(
  id serial primary key,
  name varchar(128) not null
);

create table mmo.classes(
  id serial primary key,
  name varchar(128) not null,
  description text,
  strength smallint not null,
  intelligence smallint not null,
  speed smallint not null,
  agility smallint not null,
  luck smallint not null,
  health int not null
);

create table mmo.roles_classes(
  role_id int not null references mmo.roles(id),
  class_id int not null references mmo.classes(id)
);

create table mmo.races(
  id serial primary key,
  name varchar(128) not null,
  description text
);

create table mmo.skills(
  id serial primary key,
  name varchar(128) not null,
  practical_stats smallint not null,
  skill_type int references mmo.skill_types(id),
  min_level smallint not null,
  class_id int references mmo.classes(id),
  race_id int references mmo.races(id),
  is_passive bit not null,
  self bit not null,
  for_enemy bit not null,
  is_stubbing bit not null,
  duration interval
);

create table mmo.races_classes_fractions(
  class_id int not null references mmo.classes(id),
  fraction_id int not null references mmo.fractions(id),
  race_id int not null references mmo.races(id)
);

create table mmo.level_types(
  id serial primary key,
  name varchar(128) not null,
  gained_xp_multiplier smallint not null
);

create table mmo.equipment_types(
  id serial primary key,
  name varchar(128) not null,
  can_be_equipped bit not null
);

create table mmo.equipment(
  id bigserial primary key,
  equipment_type int not null references mmo.equipment_types(id),
  practical_stats smallint not null,
  description text,
  equipment_min_level smallint not null,
  level_type int not null references mmo.level_types(id),
  skill_type int not null references mmo.skill_types(id),
  gainable_precentil real not null
);

create table mmo.classes_equipment(
  class_id int not null references mmo.classes(id),
  equipment_id int not null references mmo.equipment(id),
  is_equipped bit not null,
  amount int not null
);

create table mmo.characters(
  id bigserial primary key,
  player_id bigint not null references mmo.players(id),
  server_id int not null references mmo.servers(id),
  fraction_id int not null references mmo.fractions(id),
  race_id int not null references mmo.races(id),
  class_id int not null references mmo.classes(id),
  name varchar(256) not null,
  strength smallint not null,
  intelligence smallint not null,
  speed smallint not null,
  agility smallint not null,
  luck smallint not null,
  max_health int not null,
  cur_health int not null,
  xp_to_next_level bigint not null,
  cur_xp bigint not null,
  is_online bit not null,
  created_dt timestamp not null
);

create table mmo.characters_equipment(
  character_id bigint not null references mmo.characters(id),
  equipment_id bigint not null references mmo.equipment(id),
  is_equipped bit not null,
  amount int not null
);

create table mmo.dificulties(
  id serial primary key,
  name varchar(128) not null,
  min_level smallint not null
);

create table mmo.dungeons(
  id serial primary key,
  name varchar(256) not null,
  description text,
  is_raid bit not null,
  level_type int not null references mmo.level_types(id),
  match_duration interval
);

create table mmo.npcs(
  id serial primary key,
  name varchar(256) not null,
  description text,
  fraction_id int references mmo.fractions(id),
  level smallint not null,
  is_boss bit not null,
  level_type int not null references mmo.level_types(id),
  health int not null,
  damage int not null
);

create table mmo.dungeons_bosses(
  dungeon_id int not null references mmo.dungeons(id),
  boss_id int not null references mmo.npcs(id),
  oreder_num smallint not null
);

create table mmo.dungeons_roles(
  dungeon_id int not null references mmo.dungeons(id),
  role_id int not null references mmo.roles(id),
  amount smallint not null
);

create table mmo.pve_groups(
  id bigserial primary key,
  name varchar(128) not null,
  last_killed_boss_order_num smallint,
  dungeon_id int not null references mmo.dungeons(id),
  start_dt timestamp not null,
  end_dt timestamp,
  dificulty_id int not null references mmo.dificulties(id)
);

create table mmo.pve_groups_characters(
  pve_group_id bigint not null references mmo.pve_groups(id),
  character_id bigint not null references mmo.characters(id),
  kills smallint not null,
  deaths smallint not null,
  damage_inflicted bigint not null,
  damage_gained bigint not null,
  bosses_killed smallint not null
);

create table mmo.pvp_maps(
  id serial primary key,
  name varchar(256) not null,
  description text
);

create table mmo.pvp_modes(
  id serial primary key,
  name varchar(256) not null,
  flags_to_win smallint,
  groups_amount smallint not null,
  players_in_groups smallint not null,
  are_groups_binded_to_fractions bit not null,
  match_duration interval not null,
  kills_to_win smallint
);

create table mmo.pvp_matches(
  id serial primary key,
  name varchar(256) not null,
  mode_id int not null references mmo.pvp_modes(id),
  map_id int not null references mmo.pvp_maps(id),
  start_dt timestamp not null,
  end_dt timestamp
);

create table mmo.pvp_groups(
  id bigserial primary key,
  name varchar(128) not null,
  match_id int not null references mmo.pvp_matches(id),
  is_winner bit not null
);

create table mmo.pvp_groups_characters(
  pvp_group_id bigint not null references mmo.pvp_groups(id),
  character_id bigint not null references mmo.characters(id),
  flags_captured smallint,
  kills smallint not null,
  deaths smallint not null
);


