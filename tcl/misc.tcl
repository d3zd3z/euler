# Various miscellaneous utilities.

proc reverse_number {number {base 10}} {
    set result 0
    while {$number > 0} {
        set result [expr {$result * 10 + $number % $base}]
        set number [expr {$number / $base}]
    }
    return $result
}

proc is_palindrome {number {base 10}} {
    return [expr {$number == [reverse_number $number $base]}]
}
