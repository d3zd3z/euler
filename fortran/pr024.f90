! Problem 24
!
! 16 August 2002
!
! A permutation is an ordered arrangement of objects. For example, 3124
! is one possible permutation of the digits 1, 2, 3 and 4. If all of
! the permutations are listed numerically or alphabetically, we call it
! lexicographic order. The lexicographic permutations of 0, 1 and 2
! are:
!
! 012   021   102   120   201   210
!
! What is the millionth lexicographic permutation of the digits 0, 1,
! 2, 3, 4, 5, 6, 7, 8 and 9?
! 2783915460

subroutine pr024

  implicit none

  integer, dimension(10) :: num
  logical :: done
  integer :: i

  num = (/ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 /)

  do i = 2, 1000000
    call next_permutation(num, done)
    if (done) stop "Out of permutations"
  end do
  print '(10i1)', num

contains

  ! Compute the next lexicographic permutation of the given array.  'done' will
  ! be set to true if the numbers are already arranged in the largest
  ! permutation.
  subroutine next_permutation(items, done)
    integer, dimension(:), intent(inout) :: items
    logical, intent(out) :: done
    integer :: last

    integer :: k, l, x

    last = size(items, 1)

    k = 0
    do x = 1, size(items, 1)-1
      if (items(x) < items(x+1)) k = x
    end do
    if (k < 1) then
      done = .true.
      return
    end if

    l = 0
    do x = k+1, last
      if (items(k) < items(x)) l = x
    end do

    call swap(items, k, l)
    call flip(items, k+1, last)

    done = .false.
  end subroutine next_permutation

  ! Swap the elements at a, and b.
  subroutine swap(items, a, b)
    integer, dimension(:), intent(inout) :: items
    integer, intent(in) :: a, b
    integer :: tmp

    tmp = items(a)
    items(a) = items(b)
    items(b) = tmp
  end subroutine swap

  ! Reverse the sequence fro a to b.
  subroutine flip(items, a, b)
    integer, dimension(:), intent(inout) :: items
    integer, intent(in) :: a, b
    integer :: aa, bb

    aa = a
    bb = b
    do while(aa < bb)
      call swap(items, aa, bb)
      aa = aa + 1
      bb = bb - 1
    end do
  end subroutine flip

end subroutine pr024
