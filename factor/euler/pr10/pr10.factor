! Project Euler
! The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
!
! Find the sum of all the primes below two million.

USING: kernel
    math.primes
    sequences
    ;
IN: euler.pr10

: euler10 ( -- n )
    2000000 primes-upto  sum ;
