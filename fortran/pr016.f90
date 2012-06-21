! Problem 16
!
! 03 May 2002
!
! 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
!
! What is the sum of the digits of the number 2^1000?
! 1366

subroutine pr016

  implicit none

  ! The number, in decimal notation, in "little endian" format.
  integer, dimension(400) :: result
  integer :: i

  result = 0
  result(1) = 1

  do i = 1, 1000
    call double
  end do
  print *, sum(result)

contains

  subroutine double
    ! Double the result.
    implicit none
    integer :: carry, temp, i

    carry = 0
    do i = 1, size(result)
      temp = result(i) * 2 + carry
      result(i) = mod(temp, 10)
      carry = temp / 10
    end do

    if (carry /= 0) stop "Overflow"
  end subroutine double

end subroutine pr016
