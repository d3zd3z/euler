! Problem 17
!
! 17 May 2002
!
!
! If the numbers 1 to 5 are written out in words: one, two,
! three, four, five, then there are 3 + 3 + 5 + 4 + 4 = 19
! letters used in total.
!
! If all the numbers from 1 to 1000 (one thousand) inclusive
! were written out in words, how many letters would be used?
!
!
! NOTE: Do not count spaces or hyphens. For example, 342 (three
! hundred and forty-two) contains 23 letters and 115 (one
! hundred and fifteen) contains 20 letters. The use of "and"
! when writing out numbers is in compliance with British usage.
!
! 21124

USING:
    combinators
    io
    io.streams.string
    kernel
    math
    math.ranges
    sequences
    unicode.categories
    ;
IN: euler.pr017

CONSTANT: ones-names {
    "one" "two" "three" "four" "five" "six" "seven" "eight"
    "nine" "ten" "eleven" "twelve" "thirteen" "fourteen"
    "fifteen" "sixteen" "seventeen" "eighteen" "nineteen" }

: ones. ( n -- )
    1 -  ones-names nth  write ;

CONSTANT: tens-names {
    "twenty" "thirty" "forty" "fifty" "sixty" "seventy" "eighty"
    "ninety" }

: tens. ( n -- )
    2 -  tens-names nth  write ;

ERROR: invalid-spoken number message ;

! Print the spoken representation of 'n'.
: spoken. ( n -- )
    {
        { [ dup 1000 = ] [ drop "one thousand" write ] }
        { [ dup 0 <= ] [ "non-positive" invalid-spoken ] }
        { [ dup 20 < ] [ ones. ] }
        { [ dup [ 100 < ] [ 10 mod zero? ] bi and ]
            [ 10 /i  tens. ] }
        { [ dup 100 < ]
            [ 10 /mod swap tens.
                "-" write
                ones. ] }
        { [ dup [ 1000 < ] [ 100 mod zero? ] bi and ]
            [ 100 /i spoken.  " hundred" write ] }
        { [ dup 1000 < ]
            [ 100 /mod swap  spoken.
                " hundred and " write
                spoken. ] }
        [ "Overly large number" invalid-spoken ]
    } cond ;

: spoken ( n -- text )
    [ spoken. ] with-string-writer ;

: letter-count ( text -- n )
    [ Letter? ] count ;

: solve017 ( -- n )
    0
    1 1000 [a,b] [
        spoken letter-count +
    ] each ;
MAIN: solve017
