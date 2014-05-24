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

USING: kernel io prettyprint math.primes sequences ;
IN: euler.pr007

: solve007 ( -- n )
    10001 nprimes last ;
MAIN: solve007

! That was simple, but it might be useful to implement our own
! little sieve.
USING: accessors bit-sets combinators locals sets
    math math.ranges ;

! This version is slightly slower, even though still a bit
! easier to read.

TUPLE: sieve limit composites ;

! Construct an empty sieve (with 0 and 1 invalidated).
: (<sieve>) ( n -- sieve )
    dup  <bit-set>
    [ 0 swap adjoin ] keep
    [ 1 swap adjoin ] keep
    sieve boa ;

! Mark the composites of the given prime in the sieve.
: mark-primes ( sieve p -- )
    [ nip  dup + ] 2keep
    [ drop  limit>> 1 - ] 2keep
    [ nip  <range> ] 2keep
    drop  composites>> swap union! drop ;

! Is 'p' prime according to this sieve.  Non-reallocating
! version.
: (composite?) ( sieve p -- ? )
    swap composites>> in? ;

! Given a prime, either return the next prime from the sieve, of
! 'f' if it is past the limit.
: (pnext) ( sieve p -- p2 )
    2dup  swap limit>> < [
        2dup (composite?) [
            2 +  (pnext)
        ] [
            nip
        ] if
    ] [ 2drop f ] if ;

: pnext ( sieve p -- p2 )
    dup 2 = [ drop 3 ] [ 2 + ] if
    (pnext) ;

: (fill-sieve) ( sieve p -- )
    2dup mark-primes
    over swap pnext
    [ (fill-sieve) ] [ drop ] if* ;

: fill-sieve ( sieve -- )
    2  (fill-sieve) ;

! Construct a sieve of the given size.
: <sieve> ( n -- sieve )
    (<sieve>) dup fill-sieve ;

! This is correct, but ugly.  Can we do better?

! Set all of the composites that are multiples of the prime 'p'.
:: walk-prime ( comps limit p -- )
    p dup +  limit 1 -  p  <range> [
        comps adjoin
    ] each ;

! Find the next prime in the given composites, or 'f' if there
! are no more.
:: (prime-advance) ( comps limit p -- p' )
    p limit < [
        p comps in? [
            comps limit
            p 2 +
            (prime-advance)
        ] [ p ] if
    ] [ f ] if ;

: prime-advance ( comps limit p -- p' )
    dup 2 = [ drop 3 ] [ 2 + ] if
    (prime-advance) ;

:: (fill) ( comps limit p -- )
    comps limit p walk-prime
    comps limit p prime-advance
    [| p2 | comps limit p2 (fill) ] when* ;

: fill ( comps limit -- )
    2 (fill) ;

:: <composites> ( n -- comps )
    n <bit-set> :> s
    0 s adjoin
    1 s adjoin
    s n fill
    s ;
