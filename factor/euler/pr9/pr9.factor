! Project Euler
! A Pythagorean triplet is a set of three natural numbers,
! a < b < c, for which,
!   a^2 + b^2 = c^2
!
! For example, 32 + 42 = 9 + 16 = 25 = 52.
!
! There exists exactly one Pythagorean triplet for which
! a + b + c = 1000.
! Find the product abc.

USING: kernel
    locals
    io
    math
    math.ranges
    prettyprint
    sequences
    ;
IN: euler.pr9

: euler9 ( -- )
    1 999 [a,b] [| a |
        a 1 +  1000 a -  [a,b] [| b |
            [let 1000 a - b - :> c
                c b >
                a sq  b sq +  c sq =  and [
                    a b c * * .
                ] when
            ]
        ] each
    ] each ;
