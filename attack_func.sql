create or replace function attack
  (in attacking_character_id bigint,
   in target_character_id    bigint = null,
   in target_boss_id         int = null
  )
  returns int as $$
begin
  if target_character_id is null and target_boss_id is null
  then
    return 0;
  else
    if exists(select * from mmo.characters where id = target_character_id
                                             and is_online = 1
                                             and cur_health > 0)
       and exists(select *
                  from mmo.pvp_groups_characters grch
                         join mmo.pvp_groups gr on gr.id = grch.pvp_group_id
                         join mmo.pvp_matches m on gr.match_id = m.id
                  where grch.character_id = attacking_character_id
                    and exists(select *
                               from pvp_groups_characters igrch
                                      join mmo.pvp_groups igr on igr.id = igrch.pvp_group_id
                                      join mmo.pvp_matches im on im.id = igr.match_id
                               where im.id = m.id
                                 and igrch.character_id = target_character_id)
                    and m.end_dt is null)
    then
      -- decrease target character hp
      update mmo.characters
      set cur_health = case
                         when cur_health - mmo.get_damage(attacking_character_id) < 0 then 0
                         else cur_health - mmo.get_damage(attacking_character_id) end
      where id = target_character_id;
      if (select cur_health from mmo.characters where id = target_character_id) <= 0
      -- if target dies set statistics.
      -- increase kills for attacking character
      then
        ;
        with pgr as (select pvp_group_id
                     from mmo.pvp_groups gr
                            join mmo.pvp_groups_characters grch on grch.pvp_group_id = gr.id
                            join mmo.pvp_matches m on m.id = gr.match_id
                     where grch.character_id = attacking_character_id
                       and m.end_dt is null)
        update mmo.pvp_groups_characters
        set kills = kills + 1
        where character_id = attacking_character_id
          and pvp_group_id = pgr.pvp_group_id;
        -- and increase deaths for target.
        ;
        with pgr as (select pvp_group_id
                     from mmo.pvp_groups gr
                            join mmo.pvp_groups_characters grch on grch.pvp_group_id = gr.id
                            join mmo.pvp_matches m on m.id = gr.match_id
                     where grch.character_id = target_character_id
                       and m.end_dt is null)
        update mmo.pvp_groups_characters
        set deaths = deaths + 1
        where character_id = target_character_id
          and pvp_group_id = pgr.pvp_group_id;
      end if;

      return 1;
      -- if char attacks boss
    else if exists(select * from mmo.pve_groups_bosses where boss_id = target_boss_id)
            and exists(select *
                       from mmo.pve_groups gr
                              join mmo.pve_groups_characters grch on grch.pve_group_id = gr.id
                       where gr.end_dt is null
                         and grch.character_id = attacking_character_id)
    then
      --decrease boss's hp
      ;
      with pgrb as (select gr.id
                    from mmo.pve_groups gr
                           join mmo.pve_groups_characters grch on grch.pve_group_id = gr.id
                    where grch.character_id = attacking_character_id)
      update mmo.pve_groups_bosses
      set health = case
                     when health - get_damage(attacking_character_id) <= 0 then 0
                     else health - get_damage(attacking_character_id) end
      where pve_group_id = pgrb.id;
      -- if boss is dead
      if ((select health
           from mmo.pve_groups_bosses
           where pve_group_id = (select id
                                 from mmo.pve_groups gr
                                        join mmo.pve_groups_characters grch on grch.pve_group_id = gr.id
                                 where character_id = attacking_character_id)) <= 0)
      then
        -- insert into mmo.pve_groups_bosses next boss
        ;with raw as (insert into mmo.pve_groups_bosses (pve_group_id, boss_id, health)
        select gr.id, b.id, b.health
        from mmo.pve_groups gr
               join mmo.dungeons_bosses db on db.dungeon_id = gr.dungeon_id
               join mmo.npcs b on b.id = db.boss_id
               join mmo.pve_groups_characters grch on grch.pve_group_id = gr.id
        where grch.character_id = attacking_character_id
          and b.is_boss = cast(1 as bit)
          and db.oreder_num = (select _db.oreder_num
                               from mmo.dungeons_bosses _db
                               where _db.dungeon_id = db.dungeon_id
                                 and _db.boss_id = b.id) + 1
        order by db.oreder_num desc
        limit 1
        returning 1)
      ,raw2 as (select id
                                 from mmo.pve_groups gr
                                        join mmo.pve_groups_characters grch on grch.pve_group_id = gr.id
                                 where character_id = attacking_character_id)
      update mmo.pve_groups set end_dt = now()
        where count(raw.*) = 1
        and raw2.id = id;
      end if;
    end if;
    end if;
  end if;
end;
$$
language PLpgSQL;



