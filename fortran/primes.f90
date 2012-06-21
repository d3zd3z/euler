! Various utilities for working with prime numbers.

module primes

  implicit none
  private

  integer, dimension(:), allocatable :: all_primes
  integer :: computed = 0

  public :: primes_upto
  public :: nth_prime
  public :: compute

contains

  subroutine primes_upto (n, result)
    ! Return an array of all of the prime numbers up to (and possibly including)
    ! 'n'.
    implicit none

    integer, intent(in) :: n
    integer, dimension(:), allocatable :: result
    logical(kind=1), dimension(2:n) :: primes
    integer :: p, i

    primes = .true.
    do p = 2, n/2
      if (primes(p)) then
        primes (p+p::p) = .false.
      end if
    end do

    result = pack( (/ (i, i=2, n) /), primes)
  end subroutine primes_upto

  function nth_prime (n)
    ! Return the nth prime.
    implicit none
    integer, intent(in) :: n
    integer :: nth_prime

    call compute (n)
    nth_prime = all_primes(n)
  end function nth_prime

  subroutine compute(n)
    ! Compute primes up to n.
    implicit none
    integer, intent(in) :: n

    if (computed == 0) then
      computed = 10000
      call primes_upto(computed, all_primes)
    end if

    do while (n > ubound(all_primes, 1))
      computed = computed * 10
      call primes_upto(computed, all_primes)
    end do
  end subroutine compute

end module primes
