CREATE OR REPLACE FUNCTION damage_gained() RETURNS trigger AS $damage_gained$
    BEGIN
        IF exists (select * from pve_groups_characters where character_id = new.id)
          or exists (select * from pvp_groups_characters where character_id = new.id)
          then
          begin
            if (select cur_health from characters where id = new.id) > new.cur_health then
              update pve_groups_characters set damage_gained = damage_gained +
                                                             ((select cur_health from characters where id = new.id) - new.cur_health);
            end if;
            if new.cur_health = 0 then
              update pve_groups_characters set deaths = deaths + 1;
              update pvp_groups_characters set deaths = deaths + 1;
            end if;
          end;
        end if;
    END;
$damage_gained$ LANGUAGE plpgsql;

create trigger damage_gained before update of cur_health on characters
  execute procedure damage_gained();
