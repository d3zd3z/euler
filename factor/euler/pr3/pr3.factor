! Project Euler
! The prime factors of 13195 are 5, 7, 13 and 29.
!
! What is the largest prime factor of the number 600851475143 ?

USING: kernel prettyprint math.primes.factors
    sequences ;
IN: euler.pr3

: solve ( -- )
    600851475143 factors last . ;
MAIN: solve
