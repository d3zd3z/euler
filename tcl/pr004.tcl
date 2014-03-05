# Problem 4
#
# 16 November 2001
#
#
# A palindromic number reads the same both ways. The largest palindrome made
# from the product of two 2-digit numbers is 9009 = 91 × 99.
#
# Find the largest palindrome made from the product of two 3-digit numbers.
#
# 906609

source misc.tcl

proc solve {} {
    set max 0
    for {set a 100} {$a < 1000} {incr a} {
        for {set b $a} {$b < 1000} {incr b} {
            set c [expr {$a * $b}]
            if {$c > $max && [is_palindrome $c]} {
                set max $c
            }
        }
    }
    return $max
}

puts [solve]

