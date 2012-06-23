! Problem 25
!
! 30 August 2002
!
! The Fibonacci sequence is defined by the recurrence relation:
!
!     F[n] = F[n−1] + F[n−2], where F[1] = 1 and F[2] = 1.
!
! Hence the first 12 terms will be:
!
!     F[1] = 1
!     F[2] = 1
!     F[3] = 2
!     F[4] = 3
!     F[5] = 5
!     F[6] = 8
!     F[7] = 13
!     F[8] = 21
!     F[9] = 34
!     F[10] = 55
!     F[11] = 89
!     F[12] = 144
!
! The 12th term, F[12], is the first term to contain three digits.
!
! What is the first term in the Fibonacci sequence to contain 1000
! digits?
! 4782

subroutine pr025

  implicit none
  integer, dimension(999) :: a, b
  integer :: count
  logical :: overflowed

  ! Set the initial values to 1
  a = 0
  b = 0
  a(1) = 1
  b(1) = 1

  count = 3
  do
    call add(a, b, overflowed)
    if (overflowed) exit
    count = count + 1

    call add(b, a, overflowed)
    if (overflowed) exit
    count = count + 1
  end do

  print *, count

contains

  subroutine add(dest, other, overflowed)
    integer, dimension(:), intent(inout) :: dest
    integer, dimension(:), intent(in) :: other
    logical, intent(out) :: overflowed
    integer :: carry, temp, i

    carry = 0
    do i = 1, size(dest, 1)
      temp = dest(i) + other(i) + carry
      dest(i) = mod(temp, 10)
      carry = temp / 10
    end do

    overflowed = carry /= 0
  end subroutine add

end subroutine pr025
