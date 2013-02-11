-- Problem 3
--
-- 02 November 2001
--
-- The prime factors of 13195 are 5, 7, 13 and 29.
--
-- What is the largest prime factor of the number 600851475143 ?
--
-- 6857

create or replace function solve() returns integer as $$
declare
  base bigint := 600851475143;
  factor integer := 2;
begin
  while base != 1 loop
    if base % factor = 0 then
      base := base / factor;
    else
      if factor = 2 then
        factor := 3;
      else
        factor := factor + 2;
      end if;
    end if;
  end loop;
  return factor;
end;
$$ language plpgsql;

select * from solve();

drop function solve();
