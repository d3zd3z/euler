! Problem 10
!
! 08 February 2002
!
! The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
!
! Find the sum of all the primes below two million.
! 142913828922

subroutine pr010

  use primes
  implicit none

  integer, parameter :: big = selected_int_kind(12)
  integer, parameter :: limit = 1999999
  integer, dimension(:), allocatable :: ps

  call primes_upto(limit, ps)
  print *, sum(int(ps, kind=big))

  ! ! Use an integer kind large enough to hold the results.
  ! integer, parameter :: big = selected_int_kind(12)
  ! integer, parameter :: limit = 1999999

  ! logical(kind=1), dimension(2:limit) :: primes
  ! integer :: p
  ! integer(kind=big) :: ii

  ! ! Sieve of eratosthenes.
  ! primes = .true.
  ! do p = 2, limit/2
  !   if (primes(p)) then
  !     primes (p+p::p) = .false.
  !   end if
  ! end do

  ! print *, sum (pack ( (/ (ii, ii=2, limit) /), primes))

end subroutine pr010
