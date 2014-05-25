! Problem 19
!
! 14 June 2002
!
!
! You are given the following information, but you may prefer to
! do some research for yourself.
!
!   • 1 Jan 1900 was a Monday.
!   • Thirty days has September,
!     April, June and November.
!     All the rest have thirty-one,
!     Saving February alone,
!     Which has twenty-eight, rain or shine.
!     And on leap years, twenty-nine.
!   • A leap year occurs on any year evenly divisible by 4, but
!     not on a century unless it is divisible by 400.
!
! How many Sundays fell on the first of the month during the
! twentieth century (1 Jan 1901 to 31 Dec 2000)?
!
! 171

USING:
    calendar
    io
    kernel
    math
    math.ranges
    sequences
    ;
IN: euler.pr019

: 1st-sundays/year ( year -- n )
    12 [1,b] [ 1 <date> sunday? ] with count ;

: solve019 ( -- n )
    1901 2000 [a,b] [ 1st-sundays/year ] [ + ] map-reduce ;
MAIN: solve019
