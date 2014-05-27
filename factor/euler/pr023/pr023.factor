! Problem 23
!
! 02 August 2002
!
!
! A perfect number is a number for which the sum of its proper
! divisors is exactly equal to the number. For example, the sum
! of the proper divisors of 28 would be 1 + 2 + 4 + 7 + 14 = 28,
! which means that 28 is a perfect number.
!
! A number n is called deficient if the sum of its proper
! divisors is less than n and it is called abundant if this sum
! exceeds n.
!
! As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16,
! the smallest number that can be written as the sum of two
! abundant numbers is 24. By mathematical analysis, it can be
! shown that all integers greater than 28123 can be written as
! the sum of two abundant numbers. However, this upper limit
! cannot be reduced any further by analysis even though it is
! known that the greatest number that cannot be expressed as the
! sum of two abundant numbers is less than this limit.
!
! Find the sum of all the positive integers which cannot be
! written as the sum of two abundant numbers.
!
! 4179871

USING:
    io
    hash-sets
    kernel
    locals
    math
    math.order
    math.ranges
    namespaces
    sequences
    sets
    ;
IN: euler.pr023

FROM: namespaces => set ;

CONSTANT: +limit+ 28124

! Update array 'divs' by adding 'base' for each element of
! 'mults'.
: add-divs! ( base divs mults -- )
    [ 2over rot swap [ + ] change-nth ] each
    2drop ;

: update-divs! ( divs n -- )
    over length 1 -  over dup  dup +  -rot <range>
    [ swap ] dip
    add-divs! ;

:: compute-divisors ( limit -- divs )
    0 limit [ dup [ 1 max ] dip ] replicate nip
    2 [ dup limit < ] [
        2dup update-divs!
        1 +
    ] while drop ;

SYMBOL: work-divisors

: abundants ( -- vec )
    12 +limit+ [a,b)
    [ dup work-divisors get nth < ] filter ;

! Call 'quot' on each tail of the given seq.
: each-tail ( ... seq quot: ( ... subseq -- ... ) -- ... )
    over empty? [ 2drop ] [
        [ call ] 2keep
        [ rest-slice ] dip
        each-tail
    ] if ; inline recursive

! Three different solutions to this.
!
! 'abundant-pairs' is a mapping similar to the conventional
! solution.  It is slightly faster than the other solutions.
!
! abp2 simplifies the loops, but relies on set union, which
! makes it overall quite a bit slower.
!
! abp3 implements the same basic algorithm as abundant-pairs,
! but with simpler words and basic stack operations.

: abundant-pairs ( -- vec )
    HS{ } clone
    abundants [| ab |
        ab first :> a
        ab [| b |
            a b +
            ! over adjoin
            ! This conditional does help.
            dup +limit+ < [
                over adjoin
            ] [ drop ] if
        ] each
    ] each-tail ;

! Given an element, and a sequence of values, build a hash-set
! of the sums.  The result only includes those less than +limit+
: sums-of ( n nums -- hset )
    [ over + ] map  nip ;

! This seems a lot more readable, but it is also quite a bit
! slower than the above.  It seems that 'union' takes quite a
! bit of time.
: abp2 ( -- vec )
    HS{ } clone
    abundants [
        dup first swap
        sums-of  >hash-set  union
    ] each-tail ;

! So, to make it better, let's do the 'sums-of' directly
! adjoining.  This is better if we don't adjoin ones not in the
! limit.
: sums-of! ( hset n nums -- )
    rot [let :> hset
        [ over +
            dup +limit+ < [
                hset adjoin
            ] [ drop ] if
        ] each
    ] drop ;

! This is at least close to the time of the 'abundant-pairs'
! solution above.
: abp3 ( -- vec )
    HS{ } clone
    abundants [
        [ dup ] dip
        dup first swap
        sums-of!
    ] each-tail ;

:: solve023 ( -- n )
    [
        +limit+ compute-divisors  work-divisors set
        ! abundant-pairs :> pairs
        abp3 :> pairs
        +limit+ [1,b) [
            pairs in? not
        ] filter sum
    ] with-scope ;
MAIN: solve023
