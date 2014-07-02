! Problem 4
!
! 16 November 2001
!
!
! A palindromic number reads the same both ways. The largest palindrome made
! from the product of two 2-digit numbers is 9009 = 91 × 99.
!
! Find the largest palindrome made from the product of two 3-digit numbers.
!
! 906609

USING: kernel io math prettyprint
    combinators.short-circuit
    locals sequences
    math.order
    math.ranges ;
IN: euler.pr004

: nextrev ( accum work -- accum' work' )
    10 /mod  rot  10 *  +  swap ;

: digit-reverse ( n -- n )
    [ 0 ] dip
    [ dup 0 > ] [
        nextrev ] while
    drop ;

: palindrome? ( n -- ? )
    dup digit-reverse = ;

:: solve004 ( -- n )
    0 :> result!
    100 999 [a,b] [| a |
        a 999 [a,b] [| b |
            a b *  :> prod
            { [ prod palindrome? ] [ prod result > ] } 0&& [
                prod result!
            ] when
        ] each
    ] each
    result ;
MAIN: solve004

! Alternate solution.
! In some ways, it is a little cleaner.
: solve004b ( -- n )
    0
    100 999 [a,b] [| a |
        a 999 [a,b] [
            a *  dup palindrome? [ max ] [ drop ] if
        ] each
    ] each ;
