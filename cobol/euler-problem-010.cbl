      * Problem 10
      *
      * 08 February 2002
      *
      * The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
      *
      * Find the sum of all the primes below two million.
      *
       identification division.
       program-id. euler-problem-010.

       data division.
       working-storage section.
       01 max-prime-number constant as 1999999.
           copy prime-sieve-data.
       01 offset                pic 9(7) comp-5.
       01 prime-sum             pic 9(12) comp-5 value 0.

       procedure division.

       main.
           perform compute-primes

           perform varying offset from 2 by 1
                   until offset > max-prime-number
             if primes (offset) = 'Y' then
               add offset to prime-sum
             end-if
           end-perform

           display prime-sum
           stop run.

       copy prime-sieve-procedure.
