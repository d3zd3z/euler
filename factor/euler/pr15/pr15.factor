! Problem 15
!
! Starting in the top left corner of a 2×2 grid, there are 6
! routes (without backtracking) to the bottom right corner.
!
! [p_015]
!
! How many routes are there through a 20×20 grid?

USING:
kernel
math
sequences
;
IN: euler.pr15

! Make the first row of the grid.
: base ( n -- seq )
    1 + 1 <repetition> ;

! Get the next row of counts.
: bump ( seq -- seq2 )
    [ 0 ] dip
    [ + dup ] map nip ;

: nbump ( seq n -- seq2 )
    [ bump ] times ;

: euler-15 ( -- n )
    20 base 20 nbump last ;
