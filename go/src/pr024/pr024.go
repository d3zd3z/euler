//////////////////////////////////////////////////////////////////////
// Problem 24
//
// Published on Friday, 16th August 2002, 06:00 pm; Solved by 43908
//
// A permutation is an ordered arrangement of objects. For example,
// 3124 is one possible permutation of the digits 1, 2, 3 and 4. If all
// of the permutations are listed numerically or alphabetically, we
// call it lexicographic order. The lexicographic permutations of 0, 1
// and 2 are:
//
// 012   021   102   120   201   210
//
// What is the millionth lexicographic permutation of the digits 0, 1,
// 2, 3, 4, 5, 6, 7, 8 and 9?
//
//////////////////////////////////////////////////////////////////////
// 2783915460

package main

import "fmt"
import "euler"

func main() {
	base := []byte{'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'}

	for i := 1; i < 1000000; i++ {
		done := euler.NextPermutation(ByteSlice(base))
		if done {
			panic("Done early")
		}
	}

	fmt.Printf("%s\n", base)
}

type ByteSlice []byte

func (p ByteSlice) Len() int           { return len(p) }
func (p ByteSlice) Less(i, j int) bool { return p[i] < p[j] }
func (p ByteSlice) Swap(i, j int)      { p[i], p[j] = p[j], p[i] }
