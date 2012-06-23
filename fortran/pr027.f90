! Problem 27
!
! 27 September 2002
!
! Euler published the remarkable quadratic formula:
!
! n^2 + n + 41
!
! It turns out that the formula will produce 40 primes for the
! consecutive values n = 0 to 39. However, when n = 40, 40^2 + 40 + 41
! = 40(40 + 1) + 41 is divisible by 41, and certainly when n = 41, 41^2
! + 41 + 41 is clearly divisible by 41.
!
! Using computers, the incredible formula  n^2 − 79n + 1601 was
! discovered, which produces 80 primes for the consecutive values n = 0
! to 79. The product of the coefficients, −79 and 1601, is −126479.
!
! Considering quadratics of the form:
!
!     n^2 + an + b, where |a| < 1000 and |b| < 1000
!
!     where |n| is the modulus/absolute value of n
!     e.g. |11| = 11 and |−4| = 4
!
! Find the product of the coefficients, a and b, for the quadratic
! expression that produces the maximum number of primes for consecutive
! values of n, starting with n = 0.
! -59231

subroutine pr027

  use primes
  implicit none

  integer :: a, b, count, largest, largest_result

  largest = 0
  largest_result = 0

  do a = -999, 999
    do b = -999, 999
      count = count_primes(a, b)
      if (count > largest) then
        largest = count
        largest_result = a * b
      end if
    end do
  end do

  print *, largest_result

contains

  !------------------------------------------------------------
  ! Count the number of primes that the formula generates for the given 'a', and
  ! 'b', values
  function count_primes(a, b) result (n)
    implicit none
    integer, intent(in) :: a, b
    integer :: n

    integer :: p

    n = 0

    do
      p = n*n + a*n + b
      if (p <= 0) exit
      if (.not. is_prime_small(p)) exit
      n = n + 1
    end do
  end function count_primes

end subroutine pr027
