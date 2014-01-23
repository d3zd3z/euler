//////////////////////////////////////////////////////////////////////
// Problem 33
//
// Published on Friday, 20th December 2002, 06:00 pm; Solved by 28647
//
// The fraction ^49/[98] is a curious fraction, as an inexperienced
// mathematician in attempting to simplify it may incorrectly believe
// that ^49/[98] = ^4/[8], which is correct, is obtained by cancelling
// the 9s.
//
// We shall consider fractions like, ^30/[50] = ^3/[5], to be trivial
// examples.
//
// There are exactly four non-trivial examples of this type of
// fraction, less than one in value, and containing two digits in the
// numerator and denominator.
//
// If the product of these four fractions is given in its lowest common
// terms, find the value of the denominator.
//
//////////////////////////////////////////////////////////////////////

package main

import "fmt"
import "math/big"

func main() {
	product := big.NewRat(1, 1)
	for ab := 1; ab < 100; ab++ {
		for cd := ab+1; cd < 100; cd++ {
			if is, ad := isCurious(ab, cd); is {
				// fmt.Printf("%d/%d\n", ab, cd)
				product.Mul(product, ad)
			}
		}
	}
	fmt.Printf("%v\n", product.Denom())
}

func isCurious(ab, cd int) (is bool, ad *big.Rat) {
	a := ab / 10
	b := ab % 10
	c := cd / 10
	d := cd % 10
	if d != 0 && b == c {
		abcd := big.NewRat(int64(ab), int64(cd))
		ad = big.NewRat(int64(a), int64(d))
		is = abcd.Cmp(ad) == 0
	}
	return
}
