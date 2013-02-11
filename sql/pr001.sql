-- Problem 1
--
-- 05 October 2001
--
-- If we list all the natural numbers below 10 that are multiples of 3 or 5,
-- we get 3, 5, 6 and 9. The sum of these multiples is 23.
--
-- Find the sum of all the multiples of 3 or 5 below 1000.
--
-- 233168

create table numbers (
       number integer
);

create or replace function mknumbers() returns setof integer as $$
begin
  for i in 1 .. 999 loop
    return next i;
  end loop;
end;
$$ language plpgsql;

select sum(mknumbers) from mknumbers()
       where mknumbers % 3 = 0 OR mknumbers % 5 = 0;

drop function mknumbers();

with recursive t(n) as (
     values (1)
     union all
     select n+1 from t where n+1 < 1000
)
insert into numbers select * from t;

select sum(number) from numbers
       where number % 3 = 0 OR number % 5 = 0;

drop table numbers;
