! Problem 21
!
! 05 July 2002
!
!
! Let d(n) be defined as the sum of proper divisors of n
! (numbers less than n which divide evenly into n).
! If d(a) = b and d(b) = a, where a ≠ b, then a and b are an
! amicable pair and each of a and b are called amicable numbers.
!
! For example, the proper divisors of 220 are 1, 2, 4, 5, 10,
! 11, 20, 22, 44, 55 and 110; therefore d(220) = 284. The proper
! divisors of 284 are 1, 2, 4, 71 and 142; so d(284) = 220.
!
! Evaluate the sum of all the amicable numbers under 10000.
!
! 31626

USING:
    io
    kernel
    locals
    math
    math.order
    math.ranges
    namespaces
    sequences
    ;
IN: euler.pr021

CONSTANT: +limit+ 10000

! Update array 'divs' by adding 'base' for each element of
! 'mults'.
: add-divs! ( base divs mults -- )
    [ 2over rot swap [ + ] change-nth ] each
    2drop ;

: update-divs! ( divs n -- )
    over length 1 -   over  dup  dup +  -rot <range>
    [ swap ] dip
    add-divs! ;

:: compute-divisors ( limit -- divs )
    0 limit [ dup [ 1 max ] dip ] replicate nip
    2 [ dup limit < ] [
        2dup update-divs!
        1 +
    ] while drop ;

SYMBOL: work-divisors

! Get the divisor count, safely, if it isn't a number, or is out
! of range, returns 'f'.
: safe-divsum ( n -- sum )
    dup [
        work-divisors get  2dup length < [
            nth
        ] [
            2drop f
        ] if
    ] when ;

: amicable? ( n -- ? )
    dup safe-divsum
    [ = not ]
    [ safe-divsum = ]
    2bi and ;

: solve021 ( -- n )
    [
        +limit+ compute-divisors  work-divisors set
        2 +limit+ [a,b) [ amicable? ] filter
        sum
    ] with-scope ;
MAIN: solve021
