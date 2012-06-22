! Problem 19
!
! 14 June 2002
!
! You are given the following information, but you may prefer to do
! some research for yourself.
!
!   • 1 Jan 1900 was a Monday.
!   • Thirty days has September,
!     April, June and November.
!     All the rest have thirty-one,
!     Saving February alone,
!     Which has twenty-eight, rain or shine.
!     And on leap years, twenty-nine.
!   • A leap year occurs on any year evenly divisible by 4, but not on
!     a century unless it is divisible by 400.
!
! How many Sundays fell on the first of the month during the twentieth
! century (1 Jan 1901 to 31 Dec 2000)?
! 171

subroutine pr019

  implicit none

  integer :: y, m, count

  count = 0
  do y = 1901, 2000
    do m = 1, 12
      if (mod(jdate(y, m, 1), 7) == 6) count = count + 1
    end do
  end do
  print *, count

contains

  ! This formula is taken from the wikipedia
  ! <http://en.wikipedia.org/wiki/Julian_day>
  function jdate(year, month, day)
    ! Compute julian date for a given y/m/d input date.
    integer, intent(in) :: year, month, day
    integer :: jdate
    integer :: a, y, m

    a = (14 - month) / 12
    y = year + 4800 - a
    m = month + 12*a - 3

    jdate = day + (153*m + 2)/5 + 365*y + y/4 - y/100 + y/400 - 32045
  end function jdate

end subroutine pr019
