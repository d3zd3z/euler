! A perfect number is a number for which the sum of its proper
! divisors is exactly equal to the number. For example, the sum
! of the proper divisors of 28 would be 1 + 2 + 4 + 7 + 14 = 28,
! which means that 28 is a perfect number.

! A number whose proper divisors are less than the number is
! called deficient and a number whose proper divisors exceed the
! number is called abundant.

! As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16,
! the smallest number that can be written as the sum of two
! abundant numbers is 24. By mathematical analysis, it can be
! shown that all integers greater than 28123 can be written as
! the sum of two abundant numbers. However, this upper limit
! cannot be reduced any further by analysis even though it is
! known that the greatest number that cannot be expressed as the
! sum of two abundant numbers is less than this limit.

! Find the sum of all the positive integers which cannot be
! written as the sum of two abundant numbers.

USING:
bit-sets
kernel
locals
hash-sets
make
math
math.functions
math.ranges
sequences
sets
;
IN: euler.pr23

! This is the summer from the library.
: perfect-square? ( n -- ? )
    dup sqrt mod zero? ;

! This is the function out of the library.
: them-(sum-divisors) ( n -- sum )
    dup sqrt >integer [1,b] [
        [ 2dup divisor? [ 2dup / + , ] [ drop ] if ] each
        dup perfect-square? [ sqrt >fixnum neg , ] [ drop ] if
    ] { } make sum ;

! Make it faster by keeping the result right on the stack.
: (sum-divisors) ( n -- sum )
    0 swap
    dup sqrt >integer [1,b]
    [ 2dup divisor? [ 2dup / +  rot + swap ] [ drop ] if ] each
    dup perfect-square? [ sqrt >fixnum - ] [ drop ] if ;

! This is slightly slower, but potentially easier to read.
:: 1(sum-divisors) ( n -- sum )
    0 :> total!
    n sqrt >integer [1,b] [| i |
        n i divisor? [ total i n i / + + total! ] when
    ] each
    n perfect-square? [ total n sqrt >fixnum - total! ] when
    total ;

: sum-divisors ( n -- sum )
    dup 4 < [ { 0 1 3 4 } nth ] [ (sum-divisors) ] if ;

: sum-proper-divisors ( n -- sum )
    dup sum-divisors swap - ;

:: me-sum-proper-divisors ( n -- dn )
    1 n [a,b) [
        dup n swap divisor? [ drop 0 ] unless
    ] map-sum ;

: abundant? ( n -- ? )
    dup sum-proper-divisors < ;

: abundants-upto ( n -- seq )
    12 swap [a,b] [ abundant? ] filter ;

:: sum-pairs ( seq -- set )
    28124 2 * <bit-set>
    seq [ :> a seq [ a + over adjoin ] each ] each ;

:: unsum-pairs ( set seq -- set2 )
    set seq [ :> a seq [ a + over delete ] each ] each ;

: range>set ( range -- set )
    dup last 1 + <bit-set> union ;

: euler-23 ( -- n )
    28123 [1,b] range>set
    28123 abundants-upto  sum-pairs
    diff
    ! 28123 [1,b]  28124 2 * <bit-set> union
    ! 28123 abundants-upto  unsum-pairs
    members sum ;
