# Problem 19
#
# 14 June 2002
#
#
# You are given the following information, but you may prefer to do some
# research for yourself.
#
#   • 1 Jan 1900 was a Monday.
#   • Thirty days has September,
#     April, June and November.
#     All the rest have thirty-one,
#     Saving February alone,
#     Which has twenty-eight, rain or shine.
#     And on leap years, twenty-nine.
#   • A leap year occurs on any year evenly divisible by 4, but not on a
#     century unless it is divisible by 400.
#
# How many Sundays fell on the first of the month during the twentieth
# century (1 Jan 1901 to 31 Dec 2000)?
#
# 171

import times

proc solve =
  var count = 0
  var now = getGMTime(fromSeconds(0))
  now.hour = 12  # Middle of day to prevent problems.  This still
                 # seems to grab the current time zone.
  now.monthday = 1

  for year in 1901 .. 2000:
    now.year = year
    for month in Month:
      now.month = month
      let tt = getGMTime(timeInfoToTime(now))
      if tt.weekday == dSun:
        inc(count)
  echo count

when isMainModule:
  solve()
