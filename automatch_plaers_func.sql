create or replace function automatch_players(player_id bigint)
  returns int as $$
begin
  if exists(select *
            from mmo.characters ch
                   join mmo.pve_groups_characters grch on grch.character_id = ch.id
                   join mmo.pve_groups gr on gr.id = grch.pve_group_id
            where ch.id = player_id
              and is_online = 1
              and gr.end_dt is null)
  then
    with raw as (select grch.pve_group_id, ch.server_id
                 from mmo.characters ch
                        join mmo.pve_groups_characters grch on ch.id = grch.character_id
                 where ch.id = player_id),
         raw2 as (select sum(dr.amount) as sum
                  from mmo.characters ch
                         join mmo.pve_groups_characters grch on grch.character_id = ch.id
                         join mmo.pve_groups gr on gr.id = grch.pve_group_id
                         join mmo.dungeons d on gr.dungeon_id = d.id
                         join mmo.dungeons_roles dr on d.id = dr.dungeon_id
                  group by dr.dungeon_id),
         raw3 as (select id
                  from mmo.characters
                  offset floor(random() * (select count(*) from mmo.characters))
                  limit (select sum from raw2))

    insert into mmo.pve_groups_characters (pve_group_id,
                                           character_id,
                                           kills,
                                           deaths,
                                           damage_inflicted,
                                           damage_gained,
                                           bosses_killed)
    select gr.id, ch.id, 0, 0, 0, 0, 0
    from mmo.characters ch
           join raw3 r3 on r3.id = ch.id
           join raw r on r.server_id = ch.server_id
           join mmo.pve_groups_characters grch on grch.character_id = ch.id
           join mmo.pve_groups gr on gr.id = grch.pve_group_id;


    return 0;
  else
    return 1;
  end if;
end;
$$
language plpgsql
