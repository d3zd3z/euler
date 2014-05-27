! Problem 31
!
! 22 November 2002
!
!
! In England the currency is made up of pound, £, and pence, p,
! and there are eight coins in general circulation:
!
!     1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).
!
! It is possible to make £2 in the following way:
!
!     1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p
!
! How many different ways can £2 be made using any number of
! coins?
!
! 732682

USING:
    io
    kernel
    locals
    math
    math.ranges
    sequences
    ;
IN: euler.pr031

! Works faster when the larger coins are at the front.
CONSTANT: +coins+ { 200 100 50 20 10 5 2 1 }

! How many ways are there of solving zero coins, based on the
! remaining amount being 'n'.
: dredges ( n -- count )
    zero? [ 1 ] [ 0 ] if ;

DEFER: ways

! Scan the ways to combine with a given coin, and a rest of
! coins.
:: coin-ways ( n coins coin -- count )
    0
    n 0  coin neg <range> [
        coins ways +
    ] each ;

! Resursive scanner.  For a given set of coins, and a remaining
! coin count, determine how many ways to combine there are.
: ways ( n coins -- count )
    dup empty? [ drop dredges ] [ unclip coin-ways ] if ;

: solve031 ( -- n )
    200 +coins+ ways ;
MAIN: solve031
