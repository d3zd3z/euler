      * Problem 16
      *
      * 03 May 2002
      *
      * 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 =
      * 26.
      *
      * What is the sum of the digits of the number 2^1000?
      *
      * 1366
       identification division.
       program-id. euler-problem-016.

       data division.
       working-storage section.
      * To solve this, store the number as a series of digits, in
      * "little-endian" format, with enough space for overflow, we'll
      * then collect the result with the last digit of each number.

       01 working-values.
           78 digits-needed value is 302.
         02 summation occurs digits-needed times
                                        pic 999 comp-5.
         02 i                           pic 999 comp-5.
         02 carry                       pic 999 comp-5.
         02 temp                        pic 999 comp-5.
         02 final-result                pic 9999 comp-5.

       procedure division.

       main.
           perform initialize-values
           perform double-value 1000 times
           perform add-up-digits
           display final-result
           stop run.

       initialize-values.
           perform varying i from 2 by 1 until i > digits-needed
             move zero to summation (i)
           end-perform
           move 1 to summation (1).

       double-value.
           move zero to carry
           perform varying i from 1 by 1 until i > digits-needed
             compute temp = summation (i) * 2 + carry
             divide temp by 10 giving carry remainder summation (i)
           end-perform

           if carry is not equal to zero
             display "Overflow: " carry
             stop run
           end-if.

       add-up-digits.
           move zero to final-result
           perform varying i from 1 by 1 until i > digits-needed
             add summation (i) to final-result
           end-perform.
