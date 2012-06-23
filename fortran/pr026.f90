! Problem 26
!
! 13 September 2002
!
! A unit fraction contains 1 in the numerator. The decimal
! representation of the unit fractions with denominators 2 to 10 are
! given:
!
!     ^1/[2]  =  0.5
!     ^1/[3]  =  0.(3)
!     ^1/[4]  =  0.25
!     ^1/[5]  =  0.2
!     ^1/[6]  =  0.1(6)
!     ^1/[7]  =  0.(142857)
!     ^1/[8]  =  0.125
!     ^1/[9]  =  0.(1)
!     ^1/[10] =  0.1
!
! Where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle. It
! can be seen that ^1/[7] has a 6-digit recurring cycle.
!
! Find the value of d < 1000 for which ^1/[d] contains the longest
! recurring cycle in its decimal fraction part.
! 983

subroutine pr026

  ! For a given number n, the repeat length of 1/n is the solution to 'k' for
  ! 10**k = 1 (mod n)
  ! The function 'tenlog' below solves this for a given value of 'n'.
  ! For a composite number, the length will merely be the longest length of any
  ! of its factors, so there really isn't a need to test the composite values
  ! (although it wouldn't hurt anything either).  However, the 'tenlog' function
  ! will fail to terminate if the value passed has 2 or 5 as factors, so this
  ! would have to be accounted for.

  use primes
  implicit none

  integer :: p, prime, size
  integer :: largest, largest_value

  largest = 0
  largest_value = 0

  p = 4
  prime = 7
  do while(prime < 1000)
    size = tenlog(prime)
    if (size > largest) then
      largest = size
      largest_value = prime
    end if

    p = p + 1
    prime = nth_prime(p)
  end do

  print *, largest_value

contains

  function tenlog(n)
    implicit none
    integer, intent(in) :: n
    integer tenlog

    ! Compute the value 'k'  for 10**k = 1 (mod n).
    ! Must not be called for an 'n' that divides into 10, or it will not
    ! terminate.

    integer :: temp

    tenlog = 1
    temp = mod(10, n)

    do while(temp /= 1)
      tenlog = tenlog + 1
      temp = mod(temp * 10, n)
    end do
  end function tenlog

end subroutine pr026
