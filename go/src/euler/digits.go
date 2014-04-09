package euler

// Return the digits of the number as an array of the digits.
func DigitsOf(base int) (result []int) {
	result = make([]int, 0)

	for base != 0 {
		result = append(result, base % 10)
		base /= 10
	}

	// Reverse the digits.
	a := 0
	b := len(result) - 1
	for a < b {
		result[a], result[b] = result[b], result[a]
		a++
		b--
	}

	return
}

// Convert digits back into an integer.
func OfDigits(digits []int) (result int) {
	for _, digit := range digits {
		result = result * 10 + digit
	}

	return
}
