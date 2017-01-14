//////////////////////////////////////////////////////////////////////
// Problem 42
//
// Published on Friday, 25th April 2003, 06:00 pm; Solved by 33013
//
// The n^th term of the sequence of triangle numbers is given by, t[n]
// = 1/2n(n+1); so the first ten triangle numbers are:
//
// 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
//
// By converting each letter in a word to a number corresponding to its
// alphabetical position and adding these values we form a word value.
// For example, the word value for SKY is 19 + 11 + 25 = 55 = t[10]. If
// the word value is a triangle number then we shall call the word a
// triangle word.
//
// Using words.txt (right click and 'Save Link/Target As...'), a 16K
// text file containing nearly two-thousand common English words, how
// many are triangle words?
//
//////////////////////////////////////////////////////////////////////
// 162

package pr042

import (
	"fmt"
	"io/ioutil"
	"log"
	"strings"
)

func Run() {
	line, err := ioutil.ReadFile("src/github.com/d3zd3z/euler/haskell/words.txt")
	if err != nil {
		log.Fatalf("Unable to read words.txt: %s", err)
	}

	count := 0
	words := strings.Split(string(line), ",")
	for _, word := range words {
		word = strings.Trim(word, "\"")
		value := wordValue(word)
		if isTriangle(value) {
			count++
		}
	}
	fmt.Printf("%d\n", count)
}

func wordValue(word string) (result int) {
	for _, ch := range word {
		result += int(ch - 'A' + 1)
	}
	return
}

func isTriangle(n int) bool {
	sqr := n*8 + 1
	root := isqrt(sqr)
	return (root * root) == sqr

}

func isqrt(num int) (result int) {
	bit := 1
	for (bit << 2) < num {
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
