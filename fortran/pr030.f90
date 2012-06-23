! Problem 30
!
! 08 November 2002
!
! Surprisingly there are only three numbers that can be written as the
! sum of fourth powers of their digits:
!
!     1634 = 1^4 + 6^4 + 3^4 + 4^4
!     8208 = 8^4 + 2^4 + 0^4 + 8^4
!     9474 = 9^4 + 4^4 + 7^4 + 4^4
!
! As 1 = 1^4 is not a sum it is not included.
!
! The sum of these numbers is 1634 + 8208 + 9474 = 19316.
!
! Find the sum of all the numbers that can be written as the sum of
! fifth powers of their digits.
! 443839

subroutine pr030

  implicit none

  integer :: total, i
  integer, parameter :: power = 5

  total = 0
  do i = 2, largest_number(power)
    if (digit_power_sum(i, power) == i) total = total + i
  end do
  print *, total

contains

  !------------------------------------------------------------
  ! Return the sum of each digit raised to the given power.
  function digit_power_sum(n, power)
    implicit none
    integer, intent(in) :: n, power
    integer :: digit_power_sum

    integer :: temp

    digit_power_sum = 0
    temp = n
    do while(temp > 0)
      digit_power_sum = digit_power_sum + (mod (temp, 10) ** power)
      temp = temp / 10
    end do
  end function digit_power_sum

  !------------------------------------------------------------
  ! Estimate the largest number that can work for a given power.
  function largest_number(power)
    implicit none
    integer, intent(in) :: power
    integer largest_number

    integer :: total

    largest_number = 9
    do
      total = digit_power_sum(largest_number, power)
      if (largest_number > total) exit
      largest_number = largest_number * 10 + 9
    end do
  end function largest_number

end subroutine pr030
