      * Problem 5
      *
      * 30 November 2001
      *
      *
      * 2520 is the smallest number that can be divided by each of the
      * numbers from 1 to 10 without any remainder.
      *
      * What is the smallest positive number that is evenly divisible
      * by all of the numbers from 1 to 20?
      *
       identification division.
       program-id. euler-problem-005.

       environment division.
       configuration section.
       repository.
           function mod intrinsic.

       data division.
       working-storage section.
       01 a             usage binary-long.
       01 b             usage binary-long.
       01 counter       usage binary-long.
       01 accumulator   usage binary-long.
       01 temp          usage binary-long.

       01 result        pic z(9)9.

       procedure division.

           move 1 to accumulator

           perform loop-body
                   varying counter from 2 by 1
                   until counter > 20

           move accumulator to result
           display result

           stop run.

      * Loop, with counter running through the loop.
       loop-body.
           move accumulator to a
           move counter to b
           perform gcd

           compute accumulator = accumulator / a * counter.

      * Compute a GCD of 'a' and 'b', leaving the result in 'b'.
       gcd.
           perform until b = 0
                   compute temp = mod (a, b)
                   move b to a
                   move temp to b
           end-perform.
