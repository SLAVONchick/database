create or replace function mmo.automatch_players(player_id bigint)
  returns int as $$
declare r record;
        r_id int;
begin
 if exists(select *
            from mmo.characters ch
                   join mmo.pve_groups_characters grch on grch.character_id = ch.id
                   join mmo.pve_groups gr on gr.id = grch.pve_group_id
            where ch.id = automatch_players.player_id
              and is_online = 1::bit
              and gr.end_dt is null)
  then
   for r in
        select pve_group_id, dr.role_id, dr.amount
          from mmo.characters ch
          join mmo.pve_groups_characters grch on grch.character_id = ch.id
          join mmo.pve_groups gr on gr.id = grch.pve_group_id
          join mmo.dungeons d on gr.dungeon_id = d.id
          join mmo.dungeons_roles dr on d.id = dr.dungeon_id
        where ch.id = automatch_players.player_id
        order by dr.role_id
    loop
     r_id := r.role_id;
      insert into mmo.pve_groups_characters (pve_group_id, character_id, kills, deaths, damage_inflicted, damage_gained, bosses_killed)
      select r.pve_group_id, ch.id, 0, 0, 0, 0, 0
      from mmo.characters ch
      join mmo.roles_classes rc on ch.class_id = rc.class_id
      where rc.role_id = r_id
      and (not exists (select 1 from mmo.pve_groups_characters grch
                       where grch.character_id = ch.id))
      and ch.id != automatch_players.player_id
      limit (select dr.amount from mmo.dungeons_roles dr
             where dr.role_id = r_id
             and dr.dungeon_id = (select d.id from mmo.characters ch
                        join mmo.pve_groups_characters grch on ch.id = grch.character_id
                        join mmo.pve_groups gr on grch.pve_group_id = gr.id
                        join mmo.dungeons d on gr.dungeon_id = d.id
                        where ch.id = automatch_players.player_id));
   end loop;
   return 0;
 end if;
end;
$$
language plpgsql