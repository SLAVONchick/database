select sum(gc.kills) / sum(gc.deaths) as "k/d"
from mmo.characters c
       join mmo.pvp_groups_characters gc on c.id = gc.character_id
       join mmo.pvp_groups g on gc.pvp_group_id = g.id
       join mmo.pvp_matches m on g.match_id = m.id
    --where c.id = 0
group by c.id;


with sum as (select ch.player_id,
                    sum(coalesce(pgc.kills, 0)) + sum(coalesce(pgc.flags_captured, 0)) + sum(coalesce(egc.kills, 0)) +
                    sum(coalesce(egc.damage_inflicted)) +
                    sum(coalesce(egc.bosses_killed)) -
                    (sum(coalesce(pgc.deaths, 0)) + sum(coalesce(egc.deaths, 0)) +
                     sum(coalesce(egc.damage_gained, 0))) as subtraction_of_sums
             from mmo.characters ch
                    left join mmo.pvp_groups_characters pgc on ch.id = pgc.character_id
                    left join mmo.pve_groups_characters egc on ch.id = egc.character_id
             group by ch.id, ch.player_id),
     sum1 as (select s.player_id, sum(s.subtraction_of_sums) as sum from sum s group by s.player_id limit 3)

select *
from sum1 s
order by s.sum desc;


with avg as (select avg(lt.id) as average, ch.id
             from mmo.characters ch
                    join mmo.characters_equipment cheq on ch.id = cheq.character_id
                    join mmo.equipment eq on cheq.equipment_id = eq.id
                    join mmo.level_types lt on eq.level_type = lt.id
             where cheq.is_equipped = 1 :: bit
             group by ch.id)

select *
from avg a
order by a.average desc
limit 3;


with e_sum as (select c.id, 'e' as pv_type, count(eg.id)
               from mmo.characters c
                      left join mmo.pve_groups_characters egc on c.id = egc.character_id
                      left join mmo.pve_groups eg on egc.pve_group_id = eg.id
                      left join mmo.dungeons d on eg.dungeon_id = d.id
                      left join lateral (select *
                                         from mmo.pve_groups_bosses egb
                                                join mmo.dungeons_bosses db on egb.boss_id = db.boss_id
                                         where egb.pve_group_id = eg.id
                                         order by db.oreder_num desc
                                         limit 1) last_boss on true
               where eg.id is not null
                 and eg.end_dt is not null
               group by c.id),
     p_sum as (select c.id, 'p' as pv_type, count(pg.id)
               from mmo.characters c
                      left join mmo.pvp_groups_characters pgc on c.id = pgc.character_id
                      left join mmo.pvp_groups pg on pgc.pvp_group_id = pg.id
               where pg.id is not null
                 and pg.is_winner is not null
               group by c.id),
     total_sum as (select e.id, sum(coalesce(e.count, 0)) + sum(coalesce(p.count, 0)) as sum
                   from e_sum e
                          left join p_sum p on e.id = p.id
                   group by e.id)

select *
from total_sum s
order by total_sum.sum desc
limit 3;


with e_sum as (select p.country_id, 'e' as pv_type, count(eg.id)
               from mmo.characters c
                      join mmo.players p on c.player_id = p.id
                      left join mmo.pve_groups_characters egc on c.id = egc.character_id
                      left join mmo.pve_groups eg on egc.pve_group_id = eg.id
                      left join mmo.dungeons d on eg.dungeon_id = d.id
                      left join lateral (select *
                                         from mmo.pve_groups_bosses egb
                                                join mmo.dungeons_bosses db on egb.boss_id = db.boss_id
                                         where egb.pve_group_id = eg.id
                                         order by db.oreder_num desc
                                         limit 1) last_boss on true
               where eg.id is not null
               group by p.country_id),
     p_sum as (select p.country_id, 'p' as pv_type, count(pg.id)
               from mmo.characters c
                      join mmo.players p on c.player_id = p.id
                      left join mmo.pvp_groups_characters pgc on c.id = pgc.character_id
                      left join mmo.pvp_groups pg on pgc.pvp_group_id = pg.id
               where pg.id is not null
               group by p.country_id),
     total_sum as (select e.country_id, sum(coalesce(e.count, 0)) as sum_e, sum(coalesce(p.count, 0)) as sum_p
                   from e_sum e
                          left join p_sum p on e.country_id = p.country_id
                   group by e.country_id)

select c.name, s.sum_e, s.sum_p
from total_sum s
join mmo.countries c on s.country_id = c.id
order by country_id