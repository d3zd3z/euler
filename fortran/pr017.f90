! Problem 17
!
! 17 May 2002
!
! If the numbers 1 to 5 are written out in words: one, two, three,
! four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in
! total.
!
! If all the numbers from 1 to 1000 (one thousand) inclusive were
! written out in words, how many letters would be used?
!
! NOTE: Do not count spaces or hyphens. For example, 342 (three hundred
! and forty-two) contains 23 letters and 115 (one hundred and fifteen)
! contains 20 letters. The use of "and" when writing out numbers is in
! compliance with British usage.
! 21124

subroutine pr017

  implicit none

  character(len=9), dimension(19), parameter :: ones = (/ &
    'one      ', 'two      ', 'three    ', 'four     ', &
    'five     ', 'six      ', 'seven    ', 'eight    ', &
    'nine     ', 'ten      ', 'eleven   ', 'twleve   ', &
    'thirteen ', 'fourteen ', 'fifteen  ', 'sixteen  ', &
    'seventeen', 'eighteen ', 'nineteen ' /)

  character(len=7), dimension(9), parameter :: tens = (/ &
    'ten    ', 'twenty ', 'thirty ', 'forty  ', 'fifty  ', &
    'sixty  ', 'seventy', 'eighty ', 'ninety ' /)

  character(len=35) :: buffer

  integer :: i, total

  total = 0
  do i = 1, 1000
    call to_english(i, buffer)
    ! print *, "'", buffer, "' ", count_letters(buffer)
    total = total + count_letters(buffer)
  end do
  print *, total

contains

  function count_letters(text)
    ! Count the number of letters 'a'-'z' in the text.
    character(len=*), intent(in) :: text
    integer :: count_letters
    integer :: i

    count_letters = 0
    do i = 1, len(text)
      select case(text(i:i))
      case('a':'z')
        count_letters = count_letters + 1
      case default
        ! nothing
      end select
    end do
  end function count_letters

  subroutine to_english(n, text)
    ! Convert the number 'n' to an english number into text, which should have
    ! enough room to contain the result.
    implicit none
    character(len=*), intent(out) :: text
    integer, intent(in) :: n
    integer :: pos, work
    logical :: add_space

    work = n
    add_space = .false.
    text = ' '
    pos = 1

    if (work == 1000) then
      text = 'one thousand'
      return
    end if

    if (work >= 100) then
      call add(text, pos, trim(ones(work/100)), add_space)
      call add(text, pos, 'hundred', add_space)
      work = mod(work, 100)

      if (work > 0) call add(text, pos, 'and', add_space)
    end if

    if (work >= 20) then
      call add(text, pos, trim(tens(work / 10)), add_space)
      work = mod(work, 10)

      if (work > 0) then
        add_space = .false.
        call add(text, pos, '-', add_space)
        add_space = .false.
      end if
    end if

    if (work >= 1) then
      call add(text, pos, trim(ones(work)), add_space)
    end if
  end subroutine to_english

  subroutine add(text, pos, word, add_space)
    implicit none
    character(len=*), intent(inout) :: text
    character(len=*), intent(in) :: word
    integer, intent(inout) :: pos
    logical, intent(inout) :: add_space

    if (add_space) then
      text(pos:pos) = ' '
      pos = pos + 1
    end if

    text(pos:pos+len(word)-1) = word
    pos = pos + len(word)
    add_space = .true.
  end subroutine add

end subroutine pr017
