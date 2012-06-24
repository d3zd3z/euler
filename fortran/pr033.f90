! Problem 33
!
! 20 December 2002
!
! The fraction ^49/[98] is a curious fraction, as an inexperienced
! mathematician in attempting to simplify it may incorrectly believe
! that ^49/[98] = ^4/[8], which is correct, is obtained by cancelling
! the 9s.
!
! We shall consider fractions like, ^30/[50] = ^3/[5], to be trivial
! examples.
!
! There are exactly four non-trivial examples of this type of fraction,
! less than one in value, and containing two digits in the numerator
! and denominator.
!
! If the product of these four fractions is given in its lowest common
! terms, find the value of the denominator.
! 100

subroutine pr033

  use primes, only: gcd
  implicit none
  integer :: a, b, prod_n, prod_m, g

  prod_n = 1
  prod_m = 1

  do a = 10, 98
    do b = a+1, 99
      if (is_fraction(a, b)) then
        ! print *, a, b
        ! Multiple and reduce.

        prod_n = prod_n * a
        prod_m = prod_m * b

        g = gcd(prod_n, prod_m)
        if (g > 1) then
          prod_n = prod_n / g
          prod_m = prod_m / g
        end if
      end if
    end do
  end do

  print *, prod_m

contains

  !------------------------------------------------------------
  ! Return .true. if a/b forms one of the special fractions.
  function is_fraction(a, b)
    implicit none
    integer, intent(in) :: a, b
    logical :: is_fraction
    integer :: an, am, bn, bm

    an = a / 10
    am = mod(a, 10)
    bn = b / 10
    bm = mod(b, 10)

    is_fraction = ((an == bm .and. bn > 0 .and. am*b == bn*a) .or. &
      (am == bn .and. bm > 0 .and. an*b == bm*a))
  end function is_fraction

end subroutine pr033
