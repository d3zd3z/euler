//////////////////////////////////////////////////////////////////////
// Problem 36
//
// Published on Friday, 31st January 2003, 06:00 pm; Solved by 37868
//
// The decimal number, 585 = 1001001001[2] (binary), is palindromic in
// both bases.
//
// Find the sum of all numbers, less than one million, which are
// palindromic in base 10 and base 2.
//
// (Please note that the palindromic number, in either base, may not
// include leading zeros.)
//
//////////////////////////////////////////////////////////////////////
// 872187

package pr036

import "fmt"

func Run() {
	sum := 0
	for i := 1; i < 1000000; i++ {
		if isPalindrome(i, 10) && isPalindrome(i, 2) {
			sum += i
		}
	}
	fmt.Printf("%d\n", sum)
}

func isPalindrome(num int, base int) bool {
	return num == reverse(num, base)
}

func reverse(num int, base int) (result int) {
	for num > 0 {
		result = result*base + num%base
		num /= base
	}
	return
}
