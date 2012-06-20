! Problem 3
!
! 02 November 2001
!
! The prime factors of 13195 are 5, 7, 13 and 29.
!
! What is the largest prime factor of the number 600851475143 ?
! 6857

! No reason to get complex with primes, yet.

program pr003

  implicit none

  integer, parameter :: long = selected_int_kind(12)

  integer (kind=long) :: base, step

  base = 600851475143_long
  step = 2

  outer : do
    inner : do while (mod (base, step) == 0)
      base = base / step
    end do inner

    if (base == 1) exit outer

    if (step == 2) then
      step = 3
    else
      step = step + 2
    end if
  end do outer

  print *, step

end program pr003
