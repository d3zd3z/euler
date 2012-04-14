! Project Euler
! 2520 is the smallest number that can be divided by each of
! the numbers from 1 to 10 without any remainder.
!
! What is the smallest positive number that is evenly divisible
! by all of the numbers from 1 to 20?

USING: kernel
    math.functions
    math.ranges
    prettyprint
    sequences ;
IN: euler.pr5

: solve ( -- n )
    1 20 [a,b] 1 [ lcm ] reduce ;
: main ( -- ) solve . ;
MAIN: main
