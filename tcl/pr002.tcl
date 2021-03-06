# Problem 2
#
# 19 October 2001
#
#
# Each new term in the Fibonacci sequence is generated by adding the
# previous two terms. By starting with 1 and 2, the first 10 terms will be:
#
# 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...
#
# By considering the terms in the Fibonacci sequence whose values do not
# exceed four million, find the sum of the even-valued terms.
#
# 4613732

proc solve {} {
    set total 0
    set a 1
    set b 1
    while {$b < 4000000} {
        if {$b % 2 == 0} {incr total $b}
        set tmp [expr {$a + $b}]
        set a $b
        set b $tmp
    }
    return $total
}

puts [solve]

