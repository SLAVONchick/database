CREATE OR REPLACE FUNCTION damage_gained() RETURNS trigger AS $damage_gained$
    BEGIN
        IF exists (select * from pve_groups_characters where character_id = new.id)
          or exists (select * from pvp_groups_characters where character_id = new.id)
          then
          begin
            if (select c.cur_health from characters as c
                join pve_groups_characters as pgc on pgc.character_id = c.id
                where c.id = new.id and pgc.end_dt is null
                limit 1) > new.cur_health then
              update pve_groups_characters set damage_gained = damage_gained +
                                                             ((select cur_health from characters where id = new.id) - new.cur_health);
            end if;
            if new.cur_health = 0 then
              update pve_groups_characters set deaths = deaths + 1
              where character_id = new.id
              and end_dt is null;
              update pvp_groups_characters set deaths = deaths + 1
              where character_id = new.id
              and end_dt is null;
            end if;
          end;
        end if;
    END;
$damage_gained$ LANGUAGE plpgsql;

create trigger damage_gained before update of cur_health on characters
  execute procedure damage_gained();
