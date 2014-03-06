# Prime sieve

namespace eval ::sieve {
    namespace export create isprime nextprime divisor_count
    namespace ensemble create
}

# To start with, put a simple sieve here.
# TODO: Figure out one of the OO packages and use that.
proc sieve::fill {limit} {
    # Create initial array
    set primes [lrepeat $limit 1]
    lset primes 0 0
    lset primes 1 0

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

proc sieve::create {} {
    set limit 1024
    dict create limit $limit primes [fill $limit]
}

proc sieve::new_size {cur need} {
    while {$need >= $cur} {
	set cur [expr {$cur * 8}]
    }
    set cur
}

proc sieve::isprime {svVar n} {
    upvar 1 $svVar sv
    dict with sv {
	if {$n >= $limit} {
	    set limit [new_size $limit $n]
	    set primes [fill $limit]
	}
	lindex $primes $n
    }
}

proc sieve::nextprime {svVar n} {
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

proc sieve::divisor_count {svVar n} {
    upvar 1 $svVar sv
    set result 1
    set prime 2

    while {$n > 1} {
	set divide_count 0
	while {$n % $prime == 0} {
	    set n [expr {$n / $prime}]
	    incr divide_count
	}

	set result [expr {$result * ($divide_count + 1)}]

	if {$n > 1} {
	    set prime [nextprime sv $prime]
	}
    }
    set result
}
