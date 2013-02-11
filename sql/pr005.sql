-- Problem 5
--
-- 30 November 2001
--
-- 2520 is the smallest number that can be divided by each of the numbers
-- from 1 to 10 without any remainder.
--
-- What is the smallest positive number that is evenly divisible by all of
-- the numbers from 1 to 20?
--
-- 232792560

create schema pr005;

set search_path to pr005;

create function gcd(a integer, b integer) returns integer
  language plpgsql as $body$
declare
  aa integer := a;
  bb integer := b;
  r integer := a % b;
begin
  while r > 0 loop
    a := b;
    b := r;
    r := a % b;
  end loop;
  return b;
end;
$body$;

create function lcm(a integer, b integer) returns integer
  language plpgsql as $body$
begin
  return (a / gcd(a, b)) * b;
end;
$body$;

create function solve() returns integer
  language plpgsql as $body$
declare
  result integer := 1;
begin
  for i in 2 .. 20 loop
    result := lcm(result, i);
  end loop;

  return result;
end;
$body$;

select solve();

set search_path to "$user",public;
drop schema pr005 cascade;
