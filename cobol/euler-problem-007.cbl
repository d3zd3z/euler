      * Problem 7
      *
      * 28 December 2001
      *
      * By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13,
      * we can see that the 6th prime is 13.
      *
      * What is the 10 001st prime number?
      *----------------------------------------------------------------
       identification division.
       program-id. euler-problem-007.

       data division.
       working-storage section.
       01 max-number constant as 150000.
       01 prime-map.
         02 primes        pic a
           occurs max-number times
           value 'Y'.
       01 sqrt-value      pic 999999 comp-5.
       01 p               pic 999999 comp-5.
       01 q               pic 999999 comp-5.
       01 tmp             pic 999999 comp-5.
       01 prime-counter   pic 999999 comp-5 value 0.

       procedure division.

           perform compute-primes

           move 4 to prime-counter
           perform varying p from 9 by 2 until p > max-number
             if primes (p) = 'Y' then
               add 1 to prime-counter
               if prime-counter = 10001 then
                 display p
                 exit perform
               end-if
             end-if
           end-perform

           stop run.

       compute-primes.
           move 'N' to primes (1)
           move function sqrt (max-number) to sqrt-value
           move 2 to p
           perform mark-prime
           perform mark-prime
             varying p from 3 by 2 until p > sqrt-value.

       mark-prime.
           if primes (p) = 'Y' then
             compute tmp = p + p
             perform varying q from tmp by p until q > max-number
               move 'N' to primes (q)
             end-perform
           end-if.

