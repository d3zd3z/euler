      * Problem 6
      *
      * 14 December 2001
      *
      * The sum of the squares of the first ten natural numbers is,
      *
      * 1^2 + 2^2 + ... + 10^2 = 385
      *
      * The square of the sum of the first ten natural numbers is,
      *
      * (1 + 2 + ... + 10)^2 = 55^2 = 3025
      *
      * Hence the difference between the sum of the squares of the
      * first ten natural numbers and the square of the sum is 3025 −
      * 385 = 2640.
      *
      * Find the difference between the sum of the squares of the first
      * one hundred natural numbers and the square of the sum.
      *
       identification division.
       program-id. euler-problem-006.

       data division.
       working-storage section.
       01 program-variables.
               05 sum-of-squares    pic 9(9) value 0.
               05 simple-sum        pic 9(9) value 0.
               05 result            pic 9(8).
       01 counters.
               05 i                 pic 999.
               05 i-squared         pic 9(6).

       procedure division.

           perform varying i from 1 by 1 until i > 100
             multiply i by i giving i-squared
             add i-squared to sum-of-squares
             add i to simple-sum
           end-perform

           compute result = (simple-sum * simple-sum) - sum-of-squares
           display result

           stop run.
