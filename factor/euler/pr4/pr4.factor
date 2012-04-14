! Project euler
! A palindromic number reads the same both ways. The largest
! palindrome made from the product of two 2-digit numbers is
! 9009 = 91 × 99.
!
! Find the largest palindrome made from the product of two
! 3-digit numbers.

USING: kernel
    locals
    math
    math.order
    math.parser
    math.ranges
    prettyprint
    sequences
    vectors
    ;
IN: euler.pr4

: palindrome? ( n -- ? )
    number>string  dup reverse = ;

: solve ( -- x )
    -1
    1 999 [a,b] [| a |
        1 999 [a,b] [
            a *  dup palindrome? [ max ] [ drop ] if
        ] each
    ] each ;
: main ( -- ) solve . ;
MAIN: main
