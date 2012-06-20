! Problem 1
!
! 05 October 2001
!
! If we list all the natural numbers below 10 that are multiples of 3
! or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
!
! Find the sum of all the multiples of 3 or 5 below 1000.
! 233168

subroutine pr001

  implicit none

  integer :: i, total

  total = 0
  do i = 1, 999
    if (divides (i)) total = total + i
  end do

  print *, total

contains

  function divides (a)
    implicit none
    integer, intent(in) :: a
    logical :: divides

    divides = mod (a, 3) == 0 .or. mod (a, 5) == 0
  end function

end subroutine pr001
