! Problem 7
!
! 28 December 2001
!
!
! By listing the first six prime numbers: 2, 3, 5, 7, 11, and
! 13, we can see that the 6th prime is 13.
!
! What is the 10 001st prime number?
!
! 104743

USING:
    kernel
    io
    math
    prettyprint
    euler.sieve
    ;
IN: euler.pr007

: solve007 ( -- n )
    1024 <sieve>
    2  10000 [ over swap  next-prime ] times
    nip ;
MAIN: solve007
