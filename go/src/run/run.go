package main

import (
	"fmt"
	"os"
	"strconv"
)

func main() {
	args := os.Args[1:]

	if len(args) == 0 {
		fmt.Printf("Usage: run n n n  or run all\n")
		return
	}

	if len(args) == 1 && args[0] == "all" {
		for _, p := range problems {
			run(p)
		}
	} else {
		toRun := make([]Problem, 0)

		for _, arg := range args {
			num, err := strconv.ParseInt(arg, 10, 0)
			if err != nil {
				fmt.Printf("Invalid number format: %q: %s\n", arg, err)
				return
			}

			p, ok := byNum[int(num)]
			if !ok {
				fmt.Printf("Unknown problem number: %q\n", arg)
				return
			}

			toRun = append(toRun, p)
		}

		for _, prob := range toRun {
			run(prob)
		}
	}
}

func run(p Problem) {
	fmt.Printf("%d: ", p.Number)
	p.Run()
}

type Problem struct {
	Number int
	Run    func ()
}

var byNum map[int]Problem

func init() {
	byNum = make(map[int]Problem)

	for _, p := range problems {
		byNum[p.Number] = p
	}
}
