# Problem 5
#
# 30 November 2001
#
# 2520 is the smallest number that can be divided by each of the numbers
# from 1 to 10 without any remainder.
#
# What is the smallest positive number that is evenly divisible by all of
# the numbers from 1 to 20?
#
# 232792560

proc gcd {a b} {
    while {$b > 0} {
	set b [expr {$a % [set a $b]}]
    }
    return $a
}

proc lcm {a b} {
    expr {($a / [gcd $a $b]) * $b}
}

proc solve {} {
    set total 1
    for {set i 2} {$i <= 20} {incr i} {
	set total [lcm $total $i]
    }
    return $total
}

puts [solve]
