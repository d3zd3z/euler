--  Triangle manipulations.

package Euler.Triangle is

   type Box_Type is
      record
         P1, P2, Q1, Q2 : Natural;
      end record;

   type Triple_Type is
      record
         A, B, C : Natural;
      end record;

   type Action is not null access procedure (
      Triple : Triple_Type;
      Circumference : Natural);

   procedure Generate_Triples (Limit : Natural;
      Act : not null access procedure (
         Triple : Triple_Type;
         Circumference : Natural));
   --  Generate all of the Pythagorean triples having a circumference <=
   --  Limit.

end Euler.Triangle;
