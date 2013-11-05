      * Problem 21
      *
      * 05 July 2002
      *
      *
      * Let d(n) be defined as the sum of proper divisors of n (numbers
      * less than n which divide evenly into n).
      * If d(a) = b and d(b) = a, where a ≠ b, then a and b are an
      * amicable pair and each of a and b are called amicable numbers.
      *
      * For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11,
      * 20, 22, 44, 55 and 110; therefore d(220) = 284. The proper
      * divisors of 284 are 1, 2, 4, 71 and 142; so d(284) = 220.
      *
      * Evaluate the sum of all the amicable numbers under 10000.
      *
      * 31626
      *
       identification division.
       program-id. euler-problem-021.

       data division.
       working-storage section.

      * There is a bit of trickery here to easily do this with the
      * relatively simplistic data types available to us.  All we care
      * about is the divisor sum, so just store that.

       01 work-size constant as 9999.
       01 divisor-working-storage.
         02 divisor-sum       pic 9(6) comp-5
           occurs work-size times
           value 0.
         02 current           pic 9(6) comp-5.
         02 temp              pic 9(6) comp-5.

       01 result-compuation.
         02 amicable-sum      pic 9(6) comp-5
           value 0.
         02 work-number       pic 9(6) comp-5.
         02 other-number      pic 9(6) comp-5.
         02 pretty-number     pic z(5)9.

       procedure division.
       main-program.
           perform compute-divisors.
           perform find-amicable-pairs.
           move amicable-sum to pretty-number.
           display pretty-number.
           stop run.

       find-amicable-pairs.

           perform varying work-number from 1 by 1
             until work-number > work-size

             move divisor-sum (work-number) to other-number
             if work-number is not equal to other-number and
                 other-number is less than or equal to work-size and
                 other-number is greater or equal to 1 and
                 divisor-sum (other-number) is equal to work-number
             then
      D        move work-number to pretty-number
      D        display pretty-number, ' ', other-number
               add work-number to amicable-sum
             end-if

           end-perform.

       compute-divisors.

           perform each-number varying current from 1 by 1
             until current > work-size.

      * Show them.
      D    perform varying current from 1 by 1 until
      D      current > 221
      D      display current, ' ', divisor-sum (current)
      D    end-perform.

       each-number.

           perform varying temp from current by current
             until temp > work-size

             add current to divisor-sum (temp)
           end-perform.

      * Subtract off the current number, since these are "proper"
      * divisor sums.
           subtract current from divisor-sum (current).

       end program euler-problem-021.
