// Problem 19
//
// 14 June 2002
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

#include <ctime>
#include <iostream>
#include <iomanip>

namespace euler {
namespace pr019 {

// C's time routines are just plain evil.  Local time gets conflated,
// and there really isn't a useful way of reliably getting this
// information.

// Instead, use the wiki info on 'Julian day' to compute that, and the
// julian day for Sunday is 6 mod 7.
int jdate(int year, int month, int day) {
  int a = (14 - month) / 12;
  int y = year + 4800 - a;
  int m = month + 12*a - 3;

  return day + (153*m + 2)/5 + 365*y + y/4 - y/100 + y/400 - 32045;
}

void solve() {
  int count = 0;
  for (int year = 1901; year <= 2000; ++year) {
    for (int mon = 1; mon <= 12; ++mon) {
      if (jdate(year, mon, 1) % 7 == 6)
	++count;
    }
  }
  std::cout << count << '\n';
}

/*
int wday(int year, int mon) {
  struct tm now;
  now.tm_sec = 0;
  now.tm_min = 0;
  now.tm_hour = 12;
  now.tm_mday = 0;
  now.tm_mon = mon - 1;
  now.tm_year = year - 1900;
  now.tm_wday = 0;
  now.tm_yday = 0;
  now.tm_isdst = 0;
  (void)mktime(&now);
  return now.tm_wday;
}

void solve()
{
  int count = 0;
  for (int year = 1901; year <= 2000; ++year) {
    for (int mon = 1; mon <= 12; ++mon) {
      std::cout << year << ' ' << std::setw(2) << mon << ' ' << wday(year, mon) << '\n';
      if (wday(year, mon) == 0)
	count++;
    }
  }
  std::cout << count << "\n";
}
*/

}
}
