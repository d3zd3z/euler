-- Problem 4
--
-- 16 November 2001
--
-- A palindromic number reads the same both ways. The largest palindrome made
-- from the product of two 2-digit numbers is 9009 = 91 x 99.
--
-- Find the largest palindrome made from the product of two 3-digit numbers.
--
-- 906609

create or replace function reverse_digits(n integer) returns integer as $$
declare
  temp integer := n;
  result integer := 0;
begin
  while temp > 0 loop
    result := result * 10 + temp % 10;
    temp := temp / 10;
  end loop;
  return result;
end;
$$ language plpgsql;

create or replace function palindrome(n integer) returns boolean as $$
begin
  return n = reverse_digits(n);
end;
$$ language plpgsql;

create or replace function range(a integer, b integer) returns setof integer as $$
begin
  for i in a .. b loop
    return next i;
  end loop;
end;
$$ language plpgsql;

select max(a*b)
  from range(1, 999) as a(a),
       range(1, 999) as b(b)
  where b >= a and
	palindrome(b*a);

drop function reverse_digits(integer);
drop function palindrome(integer);
drop function range(integer, integer);
