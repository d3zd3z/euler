! Problem 21
!
! 05 July 2002
!
!
! Let d(n) be defined as the sum of proper divisors of n
! (numbers less than n which divide evenly into n).
! If d(a) = b and d(b) = a, where a ≠ b, then a and b are an
! amicable pair and each of a and b are called amicable
! numbers.
!
! For example, the proper divisors of 220 are 1, 2, 4, 5, 10,
! 11, 20, 22, 44, 55 and 110; therefore d(220) = 284. The
! proper divisors of 284 are 1, 2, 4, 71 and 142; so d(284) =
! 220.
!
! Evaluate the sum of all the amicable numbers under 10000.

USING:
combinators.short-circuit
kernel
locals
math
math.ranges
sequences
;
IN: euler.pr21

! Does a divide evenly into b?
: divides? ( a b -- ? )
    swap mod 0 = ; inline

:: (sum-proper-divisors) ( n -- dn )
    1 n [a,b) [
        dup n divides? [ drop 0 ] unless
    ] map-sum ;
: sum-proper-divisors ( n -- dn )
    dup 1 > [ (sum-proper-divisors) ] [ drop 0 ] if ;

: amicable? ( a -- ? )
    dup sum-proper-divisors {
        [ = not ]
        [ sum-proper-divisors = ]
    } 2&& ;

: euler-21 ( -- n )
    2 10000 [a,b) [
        dup amicable? [ drop 0 ] unless
    ] map-sum ;
