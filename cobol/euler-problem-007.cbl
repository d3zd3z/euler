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
       01 max-prime-number constant as 110000.
       copy prime-sieve-data.
       01 prime-counter   pic 999999 comp-5 value 0.
       01 num             pic 9(6) comp-5.

       procedure division.

       main.
           perform compute-primes

           move 4 to prime-counter
           perform varying num from 9 by 2 until num > max-prime-number
             if primes (num) = 'Y' then
               add 1 to prime-counter
               if prime-counter = 10001 then
                 display num
                 exit perform
               end-if
             end-if
           end-perform

           stop run.

       copy prime-sieve-procedure.
