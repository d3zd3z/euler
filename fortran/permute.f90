! Permutation utilities.

module permute

  implicit none

  private :: swap, flip
  public :: next_permutation

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

end module permute
