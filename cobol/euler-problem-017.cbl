      * Problem 17
      *
      * 17 May 2002
      *
      * If the numbers 1 to 5 are written out in words: one, two,
      * three, four, five, then there are 3 + 3 + 5 + 4 + 4 = 19
      * letters used in total.
      *
      * If all the numbers from 1 to 1000 (one thousand) inclusive were
      * written out in words, how many letters would be used?
      *
      *
      * NOTE: Do not count spaces or hyphens. For example, 342 (three
      * hundred and forty-two) contains 23 letters and 115 (one hundred
      * and fifteen) contains 20 letters. The use of "and" when writing
      * out numbers is in compliance with British usage.
      *
      * 21124
       identification division.
       program-id. euler-problem-017.

       environment division.
       configuration section.
       repository.
           function length, trim intrinsic.

       data division.
       working-storage section.
       01 numeric-strings.
         02 ones-raw                    pic x(171) value
           "one      " &
           "two      " &
           "three    " &
           "four     " &
           "five     " &
           "six      " &
           "seven    " &
           "eight    " &
           "nine     " &
           "ten      " &
           "eleven   " &
           "twelve   " &
           "thirteen " &
           "fourteen " &
           "fifteen  " &
           "sixteen  " &
           "seventeen" &
           "eighteen " &
           "nineteen ".
         02 ones                redefines ones-raw
           occurs 19 times              pic x(9).

         02 tens-raw                    pic x(63) value
           "ten    " &
           "twenty " &
           "thirty " &
           "forty  " &
           "fifty  " &
           "sixty  " &
           "seventy" &
           "eighty " &
           "ninety ".
         02 tens                redefines tens-raw
           occurs 9 times               pic x(7).
       01 working-text.
         02 word-buffer                 pic x(12).
         02 word-length                 pic 999 comp-5.
         02 work-character              pic x.
         02 text-result                 pic x(35).
         02 text-position               pic 999 comp-5.
         02 i                           pic 999 comp-5.
         02 counter                     pic 9999 comp-5.
       01 numeric-work-values.
         02 work-value                  pic 9999 comp-5.
         02 discarded                   pic 9999 comp-5.
         02 letter-count                pic 99999 comp-5
           value 0.

       procedure division.

       main.
           perform reset-text

           move all '*' to word-buffer

           perform varying counter from 1 by 1 until counter > 1000
             move counter to work-value
             perform generate-english
             perform count-letters
           end-perform

           display letter-count

           stop run.

       reset-text.
           move zero to text-position.

       generate-english.
           move zero to text-position
           move all spaces to text-result.

           if work-value = 1000
             move 'one thousand' to word-buffer
             perform append-word
             exit paragraph
           end-if.

           if work-value >= 100
             move ones (work-value / 100) to word-buffer
             perform append-word

             move 'hundred' to word-buffer
             perform append-word

             divide work-value by 100 giving discarded
               remainder work-value

             if work-value > 0
               move 'and' to word-buffer
               perform append-word
             end-if
           end-if.

           if work-value >= 20 then
             move tens (work-value / 10) to word-buffer
             perform append-word

             divide work-value by 10 giving discarded
               remainder work-value

      * Ugh, why does this do the wrong thing.  Fortunately, it doesn't
      * really matter.  I can't see it being something other than a
      * compiler bug.
      *      if work-value > 0
      *        move '-' to word-buffer (text-position:1)
      *      end-if
           end-if.

           if work-value >= 1 then
             move ones (work-value) to word-buffer
             perform append-word
           end-if.

           subtract 1 from text-position.

      * Append the word in word-buffer to text-result, adjusting
      * text-position appropriately.
       append-word.
           move length (trim (word-buffer))
                 to word-length
           perform varying i from 1 by 1 until i > word-length
             move word-buffer (i:1) to work-character
             perform append-character
           end-perform
           move space to work-character
           perform append-character.

       append-character.
           add 1 to text-position
           move work-character to text-result (text-position:1).

       count-letters.
           perform varying i from 1 by 1 until i > text-position
             evaluate text-result (i:1)
               when 'a' thru 'z'
               when 'A' thru 'Z'
                 add 1 to letter-count
             end-evaluate
           end-perform.

       end program euler-problem-017.
