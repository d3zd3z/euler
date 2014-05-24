! A Prime sieve.

USING:
    accessors
    bit-sets
    kernel
    locals
    math
    math.ranges
    sets
    ;
IN: euler.sieve

! A prime sieve.  At any time, it has a limit of how large of a
! sieve has been computed, and a bitset of the composites up to
! that limit.
TUPLE: sieve  limit composites ;

<PRIVATE

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

: fill-sieve ( sieve limit -- )
    [ <bit-set>  >>composites ] keep
    >>limit
    dup composites>>
    [ 0 swap adjoin ] [ 1 swap adjoin ] bi
    2 (fill-sieve) ;

! Find a good next size for the sieve.  Grow by a factor of '8'
! to try to keep from recomputing too much, but also to avoid
! computing way too much.
: next-size ( cur need -- size )
    2dup > [ drop ] [
        [ 8 * ] dip
        next-size
    ] if ;

! Ensure this sieve has room for n primes.
: need ( sieve n -- )
    over limit>>  over  <= [
        over limit>> swap  next-size
        fill-sieve
    ] [ 2drop ] if ;

PRIVATE>

! Construct an initial sieve, of the given initial size.
: <sieve> ( n -- sieve )
    sieve new
    dup rot fill-sieve ;

: prime? ( sieve n -- ? )
    [ need ]
    [ (composite?) not ] 2bi ;

<PRIVATE
: (next-prime) ( sieve n -- n2 )
    2dup prime? [ nip ] [
        2 + (next-prime)
    ] if ;
PRIVATE>

: next-prime ( sieve n -- n2 )
    dup 2 = [ drop 3 ] [ 2 + ] if
    (next-prime) ;
