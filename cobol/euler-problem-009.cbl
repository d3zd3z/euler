      * Problem 9
      *
      * 25 January 2002
      *
      * A Pythagorean triplet is a set of three natural numbers, a < b
      * < c, for which,
      *
      * a^2 + b^2 = c^2
      *
      * For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.
      *
      * There exists exactly one Pythagorean triplet for which a + b +
      * c = 1000.
      * Find the product abc.
      *
      * 31875000
       identification division.
       program-id. euler-problem-009.

       data division.
       working-storage section.
       01 loop-variables.
         02 a                   pic 9(4) usage comp-5.
         02 b                   pic 9(4) usage comp-5.
         02 c                   pic 9(4) usage comp-5.
       01 result-value.
         02 product             pic 9(8) usage comp-5.

       procedure division.

       main.
           perform varying a from 1 by 1 until a > 998
             perform varying b from a by 1 until b > 999
               compute c = 1000 - a - b
               if (a * a + b * b = c * c) then
                 compute product = a * b * c
                 display product
               end-if
             end-perform
           end-perform

           stop run.
