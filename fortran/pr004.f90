! Problem 4
!
! 16 November 2001
!
! A palindromic number reads the same both ways. The largest palindrome
! made from the product of two 2-digit numbers is 9009 = 91 x 99.
!
! Find the largest palindrome made from the product of two 3-digit
! numbers.
! 906609

program pr004

  implicit none
  integer :: a, b, c, largest

  largest = -1
  do a = 100, 999
    do b = a, 999
      c = a * b
      if (is_palindrome (c)) largest = max (largest, c)
    end do
  end do

  print *, largest

contains

  function is_palindrome (n)

    implicit none
    integer, intent(in) :: n
    logical :: is_palindrome

    is_palindrome = n == reverse_digits (n)

  end function

  function reverse_digits (n)

    implicit none
    integer, intent(in) :: n
    integer :: reverse_digits
    integer :: tmp

    reverse_digits = 0
    tmp = n
    do while (tmp > 0)
      reverse_digits = reverse_digits * 10 + mod (tmp, 10)
      tmp = tmp / 10
    end do

  end function

end program pr004
