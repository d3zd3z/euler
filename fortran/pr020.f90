! Problem 20
!
! 21 June 2002
!
! n! means n x (n − 1) x ... x 3 x 2 x 1
!
! For example, 10! = 10 x 9 x ... x 3 x 2 x 1 = 3628800,
! and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0
! + 0 = 27.
!
! Find the sum of the digits in the number 100!
! 648

subroutine pr020

  implicit none

  ! Represent the number in base 10000 to make the multiplications easier.
  integer, parameter :: base = 10000
  integer, dimension(40) :: accumulator
  integer :: i

  accumulator = 0
  accumulator(1) = 1

  do i = 2, 100
    call multiply(i)
  end do

  print *, sum(digit_sum(accumulator))

contains

  subroutine multiply(by)
    ! Multiply the accumulator by the given constant.
    implicit none
    integer, intent(in) :: by
    integer :: temp, carry, i

    carry = 0
    do i = 1, size(accumulator, 1)
      temp = accumulator(i) * by + carry
      accumulator(i) = mod(temp, base)
      carry = temp / base
    end do

    if (carry /= 0) stop "Overflow"
  end subroutine multiply

  elemental function digit_sum(num)
    implicit none
    integer, intent(in) :: num
    integer :: digit_sum
    integer :: tmp

    digit_sum = 0
    tmp = num
    do while(tmp /= 0)
      digit_sum = digit_sum + mod(tmp, 10)
      tmp = tmp / 10
    end do
  end function digit_sum

end subroutine pr020
