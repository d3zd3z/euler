      * Problem 20
      *
      * 21 June 2002
      *
      * n! means n x (n − 1) x ... x 3 x 2 x 1
      *
      * For example, 10! = 10 x 9 x ... x 3 x 2 x 1 = 3628800,
      * and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 +
      * 8 + 0 + 0 = 27.
      *
      * Find the sum of the digits in the number 100!
      *
      * 648
       identification division.
       program-id. euler-problem-020.

       data division.
       working-storage section.

      * Represent the intermediate result in base 10000.
       01 working-values.
         02 accumulator  occurs 40 times        pic 9(4) comp-5.
         02 temp                                pic 9(6) comp-5.
         02 carry                               pic 9(6) comp-5.
         02 multiplicand                        pic 999  comp-5.
         02 i                                   pic 999  comp-5.
       01 digit-summing-values.
         02 digit-value                         pic 9(4) display.
         02 individual-digit redefines digit-value
           occurs 4 times                       pic 9    display.
         02 j                                   pic 999  comp-5.
         02 result                              pic 999  comp-5.

       procedure division.

       main.
           perform initialize-accumulator

           perform multiply-accumulator
             varying multiplicand from 2 by 1
             until multiplicand > 100

           perform sum-up-digits

           display result
           stop run.

       initialize-accumulator.
           perform varying i from 1 by 1 until i > 40
             move zero to accumulator (i)
           end-perform

           move 1 to accumulator (1).

       multiply-accumulator.
           move zero to carry
           perform varying i from 1 by 1 until i > 40
             compute temp = accumulator (i) * multiplicand + carry
             divide temp by 10000 giving carry
               remainder accumulator (i)
           end-perform

           if carry not equal zero
             display "Overflow"
             stop run
           end-if.

       sum-up-digits.
           move zero to result.

           perform varying i from 1 by 1 until i > 40
             move accumulator (i) to digit-value

             perform varying j from 1 by 1 until j > 4
               add individual-digit (j) to result
             end-perform
           end-perform.

       end program euler-problem-020.
