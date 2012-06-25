      * Problem 4
      *
      * 16 November 2001
      *
      * A palindromic number reads the same both ways. The largest
      * palindrome made from the product of two 2-digit numbers is 9009
      * = 91 x 99.
      *
      * Find the largest palindrome made from the product of two
      * 3-digit numbers.
      *
       identification division.
       program-id. euler-problem-004.

       data division.
       working-storage section.
       01 a             pic 9(6) usage comp-5.
       01 b             pic 9(6) usage comp-5.
       01 c             pic 9(6) usage display.
       01 temp          pic 9(6) usage display.
       01 largest       pic 9(6) usage comp-5 value 0.

       procedure division.

           perform outer-loop
                   varying a from 100 by 1
                   until a > 999

           display largest

           stop run.

       outer-loop.
           move a to b
           perform inner-loop
                   varying b from a by 1
                   until b > 999.

       inner-loop.
           multiply a by b giving c
           call "reverse-digits" using by content c, by reference temp
           if c = temp then
                  perform check-max
           end-if
           add 1 to b.

       check-max.
           if c > largest then move c to largest end-if.

      *----------------------------------------------------------------
      * Reverse the digits of the number
       program-id. reverse-digits.

       data division.
       working-storage section.
       01 offset        pic 9 usage comp-5.

       linkage section.
       01 item          pic 9(6) usage display.
       01 result        pic 9(6) usage display.

       procedure division using item, result.

       main.
           perform varying offset from 1 by 1 until offset > 6
             move item (offset : 1) to result (7 - offset : 1)
           end-perform
           goback.
       end program reverse-digits.

       end program euler-problem-004.
