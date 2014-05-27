! Problem 30
!
! 08 November 2002
!
!
! Surprisingly there are only three numbers that can be written
! as the sum of fourth powers of their digits:
!
!     1634 = 1^4 + 6^4 + 3^4 + 4^4
!     8208 = 8^4 + 2^4 + 0^4 + 8^4
!     9474 = 9^4 + 4^4 + 7^4 + 4^4
!
! As 1 = 1^4 is not a sum it is not included.
!
! The sum of these numbers is 1634 + 8208 + 9474 = 19316.
!
! Find the sum of all the numbers that can be written as the sum
! of fifth powers of their digits.
!
! 443839

USING:
    io
    kernel
    locals
    math
    math.functions
    math.ranges
    sequences
    ;
IN: euler.pr030

! Sun the digits of 'n' raised to the given power.
:: power-sum ( n pow -- res )
    0 n [ dup 0 > ] [
        10 /mod
        pow ^
        rot + swap
    ] while drop ;

! Looking at n*9^5, we can quickly determine that there cannot
! be a 7-digit number that works.  So, only need to compute up
! to n=6.

: solve030 ( -- n )
    0
    2  999999 5 power-sum [a,b] [
        dup  5 power-sum  over = [ + ] [ drop ] if
    ] each ;
MAIN: solve030
