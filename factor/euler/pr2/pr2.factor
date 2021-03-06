! Project Euler
! Each new term in the Fibonacci sequence is generated by
! adding the previous two terms. By starting with 1 and 2, the
! first 10 terms will be:
!
! 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...
!
! By considering the terms in the Fibonacci sequence whose
! values do not exceed four million, find the sum of the
! even-valued terms.

USING: kernel io prettyprint 
    locals
    math math.ranges sequences vectors ;
IN: euler.pr2

: next-fib ( a b -- b c )
    swap over + ;

! Return a vector of all of the fibbonaci numbers less than
! 'bound'.
:: fibs ( bound -- vector )
    [let V{ 1 } clone :> result
        1 1 [ dup bound < ]
        [ dup result push  next-fib ] while
        2drop  result ] ;
: solve ( -- )
    4000000 fibs
    [ even? ] filter sum
    . ;
MAIN: solve
