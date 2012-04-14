USING: kernel math sequences ;
IN: euler.common

! Returns the digits of the number, an empty sequence for 0.
: number>digits ( n -- seq )
    [ dup 0 = not ] [ 10 /mod ] produce reverse nip ;
