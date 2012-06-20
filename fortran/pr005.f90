! Problem 5
!
! 30 November 2001
!
! 2520 is the smallest number that can be divided by each of the
! numbers from 1 to 10 without any remainder.
!
! What is the smallest positive number that is evenly divisible by all
! of the numbers from 1 to 20?
! 232792560

program pr005

  implicit none
  integer :: result, i

  result = 1
  do i = 2, 20
    result = lcm (result, i)
  end do

  print *, result

contains

  function lcm (a, b)
    implicit none
    integer, intent(in) :: a, b
    integer :: lcm

    lcm = (a / gcd (a, b)) * b
  end function

  function gcd (a, b)
    implicit none
    integer, intent(in) :: a, b
    integer gcd
    integer aa, bb, tmp

    aa = a
    bb = b
    do while (bb /= 0)
      tmp = bb
      bb = mod (aa, bb)
      aa = tmp
    end do

    gcd = aa
  end function

  ! gfortran doesn't appear to do tail recursion, so this is just for historical
  ! purposes.
  recursive function rgcd (a, b) result (result)
    implicit none
    integer, intent(in) :: a, b
    integer result

    if (b == 0) then
      result = a
    else
      result = rgcd (b, mod (a, b))
    end if
  end function

end program pr005
