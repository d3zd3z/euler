----------------------------------------------------------------------
--  Problem 19
--
--  14 June 2002
--
--  You are given the following information, but you may prefer to do some
--  research for yourself.
--
--    • 1 Jan 1900 was a Monday.
--    • Thirty days has September,
--      April, June and November.
--      All the rest have thirty-one,
--      Saving February alone,
--      Which has twenty-eight, rain or shine.
--      And on leap years, twenty-nine.
--    • A leap year occurs on any year evenly divisible by 4, but not on a
--      century unless it is divisible by 400.
--
--  How many Sundays fell on the first of the month during the twentieth
--  century (1 Jan 1901 to 31 Dec 2000)?
--
----------------------------------------------------------------------

--  with Ada.Text_IO; use Ada.Text_IO;
with Ada.Calendar; use Ada.Calendar;
with Ada.Calendar.Formatting; use Ada.Calendar.Formatting;
with Euler; use Euler;

procedure Pr019 is

   Date : Time;
   Count : Natural := 0;

begin
   for Year in 1901 .. 2000 loop
      for Month in 1 .. 12 loop
         Date := Ada.Calendar.Time_Of (Year    => Year,
                                       Month   => Month,
                                       Day     => 1,
                                       Seconds => 1.0);
         if Formatting.Day_Of_Week (Date) = Sunday then
            Count := Count + 1;
         end if;
      end loop;
   end loop;

   Print_Result (Count);
end Pr019;

