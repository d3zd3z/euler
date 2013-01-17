//////////////////////////////////////////////////////////////////////
// Problem 17
//
// Published on Friday, 17th May 2002, 06:00 pm; Solved by 54055
//
// If the numbers 1 to 5 are written out in words: one, two, three,
// four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in
// total.
//
// If all the numbers from 1 to 1000 (one thousand) inclusive were
// written out in words, how many letters would be used?
//
// NOTE: Do not count spaces or hyphens. For example, 342 (three
// hundred and forty-two) contains 23 letters and 115 (one hundred and
// fifteen) contains 20 letters. The use of "and" when writing out
// numbers is in compliance with British usage.
//
//////////////////////////////////////////////////////////////////////
// 21124

package main

import "fmt"
import "unicode"

func main() {
	count := 0
	for i := 1; i <= 1000; i++ {
		text := textify(i)
		count += countLetters(text)
		// fmt.Printf("%-3d '%s'\n", i, textify(i))
	}
	fmt.Printf("%d\n", count)
}

// This assumes ascii.
func countLetters(text string) (count int) {
	for i := 0; i < len(text); i++ {
		if unicode.IsLetter(rune(text[i])) {
			count++
		}
	}
	return
}

// TODO: this isn't very go-ish, and more function, including lots of
// string appends.  It also returns a stray space at the end of some
// numbers.
func textify(n int) string {
	if n > 1000 {
		panic("Number out of range")
	} else if n == 1000 {
		return "one thousand"
	} else if n >= 100 {
		num := n % 100
		andText := "and "
		if num == 0 {
			andText = ""
		}
		return oneNames[n/100-1] + " hundred " + andText + textify(num)
	} else if n >= 20 {
		num := n % 10
		hyphen := "-"
		if num == 0 {
			hyphen = " "
		}
		return tenNames[n/10-1] + hyphen + textify(num)
	} else if n >= 1 {
		return oneNames[n-1]
	} else {
		return ""
	}
	panic("Not reached")
}

var oneNames = []string{"one", "two", "three", "four", "five", "six",
	"seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen",
	"fourteen", "fifteen", "sixteen", "seventeen", "eighteen",
	"nineteen"}

var tenNames = []string{"ten", "twenty", "thirty", "forty", "fifty",
	"sixty", "seventy", "eighty", "ninety"}
