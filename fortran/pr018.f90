! Problem 18
!
! 31 May 2002
!
! By starting at the top of the triangle below and moving to adjacent
! numbers on the row below, the maximum total from top to bottom is 23.
!
! 3
! 7 4
! 2 4 6
! 8 5 9 3
!
! That is, 3 + 7 + 4 + 9 = 23.
!
! Find the maximum total from top to bottom of the triangle below:
!
! 75
! 95 64
! 17 47 82
! 18 35 87 10
! 20 04 82 47 65
! 19 01 23 75 03 34
! 88 02 77 73 07 63 67
! 99 65 04 28 06 16 70 92
! 41 41 26 56 83 40 80 70 33
! 41 48 72 33 47 32 37 16 94 29
! 53 71 44 65 25 43 91 52 97 51 14
! 70 11 33 28 77 73 17 78 39 68 17 57
! 91 71 52 38 17 14 91 43 58 50 27 29 48
! 63 66 04 68 89 53 67 30 73 16 69 87 40 31
! 04 62 98 27 23 09 70 98 73 93 38 53 60 04 23
!
! NOTE: As there are only 16384 routes, it is possible to solve this
! problem by trying every route. However, Problem 67, is the same
! challenge with a triangle containing one-hundred rows; it cannot be
! solved by brute force, and requires a clever method! ;o)
! 1074
! 67: 7273

subroutine pr018

  implicit none

  type :: line
    integer, dimension(:), allocatable :: n
  end type

  type(line), dimension(15) :: triangle
  type(line), dimension(100) :: triangle67

  integer :: i

  triangle( 1)%n = (/ 75 /)
  triangle( 2)%n = (/ 95, 64 /)
  triangle( 3)%n = (/ 17, 47, 82 /)
  triangle( 4)%n = (/ 18, 35, 87, 10 /)
  triangle( 5)%n = (/ 20, 04, 82, 47, 65 /)
  triangle( 6)%n = (/ 19, 01, 23, 75, 03, 34 /)
  triangle( 7)%n = (/ 88, 02, 77, 73, 07, 63, 67 /)
  triangle( 8)%n = (/ 99, 65, 04, 28, 06, 16, 70, 92 /)
  triangle( 9)%n = (/ 41, 41, 26, 56, 83, 40, 80, 70, 33 /)
  triangle(10)%n = (/ 41, 48, 72, 33, 47, 32, 37, 16, 94, 29 /)
  triangle(11)%n = (/ 53, 71, 44, 65, 25, 43, 91, 52, 97, 51, 14 /)
  triangle(12)%n = (/ 70, 11, 33, 28, 77, 73, 17, 78, 39, 68, 17, 57 /)
  triangle(13)%n = (/ 91, 71, 52, 38, 17, 14, 91, 43, 58, 50, 27, 29, 48 /)
  triangle(14)%n = (/ 63, 66, 04, 68, 89, 53, 67, 30, 73, 16, 69, 87, 40, 31 /)
  triangle(15)%n = (/ 04, 62, 98, 27, 23, 09, 70, 98, 73, 93, 38, 53, 60, 04, 23 /)

  do i = 14, 1, -1
    call fold(triangle(i)%n, triangle(i+1)%n)
  end do
  print *, triangle(1)%n

  ! Solve number 67 while we're at it.
  print *, "Problem:", 67
  open(10, file='../haskell/triangle.txt', action='read')
  do i = 1, 100
    allocate (triangle67(i)%n(i))
    read (10, *) triangle67(i)%n
  end do
  close(10)

  do i = 99, 1, -1
    call fold(triangle67(i)%n, triangle67(i+1)%n)
  end do
  print *, triangle67(1)%n

contains

  subroutine fold(a, b)
    ! Fold two rows together in the table.  size(b) must be size(a)+1.
    implicit none
    integer, dimension(:), intent(in) :: b
    integer, dimension(:), intent(inout) :: a
    integer :: i

    if (size(a)+1 /= size(b)) stop "Invalid sizes"

    do i = size(a), 1, -1
      if (b(i) > b(i+1)) then
        a(i) = a(i) + b(i)
      else
        a(i) = a(i) + b(i+1)
      end if
    end do

  end subroutine fold

end subroutine pr018
