      * Problem 14
      *
      * 05 April 2002
      *
      * The following iterative sequence is defined for the set of
      * positive integers:
      *
      * n → n/2 (n is even)
      * n → 3n + 1 (n is odd)
      *
      * Using the rule above and starting with 13, we generate the
      * following sequence:
      *
      * 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
      *
      * It can be seen that this sequence (starting at 13 and finishing
      * at 1) contains 10 terms. Although it has not been proved yet
      * (Collatz Problem), it is thought that all starting numbers
      * finish at 1.
      *
      * Which starting number, under one million, produces the longest
      * chain?
      *
      * NOTE: Once the chain starts the terms are allowed to go above
      * one million.
      *
      * 837799
       identification division.
       program-id. euler-problem-014.

       data division.
       working-storage section.
       01 working-values.
         02 current-number              pic 9(7) comp-5.
         02 work-number                 pic 9(15) comp-5.
         02 chain-length                pic 9(5) comp-5.
         02 largest-chain-length        pic 9(5) comp-5.
         02 largest-chain-value         pic 9(6) comp-5.
       01 temporary-values.
         02 ignored-result              pic 9(13) comp-5.
         02 modulus                     pic 9(13) comp-5.
       01 previous-value-cache.
           78 cache-size value is 1000.
         02 cache-nodes occurs cache-size times.
           03 cache-entry               pic 9(5) comp-5
                value is 0.
         02 cache-hits                  pic 9(15) comp-5
                        value 0.
         02 cache-misses                pic 9(15) comp-5
                        value 0.

       procedure division.

       stuff.
           perform main
           stop run.

       test-main.
           move 159487 to current-number
           perform find-chain-length
           display chain-length
           stop run.

       main.
           perform initialize-data
           perform scan-all-chains
           display largest-chain-value

           display "cache hits:   " cache-hits
           display "cache misses: " cache-misses
           stop run.

       initialize-data.
           move 0 to largest-chain-value
           move 0 to largest-chain-length.

       scan-all-chains.
           perform varying current-number from 1 by 1
                   until current-number > 999999
             perform find-chain-length
             if chain-length > largest-chain-length
               move chain-length to largest-chain-length
               move current-number to largest-chain-value
             end-if

      * This is _very_ slow, so let's print things out as we compute.
      * This takes more than 1 minute, which is beyond the guidlines of
      * project Euler, but it is really the fault of cobc, which has
      * such a poor implementation of some basic arithmetic.
             if function mod (current-number, 10000) = 0
               display current-number " " largest-chain-length
             end-if
           end-perform.

      * Find the length of chain from 'current-number', putting the
      * result in 'chain-length'.  Uses 'work-number' for intermediate
      * work.
       find-chain-length.
           move current-number to work-number
           move 1 to chain-length

           perform until work-number is equal to 1

      * Whenever we hit a value that is in the cache, be done with it.
             if work-number <= cache-size
               if cache-entry (work-number) > 0
                 add cache-entry (work-number), -1 to chain-length
                 add 1 to cache-hits
                 exit paragraph
               end-if
             end-if

             add 1 to cache-misses

      * Bug in cobc, must use divide ... remainder.  function mod often
      * produces the wrong result.
             divide work-number by 2 giving ignored-result
               remainder modulus
             if modulus = zero
               divide 2 into work-number
             else
               compute work-number = work-number * 3 + 1
             end-if

             add 1 to chain-length
           end-perform

      * This only stores the end entry in the cache, but it still should
      * help, and avoids having to use recursion to remember all of the
      * old values.

           if current-number <= cache-size
             move chain-length to cache-entry (current-number)
           end-if.

       end program euler-problem-014.
