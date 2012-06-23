! Various utilities for working with prime numbers.

module primes

  implicit none
  private

  integer, dimension(:), allocatable :: all_primes
  integer :: computed = 0

  type, public :: factor
    integer :: prime, power
  end type

  type :: varray
    integer, dimension(:), allocatable :: items
    integer :: length
  end type

  public :: primes_upto
  public :: nth_prime
  public :: compute
  public :: factorize
  public :: divisors
  public :: proper_div_sum

  private :: va_append, va_init, va_get

contains

  subroutine primes_upto (n, result)
    ! Return an array of all of the prime numbers up to (and possibly including)
    ! 'n'.
    implicit none

    integer, intent(in) :: n
    integer, dimension(:), allocatable :: result
    logical(kind=1), dimension(2:n) :: primes
    integer :: p, i

    primes = .true.
    do p = 2, n/2
      if (primes(p)) then
        primes (p+p::p) = .false.
      end if
    end do

    result = pack( (/ (i, i=2, n) /), primes)
  end subroutine primes_upto

  function nth_prime (n)
    ! Return the nth prime.
    implicit none
    integer, intent(in) :: n
    integer :: nth_prime

    call compute (n)
    nth_prime = all_primes(n)
  end function nth_prime

  subroutine compute(n)
    ! Compute primes up to n.
    implicit none
    integer, intent(in) :: n

    if (computed == 0) then
      computed = 10000
      call primes_upto(computed, all_primes)
    end if

    do while (n > ubound(all_primes, 1))
      computed = computed * 10
      call primes_upto(computed, all_primes)
    end do
  end subroutine compute

  subroutine factorize(n, factors)
    ! Compute the prime factors of the given number.
    implicit none
    integer, intent(in) :: n
    type(factor), dimension(:), allocatable, intent(out) :: factors
    type(varray) :: primes, counts
    integer :: pindex, p, temp, count

    call va_init(primes)
    call va_init(counts)
    pindex = 1
    p = 2
    temp = n
    count = 0

    do while(temp > 1)
      if (mod(temp, p) == 0) then
        temp = temp / p
        count = count + 1
      else
        if (count > 0) then
          call va_append(primes, p)
          call va_append(counts, count)
          count = 0
        end if

        pindex = pindex + 1
        p = nth_prime(pindex)
      end if
    end do

    if (count > 0) then
      call va_append(primes, p)
      call va_append(counts, count)
    end if

    allocate(factors(primes%length))
    factors%prime = va_get(primes)
    factors%power = va_get(counts)
  end subroutine factorize

  subroutine divisors(n, divs)
    ! Compute the divisors.
    implicit none
    integer, intent(in) :: n
    integer, dimension(:), allocatable, intent(out) :: divs
    type(factor), dimension(:), allocatable :: factors
    type(varray) :: vec

    call factorize(n, factors)
    call va_init(vec)
    call spread_factors(factors, vec)
    divs = va_get(vec)
  end subroutine divisors

  recursive subroutine spread_factors(factors, vec)
    ! Spread out the given factors into a list of divisors in vec.
    ! vec should already be initialized.
    ! TODO: Should the result be sorted?
    implicit none
    type(factor), dimension(:), intent(in) :: factors
    type(varray), intent(inout) :: vec
    type(varray) :: rest_vec
    integer, dimension(:), allocatable :: rest
    type(factor) :: x
    integer :: i, j, power

    if (size(factors, 1) == 0) then
      call va_append(vec, 1)
      return
    end if

    call va_init(rest_vec)
    x = factors(1)
    call spread_factors(factors(2:), rest_vec)
    rest = va_get(rest_vec)
    power = 1
    do i = 0, x%power
      do j = 1, size(rest, 1)
        call va_append(vec, rest(j) * power)
      end do

      if (i < x%power) power = power * x%prime
    end do

  end subroutine spread_factors

  function proper_div_sum(n)
    implicit none
    integer, intent(in) :: n
    integer :: proper_div_sum

    integer, dimension(:), allocatable :: divs

    call divisors(n, divs)
    proper_div_sum = sum(divs) - n
  end function proper_div_sum

  subroutine va_init(v)
    implicit none
    type(varray), intent(inout) :: v

    allocate(v%items(8))
    v%length = 0
  end subroutine va_init

  subroutine va_append(va, n)
    implicit none
    type(varray), intent(inout) :: va
    integer, dimension(:), allocatable :: tmp
    integer, intent(in) :: n

    if (va%length >= size(va%items, 1)) then
      allocate(tmp(2*size(va%items, 1)))
      tmp(:size(va%items, 1)) = va%items
      call move_alloc(tmp, va%items)
    end if

    va%length = va%length + 1
    va%items(va%length) = n
  end subroutine va_append

  function va_get(va)
    implicit none
    type(varray), intent(in) :: va
    integer, dimension(va%length) :: va_get

    va_get = va%items(:va%length)
  end function va_get

end module primes
