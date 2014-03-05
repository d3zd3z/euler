# Problem 3
#
# 02 November 2001
#
#
# The prime factors of 13195 are 5, 7, 13 and 29.
#
# What is the largest prime factor of the number 600851475143 ?
#
# 6857


# No reason to use a prime sieve here.

proc solve {} {
    set base 600851475143
    set prime 3
    while {$base > 1} {
        if {$base % $prime == 0} {
            set base [expr {$base / $prime}]
        } else {
            incr prime 2
        }
    }
    return $prime
}

puts [solve]

