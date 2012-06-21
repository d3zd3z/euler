! Problem 15
!
! 19 April 2002
!
! Starting in the top left corner of a 2x2 grid, there are 6 routes
! (without backtracking) to the bottom right corner.
!
! [p_015]
!
! How many routes are there through a 20x20 grid?
! 137846528820

subroutine pr015

  implicit none

  integer, parameter :: long = selected_int_kind(11)
  integer, parameter :: steps = 20
  integer(kind=long), dimension(steps+1) :: values
  integer :: i

  values = 1
  do i = 1, steps
    call bump
  end do
  print *, values(steps+1)

contains

  subroutine bump
    implicit none
    integer :: i

    do i = 1, steps
      values(i+1) = values(i+1) + values(i)
    end do
  end subroutine

end subroutine pr015
