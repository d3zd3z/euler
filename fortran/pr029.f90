! Problem 29
!
! 25 October 2002
!
! Consider all integer combinations of a^b for 2 ≤ a ≤ 5 and 2 ≤ b ≤ 5:
!
!     2^2=4, 2^3=8, 2^4=16, 2^5=32
!     3^2=9, 3^3=27, 3^4=81, 3^5=243
!     4^2=16, 4^3=64, 4^4=256, 4^5=1024
!     5^2=25, 5^3=125, 5^4=625, 5^5=3125
!
! If they are then placed in numerical order, with any repeats removed,
! we get the following sequence of 15 distinct terms:
!
! 4, 8, 9, 16, 25, 27, 32, 64, 81, 125, 243, 256, 625, 1024, 3125
!
! How many distinct terms are in the sequence generated by a^b for 2 ≤
! a ≤ 100 and 2 ≤ b ≤ 100?
! 9183

subroutine pr029

  use primes
  implicit none

  ! These have been tuned down the the smallest values possible.  Will need to
  ! enlarge for larger problems.
  integer, parameter :: max_factors = 3
  integer, parameter :: max_powers = 842
  integer, parameter :: limit = 100

  type :: node
    integer, dimension(max_factors) :: primes
    integer, dimension(max_factors, max_powers) :: powers
  end type

  type(factor), dimension(:), allocatable :: factors
  integer, dimension(max_factors) :: tmp_primes, tmp_powers
  type(node), dimension(limit) :: nodes
  integer :: a, b, total, n, p

  total = 0

  ! Clear out the nodes.
  do a = 1, limit
    nodes(a)%primes = 0
    nodes(a)%powers = 0
  end do

  ! Update each node.
  do a = 2, limit
    call factorize(a, factors)
    if (size(factors, 1) > max_factors) stop "max_factors too small"
    call factor_sort(factors)

    tmp_primes = 0
    tmp_primes(1:size(factors, 1)) = factors%prime
    tmp_powers = 0
    tmp_powers(1:size(factors, 1)) = factors%power

    ! Find the node with this set of primes.
    n = 1
    do
      if (n > limit) stop "Shouldn't happen"
      if (nodes(n)%primes(1) == 0) then
        ! Must create a new node.
        nodes(n)%primes = tmp_primes
        exit
      end if
      if (all(tmp_primes == nodes(n)%primes)) exit
      n = n + 1
    end do

    do b = 2, limit
      tmp_powers = 0
      tmp_powers(1:size(factors, 1)) = factors%power * b

      !Search for this power.
      p = 1
      do
        if (p > max_powers) stop "max_powers too small"
        if (nodes(n)%powers(1, p) == 0) then
          ! New value
          total = total + 1
          nodes(n)%powers(:, p) = tmp_powers
        end if
        if (all(tmp_powers == nodes(n)%powers(:, p))) exit
        p = p + 1
      end do
    end do
  end do

  print *, total

contains

  !------------------------------------------------------------
  ! An insertion sort on factors.
  subroutine factor_sort(items)
    type(factor), dimension(:) :: items

    type(factor) :: item
    integer :: i, ihole

    do i = 2, size(items, 1)
      item = items(i)
      ihole = i

      do
        if (ihole < 2) exit
        if (items(ihole-1)%prime <= item%prime) exit

        items(ihole) = items(ihole-1)
        ihole = ihole - 1
      end do

      items(ihole) = item
    end do

  end subroutine factor_sort

end subroutine pr029
