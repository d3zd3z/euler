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

# Julia just seems to just C's time routines, which are terrible for
# this.  So, just use the wiki julian date computation

function jdate(year, month, day)
   a = div((14 - month), 12)
   y = year + 4800 - a
   m = month + 12a - 3

   day + div(153m + 2, 5) + 365y + div(y, 4) - div(y, 100) + div(y, 400) - 32045
end

function solve()
   count = 0
   for year = 1901:2000
      for mon = 1:12
         if jdate(year, mon, 1) % 7 == 6
            count += 1
         end
      end
   end
   count
end

println(solve())
