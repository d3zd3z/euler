! Problem 16
!
! 03 May 2002
!
!
! 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
!
! What is the sum of the digits of the number 2^1000?
!
! 1366

USING:
    io
    kernel
    math
    math.functions
    ;
IN: euler.pr016

: digit-sum ( n -- x )
    0 swap
    [ dup 0 > ]
    [ 10 /mod  rot + swap ]
    while drop ;

: solve016 ( -- n )
    2 1000 ^  digit-sum ;
MAIN: solve016
