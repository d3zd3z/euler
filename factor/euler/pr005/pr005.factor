! Problem 5
!
! 30 November 2001
!
!
! 2520 is the smallest number that can be divided by each of the numbers
! from 1 to 10 without any remainder.
!
! What is the smallest positive number that is evenly divisible by all of
! the numbers from 1 to 20?
!
! 232792560

USING: kernel io prettyprint math.functions math.ranges
    sequences ;
IN: euler.pr005

: solve005 ( -- n )
    1
    2 20 [a,b] [ lcm ] each ;
MAIN: solve005
