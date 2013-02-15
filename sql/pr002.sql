-- Problem 2
--
-- 19 October 2001
--
-- Each new term in the Fibonacci sequence is generated by adding the
-- previous two terms. By starting with 1 and 2, the first 10 terms will be:
--
-- 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...
--
-- By considering the terms in the Fibonacci sequence whose values do not
-- exceed four million, find the sum of the even-valued terms.
--
-- 4613732

create or replace function fibs(top integer) returns setof integer as $$
declare
  a integer := 1;
  b integer := 1;
  temp integer;
begin
  while b < top loop
    return next b;
    temp := a + b;
    a := b;
    b := temp;
  end loop;
end;
$$ language plpgsql;

select sum(fib) from fibs(4000000) as fibs (fib) where fib % 2 = 0;

drop function fibs(top integer);