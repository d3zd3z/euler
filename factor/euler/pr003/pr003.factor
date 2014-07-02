! Problem 3
!
! 02 November 2001
!
!
! The prime factors of 13195 are 5, 7, 13 and 29.
!
! What is the largest prime factor of the number 600851475143 ?
!
! 6857

USING: kernel io math prettyprint ;
IN: euler.pr003

: trydiv ( n p -- n p )
    2dup mod zero? [ 
        [ /i ] keep
    ] [
        2 +
    ] if ;

: solve003 ( -- n )
    600851475143 3
    [ over 1 > ] [ trydiv ] while
    nip ;
MAIN: solve003
