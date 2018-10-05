create or replace function use_skill(using_player_id bigint,
                                     target_player_id bigint,
                                     target_boss_id int,
                                     skill_id int)
  returns int as $$
begin
  if (not exists(select 1 from mmo.classes c
                join mmo.skills s on c.id = s.class_id
                join mmo.characters ch on c.id = ch.class_id
                where s.id = skill_id
                and ch.id = using_player_id)
      or (target_player_id is null and target_boss_id is null)
      or (target_player_id is not null and target_boss_id is not null))
    then
    return 1;
  end if;
    if (target_player_id is not null)
      then
    with cte as (select ch.id as ch_id, s.id as s_id, s.duration, s.practical_stats, s.skill_type, (s.practical_stats - sum(e.practical_stats)) as total from mmo.characters ch
                 left join mmo.characters_equipment che on ch.id = che.character_id
                 left join mmo.equipment e on che.equipment_id = e.id
                 left join mmo.skill_types st on e.skill_type = st.id
                 join mmo.classes c on ch.class_id = c.id
                 left join mmo.skills s on s.class_id = c.id
                 where ch.id = using_player_id
                 and s.id = skill_id
                 and (e.equipment_type != 1 and e.equipment_type != 2 or e.equipment_type is null)
                 and s.for_enemy = '1'::bit
                 and s.is_passive = '0'::bit
                 and s.self = case when 2 = 3 then '1'::bit
                                   else '0'::bit end
                 group by s.practical_stats, s.duration, ch.id, s.skill_type, s.id)
    update mmo.characters set cur_health =  case
                                                  when cte.skill_type != 3
                                                  then cur_health - cte.total * extract(epoch from cte.duration)
                                                  else cur_health + practical_stats
                                            end
        from cte
        where id = target_player_id and id = cte.ch_id;
      return 0;
    else
      update mmo.pve_groups_bosses as pgb set health = health - practical_stats
      from mmo.pve_groups pg
      join mmo.pve_groups_characters pgc on pg.id = pgc.pve_group_id
      join mmo.characters c on pgc.character_id = c.id
      join mmo.skills s on c.class_id = s.class_id
      where pg.id = pgb.pve_group_id
      and c.id = using_player_id
      and pgb.boss_id = target_boss_id
      and s.for_enemy = '1'
      and s.self = '0'
      and s.is_passive = '0'
      and s.id = skill_id
      and s.skill_type != 3;

    end if;

end;
$$
language plpgsql