! Problem 31
!
! 22 November 2002
!
! In England the currency is made up of pound, -L-, and pence, p, and
! there are eight coins in general circulation:
!
!     1p, 2p, 5p, 10p, 20p, 50p, -L-1 (100p) and -L-2 (200p).
!
! It is possible to make -L-2 in the following way:
!
!     1x-L-1 + 1x50p + 2x20p + 1x5p + 1x2p + 3x1p
!
! How many different ways can -L-2 be made using any number of coins?
! 73682

subroutine pr031

  implicit none

  integer, dimension(*), parameter :: coins = &
    (/ 200, 100, 50, 20, 10, 5, 2, 1 /)

  print *, find_ways(200, coins)

contains

  recursive function find_ways(remaining, coins_left) result (ways)
    implicit none
    integer, intent(in) :: remaining
    integer, dimension(:), intent(in) :: coins_left
    integer :: ways

    integer :: left

    if (size(coins_left, 1) == 0) then
      if (remaining == 0) then
        ways = 1
      else
        ways = 0
      end if
      return
    end if

    left = remaining
    ways = 0
    do while(left >= 0)
      ways = ways + find_ways(left, coins_left(2:))
      left = left - coins_left(1)
    end do

  end function find_ways

end subroutine pr031
