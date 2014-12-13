//////////////////////////////////////////////////////////////////////
// Problem 19
//
// Published on Friday, 14th June 2002, 06:00 pm; Solved by 49458
//
// You are given the following information, but you may prefer to do
// some research for yourself.
//
//   • 1 Jan 1900 was a Monday.
//   • Thirty days has September,
//     April, June and November.
//     All the rest have thirty-one,
//     Saving February alone,
//     Which has twenty-eight, rain or shine.
//     And on leap years, twenty-nine.
//   • A leap year occurs on any year evenly divisible by 4, but not on
//     a century unless it is divisible by 400.
//
// How many Sundays fell on the first of the month during the twentieth
// century (1 Jan 1901 to 31 Dec 2000)?
//
//////////////////////////////////////////////////////////////////////
// 171

package pr019

import "fmt"
import "time"

func Run() {
	count := 0
	for year := 1901; year < 2001; year++ {
		for month := time.January; month <= time.December; month++ {
			day := time.Date(year, month, 1, 0, 0, 0, 0, time.Local)
			if day.Weekday() == time.Sunday {
				count++
			}
		}
	}
	fmt.Printf("%d\n", count)
}
