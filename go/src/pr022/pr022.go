//////////////////////////////////////////////////////////////////////
// Problem 22
//
// Published on Friday, 19th July 2002, 06:00 pm; Solved by 50080
//
// Using names.txt (right click and 'Save Link/Target As...'), a 46K
// text file containing over five-thousand first names, begin by
// sorting it into alphabetical order. Then working out the
// alphabetical value for each name, multiply this value by its
// alphabetical position in the list to obtain a name score.
//
// For example, when the list is sorted into alphabetical order, COLIN,
// which is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the
// list. So, COLIN would obtain a score of 938 x 53 = 49714.
//
// What is the total of all the name scores in the file?
//
//////////////////////////////////////////////////////////////////////
// 871198282

package pr022

import "fmt"
import "io/ioutil"
import "sort"

func Run() {
	text, err := ioutil.ReadFile("../haskell/names.txt")
	if err != nil {
		panic("Unable to read names file")
	}

	names := getNames(text)
	sort.Strings(names)
	sum := 0
	for i, name := range names {
		sum += (i+1) * nameValue(name)
	}
	fmt.Printf("%d\n", sum)
}

func getNames(text []byte) (result []string) {
	result = make([]string, 0, 500)
	pos := 0

	must := func(ch byte) {
		if text[pos] != ch {
			fmt.Printf("Invalid char '%c', at %d, expecting '%c'\n", text[pos], pos, ch)
			panic("Invalid character")
		}
		pos++
	}

	for pos < len(text) {
		must('"')
		base := pos
		for pos < len(text) && text[pos] != '"' {
			pos++
		}
		result = append(result, string(text[base:pos]))
		pos++  // The quote.
		if pos < len(text) {
			must(',')
		}
	}

	return
}

func nameValue(text string) (result int) {
	for _, ch := range(text) {
		result += int(ch) - int('A') + 1
	}
	return
}
