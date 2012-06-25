      * The procedure section of the prime sieve.
       compute-primes.
           move 'N' to primes (1)
           move function sqrt (max-prime-number) to sieve-limit
           move 2 to p
           perform mark-prime
           perform mark-prime
             varying p from 3 by 2 until p > sieve-limit.

       mark-prime.
           if primes (p) = 'Y' then
             compute tmp = p + p
             perform varying q from tmp by p until q > max-prime-number
               move 'N' to primes (q)
             end-perform
           end-if.
