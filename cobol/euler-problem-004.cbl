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
       01 c             pic 9(6) usage comp-5.
       01 temp          pic 9(6) usage comp-5.
      *01 alt           pic 9(6) usage comp-5.
       01 largest       pic 9(6) usage comp-5 value 0.

       procedure division.

           move 100 to a
           perform outer-loop until a > 999

           display largest

           stop run.

       outer-loop.
           move a to b
           perform inner-loop until b > 999
           add 1 to a.

       inner-loop.
           multiply a by b giving c
           call "reverse-digits" using by content c, by reference temp
      *    perform faster-reverse
           if c = temp then
                  perform check-max
           end-if
           add 1 to b.

       check-max.
           if c > largest then move c to largest end-if.

      *faster-reverse.
      *    move c to alt
      *    move 0 to temp
      *    perform until alt = 0
      *            compute temp = temp * 10 + function mod (alt, 10)
      *            divide alt by 10 giving alt
      *    end-perform.

       program-id. reverse-digits.

       data division.
       working-storage section.

       linkage section.
       01 item          pic 9(6) usage comp-5.
       01 result        pic 9(6) usage comp-5.

       procedure division
           using item, result.

           move 0 to result
           perform until item = 0
                   compute result = result * 10 +
                           function mod (item, 10)
                   divide item by 10 giving item
           end-perform
           exit program.

       end program reverse-digits.
