! Problem 20
!
! 21 June 2002
!
!
! n! means n × (n − 1) × ... × 3 × 2 × 1
!
! For example, 10! = 10 × 9 × ... × 3 × 2 × 1 = 3628800,
! and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 +
! 8 + 0 + 0 = 27.
!
! Find the sum of the digits in the number 100!
!
! 648

USING:
    io
    kernel
    math
    math.combinatorics
    ;
IN: euler.pr020

! TODO: Move to shared common library.
: digit-sum ( n -- x )
    0 swap
    [ dup 0 > ]
    [ 10 /mod  rot + swap ]
    while drop ;

: solve020 ( -- n )
    100 factorial  digit-sum ;
MAIN: solve020
