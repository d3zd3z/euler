// Lexicographic permutations.
// This is generic (like "sort"), and somewhat slower than a specific solution

package euler

import "sort"

func NextPermutation(data sort.Interface) (done bool) {
	length := data.Len()
	k := -1
	for x := 0; x < length-1; x++ {
		if data.Less(x, x+1) {
			k = x
		}
	}
	if k < 0 {
		return true
	}

	l := -1
	for x := k + 1; x < length; x++ {
		if data.Less(k, x) {
			l = x
		}
	}
	data.Swap(k, l)
	reverse(data, k+1, length-1)
	return false
}

func reverse(data sort.Interface, a, b int) {
	for a < b {
		data.Swap(a, b)
		a++
		b--
	}
}
