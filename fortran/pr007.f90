! Problem 7
!
! 28 December 2001
!
! By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we
! can see that the 6th prime is 13.
!
! What is the 10 001st prime number?
! 104743

program pr007

  implicit none

  logical, allocatable, dimension(:) :: primes
  integer, allocatable, dimension(:) :: base, results
  integer :: k, last

  call expecting (80000)
  base = (/ (k, k = lbound (primes, 1), ubound (primes, 1)) /)
  results = pack (base, primes)
  last = count (primes)
  if (last < 10001) then
    stop "Expected size insufficient"
  end if
  write (*, '(I0)') results (10001)

contains

  ! Make sure that the primes array contains at least enough elements for
  ! 'num'.
  subroutine expecting (num)
    implicit none
    integer, intent(in) :: num
    logical :: generate
    integer :: p

    generate = .false.
    if (.not. allocated (primes)) then
      generate = .true.
    else if (num > ubound (primes, 1)) then
      deallocate (primes)
      generate = .true.
    end if

    if (generate) then
      allocate (primes (1 : get_size (num)))
      primes = .true.
      primes (1) = .false.  ! Not really true.

      p = 2
      ! do p = 2, int (sqrt (real (num)))
      do p = 2, num / 2
        primes (p+p::p) = .false.
      end do
    end if;

  end subroutine expecting

  integer function get_size (num)
    implicit none
    integer, intent(in) :: num

    get_size = 128
    do while (get_size <= num)
      get_size = get_size * 8
    end do
  end function get_size

end program pr007
