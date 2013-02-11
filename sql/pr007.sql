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

insert into primes (num) select generate_series (2, 104800);

-- This works, but is very slow.
do language plpgsql $$
declare
  base integer := 1;
begin
  raise notice 'Building prime sieve';
  loop
    select min(num) into base from primes where num > base;
    exit when base is null;
    delete from primes where num > base and num % base = 0;
  end loop;
end;
$$;

-- Query the 10001 prime.
select num from primes order by num limit 1 offset 10000;
