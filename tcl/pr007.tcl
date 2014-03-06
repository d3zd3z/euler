# Problem 7
#
# 28 December 2001
#
#
# By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see
# that the 6th prime is 13.
#
# What is the 10 001st prime number?
#
# 104743

source sieve.tcl

proc solve {} {
    set sv [sieve create]
    set p 2
    set count 1
    while {$count <= 10000} {
	incr count
	set p [sieve nextprime sv $p]
    }
    return $p
}

puts [solve]
