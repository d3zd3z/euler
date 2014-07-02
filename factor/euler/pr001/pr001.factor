! Problem 1
!
! 05 October 2001
!
!
! If we list all the natural numbers below 10 that are multiples of 3 or 5,
! we get 3, 5, 6 and 9. The sum of these multiples is 23.
!
! Find the sum of all the multiples of 3 or 5 below 1000.
!
! 233168

USING: kernel io math
    combinators.short-circuit
    prettyprint
    sequences
    math.ranges ;
IN: euler.pr001

: divides? ( n m -- ? )
    rem zero? ;

: div-3-or-5?  ( n -- ? )
    { [ 3 divides? ] [ 5 divides? ] } 1|| ;

: solve001 ( -- n )
    1 1000 [a,b)
    [ div-3-or-5? ] filter
    sum ;
MAIN: solve001
