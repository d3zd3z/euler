# Problem 14
#
# 05 April 2002
#
#
# The following iterative sequence is defined for the set of positive
# integers:
#
# n → n/2 (n is even)
# n → 3n + 1 (n is odd)
#
# Using the rule above and starting with 13, we generate the following
# sequence:
#
# 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
#
# It can be seen that this sequence (starting at 13 and finishing at 1)
# contains 10 terms. Although it has not been proved yet (Collatz Problem),
# it is thought that all starting numbers finish at 1.
#
# Which starting number, under one million, produces the longest chain?
#
# NOTE: Once the chain starts the terms are allowed to go above one million.
#
# 837799

# Simple chain length computation.
# But, TCL's stack isn't that large, so don't be recursive.
proc chain_len {n} {
    set count 1
    while {$n > 1} {
        if {($n & 1) == 0} {
            set n [expr {$n >> 1}]
        } else {
            set n [expr {3 * $n + 1}]
        }
        incr count
    }

    set count
}

proc solve {} {
    set max_len 0
    set max 0
    for {set x 1} {$x < 1000000} {incr x} {
        set len [chain_len $x]
        if {$len > $max_len} {
            set max_len $len
            set max $x
        }
    }
    return [list $max $max_len]
}

puts [solve]

