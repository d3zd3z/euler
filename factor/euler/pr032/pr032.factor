! Problem 32
!
! 06 December 2002
!
!
! We shall say that an n-digit number is pandigital if it makes
! use of all the digits 1 to n exactly once; for example, the
! 5-digit number, 15234, is 1 through 5 pandigital.
!
! The product 7254 is unusual, as the identity, 39 × 186 = 7254,
! containing multiplicand, multiplier, and product is 1 through
! 9 pandigital.
!
! Find the sum of all products whose
! multiplicand/multiplier/product identity can be written as a 1
! through 9 pandigital.
!
! HINT: Some products can be obtained in more than one way so be
! sure to only include it once in your sum.
!
! 45228

USING:
    io
    kernel
    locals
    math
    math.combinatorics
    math.parser
    math.ranges
    sequences
    sets
    ;
IN: euler.pr032

:: groupings ( valids digits -- )
    digits length :> endof
    1  endof 2 - [a,b] [| i |
        i 1 +  endof 1 -  [a,b] [| j |
            0 i digits subseq  string>number :> a
            i j digits subseq  string>number :> b
            j endof digits subseq string>number :> c
            a b *  c = [
                c valids adjoin
            ] when
        ] each
    ] each ;

: solve032 ( -- n )
    HS{ } clone
    "123456789" <permutations> [
        over swap  groupings
    ] each
    members sum ;
MAIN: solve032
