      * Problem 1
      *
      * 05 October 2001
      *
      * If we list all the natural numbers below 10 that are multiples
      * of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is
      * 23.
      *
      * Find the sum of all the multiples of 3 or 5 below 1000.
      *
       identification division.
       program-id. euler-problem-001.

       data division.
       working-storage section.
       01 counter               pic 9999   value 1.
       01 total                 pic 999999 value 0.

       procedure division.
           perform varying counter from 1 by 1
                           until counter = 1000
                   if (function mod (counter, 3) = 0)
                           or (function mod (counter, 5) = 0)
                   then
                           add counter to total
                   end-if
           end-perform
           display total

           stop run.
