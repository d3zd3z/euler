! Problem 14
!
! 05 April 2002
!
! The following iterative sequence is defined for the set of positive
! integers:
!
! n → n/2 (n is even)
! n → 3n + 1 (n is odd)
!
! Using the rule above and starting with 13, we generate the following
! sequence:
!
! 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
!
! It can be seen that this sequence (starting at 13 and finishing at 1)
! contains 10 terms. Although it has not been proved yet (Collatz
! Problem), it is thought that all starting numbers finish at 1.
!
! Which starting number, under one million, produces the longest chain?
!
! NOTE: Once the chain starts the terms are allowed to go above one
! million.
! 837799

subroutine pr014

  implicit none

  ! Need longer integers to make this work right.
  integer, parameter :: long = selected_int_kind(13)

  integer(kind=long) :: longest, longest_value, ii, len

  ! A cache of seen values.
  ! Unless the cache is made very large, the overhead of checking the cache is
  ! larger than the improvement gained by using it.
  ! integer, parameter :: cache_size = 1000
  ! integer(kind=long), dimension(cache_size) :: cache

  ! cache = 0
  longest = 0
  longest_value = -1

  do ii = 1, 999999
    len = chain_length(ii)
    if (len > longest_value) then
      longest_value = len
      longest = ii
    end if
  end do
  print *, longest

contains

  recursive function chain_length(n) result (length)
    ! How long is this collatz chain.
    integer(kind=long), intent(in) :: n
    integer(kind=long) :: length

    ! if (n <= cache_size) then
    !   if (cache(n) > 0) then
    !     length = cache(n)
    !     return
    !   end if
    ! end if

    if (n == 1) then
      length = 1
    else
      length = 1 + chain_length(next_collatz(n))
    end if

    ! if (n <= cache_size) then
    !   cache(n) = length
    ! end if
  end function

  function next_collatz(n)
    integer(kind=long), intent(in) :: n
    integer(kind=long) :: next_collatz

    if (mod (n, 2) == 0) then
      next_collatz = n / 2
    else
      next_collatz = n * 3 + 1
    end if
  end function

end subroutine pr014
