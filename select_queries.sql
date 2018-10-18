select sum(gc.kills) / sum(gc.deaths) as "k/d"
from mmo.characters c
       join mmo.pvp_groups_characters gc on c.id = gc.character_id
       join mmo.pvp_groups g on gc.pvp_group_id = g.id
       join mmo.pvp_matches m on g.match_id = m.id
    --where c.id = 0
group by m.id, c.id;


with sum as (select ch.player_id,
                    sum(pgc.kills) + sum(pgc.flags_captured) + sum(egc.kills) + sum(egc.damage_inflicted) +
                    sum(egc.bosses_killed) -
                    (sum(pgc.deaths) + sum(egc.deaths) + sum(egc.damage_gained)) as subtraction_of_sums
             from mmo.characters ch
                    left join mmo.pvp_groups_characters pgc on ch.id = pgc.character_id
                    left join mmo.pve_groups_characters egc on ch.id = egc.character_id
             group by ch.id, ch.player_id)
select s.player_id, sum(s.subtraction_of_sums)
from sum s
group by s.player_id
limit 3;


with avg as (select avg(lt.id) as average, ch.id
from mmo.characters ch
join mmo.characters_equipment cheq on ch.id = cheq.character_id
join mmo.equipment eq on cheq.equipment_id = eq.id
join mmo.level_types lt on eq.level_type = lt.id
where cheq.is_equipped = 1::bit
group by ch.id)

select *
from avg a
order by a.average
limit 3