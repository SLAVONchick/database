create or replace function get_damage(in _character_id bigint)
  returns int as $func$
begin
return (select case
                               when sum(eq.practical_stats) = 0 then 1
                               else sum(eq.practical_stats) end
                               * ch.strength as damage
                      from mmo.characters_equipment cheq
                             join mmo.equipment eq on eq.id = cheq.equipment_id
                             join mmo.characters ch on ch.id = cheq.character_id
                      where cheq.character_id = _character_id
                        and (eq.equipment_type = 1 or eq.equipment_type = 2));
  end;
$func$ language PLpgSQL;
