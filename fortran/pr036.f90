! Problem 36
!
! 31 January 2003
!
! The decimal number, 585 = 1001001001[2] (binary), is palindromic in
! both bases.
!
! Find the sum of all numbers, less than one million, which are
! palindromic in base 10 and base 2.
!
! (Please note that the palindromic number, in either base, may not
! include leading zeros.)
! 872187

subroutine pr036

  implicit none
  integer :: i, sum

  sum = 0
  do i = 1, 999999
    if (is_palindrome(i, 2) .and. is_palindrome(i, 10)) then
      sum = sum + i
    end if
  end do

  print *, sum

contains

  function is_palindrome(n, base)
    implicit none
    integer, intent(in) :: n, base
    logical :: is_palindrome

    is_palindrome = n == reverse_digits(n, base)
  end function is_palindrome

  function reverse_digits(n, base)
    implicit none
    integer, intent(in) :: n, base
    integer :: reverse_digits

    integer :: tmp

    reverse_digits = 0
    tmp = n
    do while(tmp > 0)
      reverse_digits = reverse_digits * base + mod (tmp, base)
      tmp = tmp / base
    end do
  end function reverse_digits

end subroutine pr036
