\ Problem 1
\ vim: ft=forth
\
\ 05 October 2001
\
\
\ If we list all the natural numbers below 10 that are multiples of 3 or 5,
\ we get 3, 5, 6 and 9. The sum of these multiples is 23.
\
\ Find the sum of all the multiples of 3 or 5 below 1000.
\
\ 233168

: divby ( n m -- ) \ Is n%m==0
    mod 0= ;

: valid ( n -- flag )
  dup 3 divby
    if  drop true
    else  5 divby
    then ;

: solve ( -- n )
  0
  1000 1 do
    i valid if i + then
  loop ;

solve .
