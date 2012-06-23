! Problem 22
!
! 19 July 2002
!
! Using names.txt (right click and 'Save Link/Target As...'), a 46K
! text file containing over five-thousand first names, begin by sorting
! it into alphabetical order. Then working out the alphabetical value
! for each name, multiply this value by its alphabetical position in
! the list to obtain a name score.
!
! For example, when the list is sorted into alphabetical order, COLIN,
! which is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the
! list. So, COLIN would obtain a score of 938 x 53 = 49714.
!
! What is the total of all the name scores in the file?
! 871198282

subroutine pr022

  implicit none

  ! The dimension here had to be computed by hand.
  character(len=12), dimension(6000) :: names
  integer :: stat, last
  character(len=47000) :: line
  integer :: i, total

  line = repeat(' ', len(line))
  open (10, file="../haskell/names.txt", action='read')
  read (10, iostat=stat, fmt='(a)') line
  if (stat /= 0) stop "Read error"

  names = repeat(' ', len(names))
  read (line, iostat=stat, fmt=*) names
  last = count_names()

  call sort(names(:last))
  total = 0
  do i = 1, last
    total = total + i * name_value(names(i))
  end do
  print *, total

contains

  function count_names()
    implicit none
    integer :: count_names

    count_names = 0
    do while(count_names < size(names, 1))
      if (names(count_names+1)(1:1) == ' ') exit
      count_names = count_names + 1
    end do
  end function count_names

  ! An insertion sort.
  subroutine sort(names)
    character(len=12), dimension(:), intent(inout) :: names
    character(len=12) :: item
    integer :: i, ihole

    do i = 2, size(names, 1)
      item = names(i)
      ihole = i

      do
        if (ihole < 2) exit
        if (lle(names(ihole-1), item)) exit

        names(ihole) = names(ihole-1)
        ihole = ihole - 1
      end do

      names(ihole) = item
    end do
  end subroutine sort

  elemental function name_value(name)
    character(len=12), intent(in) :: name
    integer name_value
    integer i

    name_value = 0
    do i = 1, 12
      select case (name(i:i))
      case('A':'Z')
        name_value = name_value + iachar(name(i:i)) - iachar('A') + 1
      case default
      end select
    end do
  end function name_value

end subroutine pr022
