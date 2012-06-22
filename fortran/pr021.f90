! Problem 21
!
! 05 July 2002
!
! Let d(n) be defined as the sum of proper divisors of n (numbers less
! than n which divide evenly into n).
! If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable
! pair and each of a and b are called amicable numbers.
!
! For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20,
! 22, 44, 55 and 110; therefore d(220) = 284. The proper divisors of
! 284 are 1, 2, 4, 71 and 142; so d(284) = 220.
!
! Evaluate the sum of all the amicable numbers under 10000.
! 31626

subroutine pr021

  use primes
  implicit none

  integer :: i, total

  total = 0
  do i = 1, 9999
    if (is_amicable(i)) total = total + i
  end do
  print *, total

contains

  function proper_div_sum(n)
    implicit none
    integer, intent(in) :: n
    integer :: proper_div_sum

    integer, dimension(:), allocatable :: divs

    call divisors(n, divs)
    proper_div_sum = sum(divs) - n
  end function proper_div_sum

  function is_amicable(a)
    implicit none
    integer, intent(in) :: a
    logical :: is_amicable
    integer :: b, c

    is_amicable = .false.
    b = proper_div_sum(a)
    if (a == b .or. b == 0) return

    c = proper_div_sum(b)
    is_amicable = (a == c)
  end function is_amicable

end subroutine pr021
