! Problem 9
!
! 25 January 2002
!
!
! A Pythagorean triplet is a set of three natural numbers, a < b < c, for
! which,
!
! a^2 + b^2 = c^2
!
! For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.
!
! There exists exactly one Pythagorean triplet for which a + b + c = 1000.
! Find the product abc.
!
! 31875000

USING:
    kernel
    io
    locals
    math
    math.ranges
    prettyprint
    sequences
    ;
IN: euler.pr009

: solve009 ( -- n )
    0
    1 1000 [a,b) [| a |
        1 1000 [a,b) [| b |
            1000 a - b - :> c
            c b >
            a sq  b sq +  c sq =  and [
                drop  a b * c *
            ] when
        ] each
    ] each ;
MAIN: solve009
