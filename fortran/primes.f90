! Various utilities for working with prime numbers.

module primes

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

end module primes
