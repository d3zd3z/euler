      * Problem 19
      *
      * 14 June 2002
      *
      * You are given the following information, but you may prefer to
      * do some research for yourself.
      *
      *   • 1 Jan 1900 was a Monday.
      *   • Thirty days has September,
      *     April, June and November.
      *     All the rest have thirty-one,
      *     Saving February alone,
      *     Which has twenty-eight, rain or shine.
      *     And on leap years, twenty-nine.
      *   • A leap year occurs on any year evenly divisible by 4, but
      *     not on a century unless it is divisible by 400.
      *
      * How many Sundays fell on the first of the month during the
      * twentieth century (1 Jan 1901 to 31 Dec 2000)?
      *
      * 171
       identification division.
       program-id. euler-problem-019.

      * This problem actually matches COBOL fairly well.  However, the
      * 4-digit year function are kind of "new" (as in 1982).
       data division.
       working-storage section.
       01 date-values.
         02 ymd-date            pic 99999999.
         02 date-parts redefines ymd-date.
           03 date-year         pic 9999.
           03 date-month        pic 99.
           03 date-day          pic 99.
         02 day-number          pic 9999999.
         02 sunday-count        pic 999.

       procedure division.

       main.
           move    1 to date-day
           move zero to sunday-count

           perform varying date-year from 1901 by 1
             until date-year > 2000

             perform varying date-month from 1 by 1
               until date-month > 12

               move function integer-of-date (ymd-date) to day-number
               if function mod (day-number, 7) = 0
                 add 1 to sunday-count
               end-if

             end-perform

           end-perform

           display sunday-count

           stop run.

       end program euler-problem-019.
