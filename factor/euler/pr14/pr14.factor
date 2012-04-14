! Problem 13
!
! 05 April 2002
!
!
! The following iterative sequence is defined for the set of
! positive integers:
!
! n → n/2 (n is even)
! n → 3n + 1 (n is odd)
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
! Which starting number, under one million, produces the
! longest chain?
!
! NOTE: Once the chain starts the terms are allowed to go above
! one million.
! ------------------------------------------------------------
! 837799

USING: kernel arrays combinators math math.ranges memoize
sequences ;
IN: euler.pr14

<PRIVATE

: next-collatz ( x -- x )
    dup even? [ 2/ ] [ 3 * 1 + ] if ;

: count-collatz ( x -- n )
    [ 1 ] dip
    [ dup 1 > ]
    [ [ 1 + ] [ next-collatz ] bi* ] while
    drop ;

! Return the pair with the largest second value.
: biggest-pair ( p p -- p )
    2dup  [ second ] bi@  >
    [ drop ] [ nip ] if ;

PRIVATE>

: slow-euler14 ( -- n )
    1000000 [1,b] [ dup count-collatz 2array ]
    [ biggest-pair ] map-reduce
    first ;

! The above is actually reasonably quick.

<PRIVATE

! To start with, define it recursively.

: rcount ( x -- n )
    dup 1 =
    [ ]
    [ next-collatz rcount 1 + ] if ;

! Split this into a memoized version pair.
DEFER: memo-count
: fast-count ( x -- n )
    {
        { [ dup 1 = ] [ ] }
        { [ dup 10000 < ] [ memo-count ] }
        [ next-collatz fast-count 1 + ]
    } cond ;
MEMO: memo-count ( x -- n )
    next-collatz fast-count 1 + ;

PRIVATE>

: euler14 ( -- n )
    1000000 [1,b] [ dup fast-count 2array ]
    [ biggest-pair ] map-reduce
    first ;
