create or replace function insert_equipment()
  returns trigger as $$
  begin
    if (exists (select 1 from mmo.characters_equipment ce
                where ce.character_id = new.character_id
                and ce.equipment_id = new.character_id))
      then
        update mmo.characters_equipment set amount = amount + new.amount
        where character_id = new.character_id
        and equipment_id = new.equipment_id;
      return;
      else
        with cte as (select eqt.can_be_equipped, count(eq.equipment_type) as count from mmo.characters_equipment ce
            join mmo.equipment eq on ce.equipment_id = eq.id
            join mmo.equipment_types eqt on eq.equipment_type = eqt.id
            where character_id = new.character_id and equipment_id = new.equipment_id
            group by eqt.can_be_equipped)
      insert into mmo.characters_equipment (character_id, equipment_id, is_equipped, amount)
      values (new.character_id, new.equipment_id, case when cte.count = 0 or cte.can_be_equipped = '0'
                                                            then '0'
                                                       when cte.count > 0 and cte.can_be_equipped = '1'
                                                            then '1' end,
              new.amount);
      return;
    end if;
  end;
$$ language plpgsql;


create trigger insert_equipment before insert on mmo.characters_equipment
  execute procedure insert_equipment();