-- Problem 7
--
-- 28 December 2001
--
-- By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see
-- that the 6th prime is 13.
--
-- What is the 10 001st prime number?
--
-- 104743

drop table if exists primes;

create table primes (num integer not null unique primary key);

insert into primes values (2), (3);

-- Somewhat faster to eliminate as part of a query, rather than all of the multiples.
do language plpgsql $$
declare
  base integer := 3;
  total integer := 2;
  isprime boolean;
begin
  raise notice 'Building prime sieve';
  while total < 10001 loop
    base := base + 2;
    select not exists(select * from primes where base % num = 0) into isprime;
    -- raise notice '% prime? %', base, isprime;
    if isprime then
      insert into primes values (base);
      total := total + 1;
    end if;
  end loop;
end;
$$;

-- select num from primes order by num limit 1 offset 10000;
select max(num) from primes;

drop table primes;
