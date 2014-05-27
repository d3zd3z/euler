! Problem 26
!
! 13 September 2002
!
!
! A unit fraction contains 1 in the numerator. The decimal
! representation of the unit fractions with denominators 2 to 10
! are given:
!
!     ^1/[2]  =  0.5
!     ^1/[3]  =  0.(3)
!     ^1/[4]  =  0.25
!     ^1/[5]  =  0.2
!     ^1/[6]  =  0.1(6)
!     ^1/[7]  =  0.(142857)
!     ^1/[8]  =  0.125
!     ^1/[9]  =  0.(1)
!     ^1/[10] =  0.1
!
! Where 0.1(6) means 0.166666..., and has a 1-digit recurring
! cycle. It can be seen that ^1/[7] has a 6-digit recurring
! cycle.
!
! Find the value of d < 1000 for which ^1/[d] contains the
! longest recurring cycle in its decimal fraction part.
!
! 983

USING:
    io
    kernel
    locals
    math
    math.primes
    sequences
    ;
IN: euler.pr026

! Solve the discrete log problem.
! k for 10^k = 1 (mod n)
! For a composite number, the length will merely be the longest
! length of any of its factors, so no reason to call with
! composites.  Will fail to terminate if the value has 2 or 5 as
! factors.
: dlog ( n -- k )
    1  over 10 swap mod
    [ dup 1 = not ]
    [
        [ 1 + ] dip
        10 *  pick mod
    ] while
    drop nip ;

! Produce all of the primes from a-b.
: [a,b)-primes ( a b -- seq )
    swap
    [ 2dup > ]
    [ dup next-prime swap ] produce
    2nip ;

! Returns b bval if bval > aval, otherwise keeps a aval.
:: max2 ( a aval b bval -- a' aval' )
    aval bval >= [ a aval ] [ b bval ] if ;

: solve026 ( -- n )
    0 0
    7 1000 [a,b)-primes [
        dup dlog  max2
    ] each
    drop ;
MAIN: solve026
