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

# To start with, put a simple sieve here.
# TODO: Figure out one of the OO packages and use that.
proc fill {limit} {
    # Create initial array
    set primes [list 0 0]
    for {set i 2} {$i < $limit} {incr i} {
	lappend primes 1
    }

    set pos 2
    while {$pos < $limit} {
	if {[lindex $primes $pos]} {
	    set n [expr {$pos + $pos}]
	    while {$n < $limit} {
		lset primes $n 0
		incr n $pos
	    }
	    if {$pos == 2} {
		set pos 3
	    } else {
		incr pos 2
	    }
	} else {
	    incr pos 2
	}
    }

    return $primes
}

proc create {} {
    set limit 1024
    dict create limit $limit primes [fill $limit]
}

proc new_size {cur need} {
    while {$need >= $cur} {
	set cur [expr {$cur * 8}]
    }
    set cur
}

proc isprime {svVar n} {
    upvar 1 $svVar sv
    dict with sv {
	if {$n >= $limit} {
	    set limit [new_size $limit $n]
	    set primes [fill $limit]
	}
	lindex $primes $n
    }
}

proc nextprime {svVar n} {
    upvar 1 $svVar sv
    if {$n == 2} {
	return 3
    } else {
	incr n 2
	while {![isprime sv $n]} {
	    incr n 2
	}
	set n
    }
}

proc solve {} {
    set sv [create]
    set p 2
    set count 1
    while {$count <= 10000} {
	incr count
	set p [nextprime sv $p]
    }
    return $p
}

puts [solve]
