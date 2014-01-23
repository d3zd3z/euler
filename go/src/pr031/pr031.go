//////////////////////////////////////////////////////////////////////
// Problem 31
//
// Published on Friday, 22nd November 2002, 06:00 pm; Solved by 30115
//
// In England the currency is made up of pound, -L-, and pence, p, and
// there are eight coins in general circulation:
//
//     1p, 2p, 5p, 10p, 20p, 50p, -L-1 (100p) and -L-2 (200p).
//
// It is possible to make -L-2 in the following way:
//
//     1x-L-1 + 1x50p + 2x20p + 1x5p + 1x2p + 3x1p
//
// How many different ways can -L-2 be made using any number of coins?
//
//////////////////////////////////////////////////////////////////////
// 73682

package main

import "fmt"

func main() {
	fmt.Printf("%d\n", rways(200, coins))
}

func rways(remaining int, coins []int) int {
	if len(coins) == 0 {
		if remaining == 0 {
			return 1
		} else {
			return 0
		}
	}
	coin := coins[0]
	others := coins[1 : len(coins)]
	sum := 0
	for remaining >= 0 {
		sum += rways(remaining, others)
		remaining -= coin
	}
	return sum
}

var coins = []int { 200, 100, 50, 20, 10, 5, 2, 1 }
