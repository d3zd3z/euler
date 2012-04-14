! Problem 16
!
! 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 =
! 26.
!
! What is the sum of the digits of the number 2^1000?

USING: kernel math math.parser grouping sequences ;
IN: euler.pr16

: euler-16 ( -- n )
    1000 2^ number>string
    1 group [ string>number ] map
    sum ;
