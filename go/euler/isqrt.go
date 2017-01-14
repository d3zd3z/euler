// Integer square root

package euler

func ISqrt(num int) (result int) {
	bit := 1
	for (bit << 2) <= num {
		bit <<= 2
	}

	for bit != 0 {
		if num >= result+bit {
			num -= result + bit
			result = (result >> 1) + bit
		} else {
			result >>= 1
		}
		bit >>= 2
	}
	return
}
