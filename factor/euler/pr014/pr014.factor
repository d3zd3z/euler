! Problem 14
!
! 05 April 2002
!
!
! The following iterative sequence is defined for the set of
! positive integers:
!
! n → n/2 (n is even) n → 3n + 1 (n is odd)
!
! Using the rule above and starting with 13, we generate the
! following sequence:
!
! 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
!
! It can be seen that this sequence (starting at 13 and
! finishing at 1) contains 10 terms. Although it has not been
! proved yet (Collatz Problem), it is thought that all starting
! numbers finish at 1.
!
! Which starting number, under one million, produces the longest
! chain?
!
! NOTE: Once the chain starts the terms are allowed to go above
! one million.
!
! 837799

USING:
    kernel
    io
    locals
    math
    math.ranges
    sequences
    ;
IN: euler.pr014

: cnext ( n -- n2 )
    dup even? [ 2 /i ] [ 3 * 1 + ] if ;

! Count how many iterations.
: collatz ( k -- n )
    1 swap
    [ dup 1 = not ]
    [ cnext  [ 1 + ] dip ]
    while
    drop ;

:: solve014 ( -- n )
    0 :> biggest!
    0 :> big-k!
    1 1000000 [a,b) [| k |
        k collatz :> val
        val biggest > [
            k big-k!
            val biggest!
        ] when
    ] each
    big-k ;

MAIN: solve014
