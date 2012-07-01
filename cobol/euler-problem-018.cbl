      * Problem 18
      *
      * 31 May 2002
      *
      * By starting at the top of the triangle below and moving to
      * adjacent numbers on the row below, the maximum total from top
      * to bottom is 23.
      *
      * 3
      * 7 4
      * 2 4 6
      * 8 5 9 3
      *
      * That is, 3 + 7 + 4 + 9 = 23.
      *
      * Find the maximum total from top to bottom of the triangle
      * below:
      *
      * 75
      * 95 64
      * 17 47 82
      * 18 35 87 10
      * 20 04 82 47 65
      * 19 01 23 75 03 34
      * 88 02 77 73 07 63 67
      * 99 65 04 28 06 16 70 92
      * 41 41 26 56 83 40 80 70 33
      * 41 48 72 33 47 32 37 16 94 29
      * 53 71 44 65 25 43 91 52 97 51 14
      * 70 11 33 28 77 73 17 78 39 68 17 57
      * 91 71 52 38 17 14 91 43 58 50 27 29 48
      * 63 66 04 68 89 53 67 30 73 16 69 87 40 31
      * 04 62 98 27 23 09 70 98 73 93 38 53 60 04 23
      *
      * NOTE: As there are only 16384 routes, it is possible to solve
      * this problem by trying every route. However, Problem 67, is the
      * same challenge with a triangle containing one-hundred rows; it
      * cannot be solved by brute force, and requires a clever method!
      * ;o)
      *
      * 1074
       identification division.
       program-id. euler-problem-018.

       data division.
       working-storage section.
       01 data-table.
         02 row  occurs 15 times.
           03 cell occurs 15 times      pic 9(4) comp-5
                   value zero.
       01 working-variables.
         02 work-line                   pic x(45).
         02 work-pointer                pic 999 comp-5.
         02 work-row                    pic 999 comp-5.
         02 work-col                    pic 999 comp-5.

       01 source-table.
         02 raw-source-data             pic x(660) value
           '75                                          ' &
           '95 64                                       ' &
           '17 47 82                                    ' &
           '18 35 87 10                                 ' &
           '20 04 82 47 65                              ' &
           '19 01 23 75 03 34                           ' &
           '88 02 77 73 07 63 67                        ' &
           '99 65 04 28 06 16 70 92                     ' &
           '41 41 26 56 83 40 80 70 33                  ' &
           '41 48 72 33 47 32 37 16 94 29               ' &
           '53 71 44 65 25 43 91 52 97 51 14            ' &
           '70 11 33 28 77 73 17 78 39 68 17 57         ' &
           '91 71 52 38 17 14 91 43 58 50 27 29 48      ' &
           '63 66 04 68 89 53 67 30 73 16 69 87 40 31   ' &
           '04 62 98 27 23 09 70 98 73 93 38 53 60 04 23'.
         02 source-data redefines raw-source-data
           occurs 15 times              pic x(44).

       procedure division.

       main.
           perform load-source-data
           perform find-route
           display cell (1, 1)
           stop run.

       load-source-data.
           perform decode-line varying work-row from 1 by 1
             until work-row > 15.

       decode-line.
           move 1 to work-pointer
           move source-data (work-row) to work-line

           perform varying work-col from 1 by 1
             until work-col > work-row

             unstring work-line
               delimited by ' '
               into cell (work-row, work-col)
               with pointer work-pointer
             end-unstring

           end-perform.

       find-route.
           perform varying work-row from 14 by -1
             until work-row = 0

             perform varying work-col from 1 by 1
               until work-col > work-row

               if cell (work-row + 1, work-col)
                 > cell (work-row + 1, work-col + 1)
               then
                 add cell (work-row + 1, work-col) to
                   cell (work-row, work-col)
               else
                 add cell (work-row + 1, work-col + 1) to
                   cell (work-row, work-col)
               end-if

             end-perform

           end-perform.

       end program euler-problem-018.
