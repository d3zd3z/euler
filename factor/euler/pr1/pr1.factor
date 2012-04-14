! Project Euler
! If we list all the natural numbers below 10 that are
! multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these
! multiples is 23.
!
! Find the sum of all the multiples of 3 or 5 below 1000.


USING: kernel io prettyprint 
    combinators.short-circuit
    math math.ranges sequences ;
IN: euler.pr1

: divides? ( n m -- ? )
    rem zero? ;

: was3or5?  ( n -- ? )
    dup  3 divides?
    swap 5 divides? or ;
: 3or5? ( n -- ? )
    { [ 3 divides? ] [ 5 divides? ] } 1|| ;

: sumup ( n -- m )
    1 swap [a,b)
    [ 3or5? ] filter sum ;

: solve ( -- )
    1000 sumup . ;
MAIN: solve
