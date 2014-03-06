# Problem 10
#
# 08 February 2002
#
#
# The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
#
# Find the sum of all the primes below two million.
#
# 142913828922

source sieve.tcl

proc solve {} {
    set sv [sieve create]
    set total 0
    set p 2
    while {$p < 2000000} {
	incr total $p
	set p [sieve nextprime sv $p]
    }
    return $total
}

puts [solve]
