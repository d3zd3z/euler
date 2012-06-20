! Driver for all of the project euler problems.

program main

  use problems
  implicit none

  integer :: count, i, j, length, num
  logical :: hit
  character(len=32) :: arg

  call init()

  count = command_argument_count()

  if (count == 0) then
    stop "Usage: main {n [n [n]] | 'all'}"
  end if

  do i = 1, count
    call get_command_argument(i, arg, length)
    if (arg(:length) == 'all') then
      do j = 1, size(all_problems)
        print *, "Problem: ", j
        call all_problems(j)%exec
      end do
    else
      read (arg(:length), *), num
      print *, "Problem:", num

      hit = .false.
      do j = 1, size(all_problems)
        if (all_problems(j)%index == num) then
          call all_problems(j)%exec
          hit = .true.
        end if
      end do
      if (.not. hit) then
        print *, "*** not found ***"
      end if

    end if
  end do

contains

  subroutine empty_test()
    implicit none
    print *, "Nothing tested here"
  end subroutine

end program main
