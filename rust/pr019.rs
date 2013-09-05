// Problem 19
//
// 14 June 2002
//
//
// You are given the following information, but you may prefer to do some
// research for yourself.
//
//   • 1 Jan 1900 was a Monday.
//   • Thirty days has September,
//     April, June and November.
//     All the rest have thirty-one,
//     Saving February alone,
//     Which has twenty-eight, rain or shine.
//     And on leap years, twenty-nine.
//   • A leap year occurs on any year evenly divisible by 4, but not on a
//     century unless it is divisible by 400.
//
// How many Sundays fell on the first of the month during the twentieth
// century (1 Jan 1901 to 31 Dec 2000)?
//
// 171

use std::uint;

fn main() {
    let mut count = 0;
    for uint::range(1901, 2001) |year| {
        for uint::range(1, 13) |month| {
            if jdate(year, month, 1) % 7 == 6 {
                count += 1;
            }
        }
    }
    println(fmt!("%?", count));
}

// Convert to a julian date <http://en.wikipedia.org/wiki/Julian_day>
fn jdate(year: uint, month: uint, day: uint) -> uint {
    let a = (14 - month) / 12;
    let y = year + 4800 - a;
    let m = month + 12*a - 3;

    day + (153*m + 2)/5 + 365*y + y/4 - y/100 + y/400 - 32045
}
