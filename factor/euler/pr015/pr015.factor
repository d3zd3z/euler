! Problem 15
!
! 19 April 2002
!
!
! Starting in the top left corner of a 2×2 grid, there are 6
! routes (without backtracking) to the bottom right corner.
!
! [p_015]
!
! How many routes are there through a 20×20 grid?
!
! 137846528820

USING:
    arrays
    kernel
    io
    locals
    math
    sequences
    ;
IN: euler.pr015

CONSTANT: #steps 20

: init-row ( -- row )
    #steps 1 +  1  <repetition> >array ;

! Mutate the row, to give values for the next row.
! First pass: using locals
:: bump! ( row -- )
    #steps iota [| i |
        i 1 +  row [ i row nth + ] change-nth
    ] each ;

: solve015 ( -- n )
    init-row
    #steps [ dup bump! ] times
    last ;
MAIN: solve015
