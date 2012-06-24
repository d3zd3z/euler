! Problem 34
!
! 03 January 2003
!
! 145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.
!
! Find the sum of all numbers which are equal to the sum of the
! factorial of their digits.
!
! Note: as 1! = 1 and 2! = 2 are not sums they are not included.
! 40730

subroutine pr034

  implicit none
  integer, dimension(0:9) :: facts
  integer :: i, total

  facts(0) = 1
  do i = 1, 9
    facts(i) = facts(i-1) * i
  end do

  ! Sum, the total, but remove 1! and 2! as per the problem description.
  total = -3

  call chain(0, 0)
  print *, total

contains

  !------------------------------------------------------------
  ! Recursively compute all of the factorials (limited by the last factorial),
  ! adding those that are equal to the sum of their digits to total.
  recursive subroutine chain(num, s)
    implicit none
    integer, intent(in) :: num, s
    integer :: base, i

    if (num > 0 .and. num == s) total = total + num

    if (num * 10 < s + facts(9)) then
      base = 0
      if (num == 0) base = 1
      do i = base, 9
        call chain(num*10 + i, s + facts(i))
      end do
    end if
  end subroutine chain

end subroutine pr034
