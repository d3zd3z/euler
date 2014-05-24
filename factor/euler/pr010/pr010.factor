! Problem 10
!
! 08 February 2002
!
!
! The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
!
! Find the sum of all the primes below two million.
!
! 142913828922

USING:
    kernel
    io
    math
    euler.sieve
    ;
IN: euler.pr010

: solve010 ( -- n )
    1024 <sieve>  2  0
    [ over  2000000 < ]
    [ over +  [ over swap next-prime ] dip ] while
    2nip ;
MAIN: solve010
