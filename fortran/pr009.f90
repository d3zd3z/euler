! Problem 9
!
! 25 January 2002
!
! A Pythagorean triplet is a set of three natural numbers, a < b < c,
! for which,
!
! a^2 + b^2 = c^2
!
! For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.
!
! There exists exactly one Pythagorean triplet for which a + b + c =
! 1000.
! Find the product abc.
! 31875000

! This particular problem is small enough that we can easily just do a brute
! force search.

subroutine pr009

  implicit none

  integer :: a, b, c

  do a = 1, 999
    do b = a, 1000 - a
      c = 1000 - a - b
      if (a*a + b*b == c*c) print *, (a*b*c)
    end do
  end do

end subroutine pr009
