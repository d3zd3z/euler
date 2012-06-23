! Problem 28
!
! 11 October 2002
!
! Starting with the number 1 and moving to the right in a clockwise
! direction a 5 by 5 spiral is formed as follows:
!
! 21 22 23 24 25
! 20  7  8  9 10
! 19  6  1  2 11
! 18  5  4  3 12
! 17 16 15 14 13
!
! It can be verified that the sum of the numbers on the diagonals is
! 101.
!
! What is the sum of the numbers on the diagonals in a 1001 by 1001
! spiral formed in the same way?
! 669171001

subroutine pr028

  implicit none
  integer :: a, sum

  ! Account for the 1 in the center.
  sum = 1

  do a = 3, 1001, 2
    sum = sum + ring_sum(a)
  end do

  print *, sum

contains

  function ring_sum(n)
    implicit none
    integer, intent(in) :: n
    integer :: ring_sum

    ring_sum = 4*n*n - 6*n + 6
  end function ring_sum

end subroutine pr028
