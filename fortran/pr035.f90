! Problem 35
!
! 17 January 2003
!
! The number, 197, is called a circular prime because all rotations of
! the digits: 197, 971, and 719, are themselves prime.
!
! There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31,
! 37, 71, 73, 79, and 97.
!
! How many circular primes are there below one million?
! 55

subroutine pr035

  use primes, only: is_prime_small
  implicit none
  integer :: i, count

  count = 0
  do i = 2, 999999
    if (is_circular_prime(i)) count = count + 1
  end do
  print *, count

contains

  !------------------------------------------------------------
  ! Determine if 'n' is a circular prime.
  function is_circular_prime(n)
    implicit none
    integer, intent(in) :: n
    logical :: is_circular_prime
    integer, dimension(6) :: rotations
    integer :: last, i

    is_circular_prime = .true.
    call number_rotations(n, rotations, last)
    do i = 1, last
      if (.not. is_prime_small(rotations(i))) is_circular_prime = .false.
    end do
  end function is_circular_prime

  !------------------------------------------------------------
  ! Fill 'rotations' will all of the numeric rotations of 'n'.  'last' will be
  ! set to how many rotations there are.
  subroutine number_rotations(n, rotations, last)
    integer, intent(in) :: n
    integer, intent(out) :: last
    integer, dimension(*), intent(inout) :: rotations
    integer :: len, highest_one, right, left, accum, nn
    integer :: new_accum, next

    len = number_of_digits(n)

    highest_one = 10 ** (len-1)
    right = highest_one
    left = 1
    accum = 0
    nn = n

    last = 0
    do while(left <= highest_one)
      new_accum = accum + left * mod(nn, 10)
      next = (nn / 10) + right * new_accum

      last = last + 1
      rotations(last) = next

      right = right / 10
      left = left * 10
      accum = new_accum
      nn = nn / 10
    end do
  end subroutine

  !------------------------------------------------------------
  ! Count how many digits the given number has.
  function number_of_digits(n)
    integer, intent(in) :: n
    integer :: number_of_digits
    integer :: temp

    temp = n
    number_of_digits = 0
    do while(temp > 0)
      number_of_digits = number_of_digits + 1
      temp = temp / 10
    end do
  end function number_of_digits

end subroutine pr035
