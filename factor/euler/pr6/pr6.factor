! Project Euler
! The sum of the squares of the first ten natural numbers is,
! 12 + 22 + ... + 102 = 385
!
! The square of the sum of the first ten natural numbers is,
! (1 + 2 + ... + 10)2 = 552 = 3025
!
! Hence the difference between the sum of the squares of the
! first ten natural numbers and the square of the sum is 3025 −
! 385 = 2640.
!
! Find the difference between the sum of the squares of the
! first one hundred natural numbers and the square of the sum.

USING:
    kernel
    math
    math.ranges
    prettyprint
    sequences
    ;
IN: euler.pr6

: sum-of-squares ( limit -- n )
    1 swap [a,b] [ sq ] [ + ] map-reduce ;
: square-of-sums ( limit -- n )
    dup 1 + * 2 /i  sq ;
: solve ( x -- y )
    dup  sum-of-squares
    swap square-of-sums
    - abs ;
: main ( -- )
    100 solve . ;
MAIN: main
