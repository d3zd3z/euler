! Problem 32
!
! 06 December 2002
!
! We shall say that an n-digit number is pandigital if it makes use of
! all the digits 1 to n exactly once; for example, the 5-digit number,
! 15234, is 1 through 5 pandigital.
!
! The product 7254 is unusual, as the identity, 39 x 186 = 7254,
! containing multiplicand, multiplier, and product is 1 through 9
! pandigital.
!
! Find the sum of all products whose multiplicand/multiplier/product
! identity can be written as a 1 through 9 pandigital.
!
! HINT: Some products can be obtained in more than one way so be sure
! to only include it once in your sum.
! 45228

subroutine pr032

  use permute
  implicit none

  integer, dimension(9) :: num
  integer :: i
  logical :: done

  integer, dimension(7) :: seen
  integer :: nseen, total

  num = (/ (i, i=1, 9) /)

  seen = 0
  nseen = 0
  total = 0
  do
    call make_groupings(num)
    call next_permutation(num, done)
    if (done) exit
  end do

  print *, total

contains

  !------------------------------------------------------------
  ! Try grouping this number in various ways, and call 'add' on the result part
  ! of any that form a valid sum.
  subroutine make_groupings(num)
    implicit none
    integer, dimension(:), intent(in) :: num
    integer :: last
    integer :: a, b, c
    integer :: i, j

    last = size(num, 1)
    do i = 1, last - 2
      do j = i+1, last - 1
        a = value_of(num(1 : i))
        b = value_of(num(i+1 : j))
        c = value_of(num(j+1 : last))

        if (a*b == c) call add(c)
      end do
    end do

  end subroutine make_groupings

  !------------------------------------------------------------
  ! Given an array of 0-9 digit values, return the number it represents.
  function value_of(num)
    implicit none
    integer, dimension(:), intent(in) :: num
    integer :: value_of
    integer :: i

    value_of = 0
    do i = 1, size(num, 1)
      value_of = value_of * 10 + num(i)
    end do
  end function value_of

  !------------------------------------------------------------
  ! Record 'prod' as a number that is a result of this process.
  subroutine add(prod)
    implicit none
    integer, intent(in) :: prod

    if (any(seen(1:nseen) == prod)) return
    total = total + prod

    nseen = nseen + 1
    seen(nseen) = prod
  end subroutine add

end subroutine pr032
