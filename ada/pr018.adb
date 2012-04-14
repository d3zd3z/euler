----------------------------------------------------------------------
--  Problem 18
--
--  31 May 2002
--
--  By starting at the top of the triangle below and moving to adjacent
--  numbers on the row below, the maximum total from top to bottom is 23.
--
--  3
--  7 4
--  2 4 6
--  8 5 9 3
--
--  That is, 3 + 7 + 4 + 9 = 23.
--
--  Find the maximum total from top to bottom of the triangle below:
--
--  75
--  95 64
--  17 47 82
--  18 35 87 10
--  20 04 82 47 65
--  19 01 23 75 03 34
--  88 02 77 73 07 63 67
--  99 65 04 28 06 16 70 92
--  41 41 26 56 83 40 80 70 33
--  41 48 72 33 47 32 37 16 94 29
--  53 71 44 65 25 43 91 52 97 51 14
--  70 11 33 28 77 73 17 78 39 68 17 57
--  91 71 52 38 17 14 91 43 58 50 27 29 48
--  63 66 04 68 89 53 67 30 73 16 69 87 40 31
--  04 62 98 27 23 09 70 98 73 93 38 53 60 04 23
--
--  NOTE: As there are only 16384 routes, it is possible to solve this problem
--  by trying every route. However, Problem 67, is the same challenge with a
--  triangle containing one-hundred rows; it cannot be solved by brute force,
--  and requires a clever method! ;o)
--
----------------------------------------------------------------------

--  with Ada.Text_IO; use Ada.Text_IO;
with Ada.Containers.Vectors;
with Euler; use Euler;

--  TODO: It'd be nice to be able to do this with bounded vectors,
--  since we know the bounds, but I kept getting a discriminant check
--  falure when trying to build the Table.

procedure Pr018 is

   Capacity : constant := 15;

   package V is new Ada.Containers.Vectors
     (Index_Type   => Positive,
      Element_Type => Natural);

   subtype Vector is V.Vector;

   type Simple_Vector is array (Positive range <>) of Natural;

   function To_Bvec (Simple : Simple_Vector) return Vector;

   type Vector_List is array (Positive range <>) of Vector;

   function To_Bvec (Simple : Simple_Vector) return Vector is
      Result : Vector;
   begin
      Result.Clear;
      for X of Simple loop
         Result.Append (X);
      end loop;
      return Result;
   end To_Bvec;

   Table : constant Vector_List :=
     (To_Bvec (Simple_Vector'(1 => 75)),
      To_Bvec (Simple_Vector'(95, 64)),
      To_Bvec (Simple_Vector'(17, 47, 82)),
      To_Bvec (Simple_Vector'(18, 35, 87, 10)),
      To_Bvec (Simple_Vector'(20, 04, 82, 47, 65)),
      To_Bvec (Simple_Vector'(19, 01, 23, 75, 03, 34)),
      To_Bvec (Simple_Vector'(88, 02, 77, 73, 07, 63, 67)),
      To_Bvec (Simple_Vector'(99, 65, 04, 28, 06, 16, 70, 92)),
      To_Bvec (Simple_Vector'(41, 41, 26, 56, 83, 40, 80, 70, 33)),
      To_Bvec (Simple_Vector'(41, 48, 72, 33, 47, 32, 37, 16, 94, 29)),
      To_Bvec (Simple_Vector'(53, 71, 44, 65, 25, 43, 91, 52, 97, 51, 14)),
      To_Bvec (Simple_Vector'(70, 11, 33, 28, 77, 73, 17, 78, 39, 68, 17, 57)),
      To_Bvec (Simple_Vector'(91, 71, 52, 38, 17, 14, 91, 43, 58, 50, 27, 29,
                              48)),
      To_Bvec (Simple_Vector'(63, 66, 04, 68, 89, 53, 67, 30, 73, 16, 69, 87,
                              40, 31)),
      To_Bvec (Simple_Vector'(04, 62, 98, 27, 23, 09, 70, 98, 73, 93, 38, 53,
                              60, 04, 23)));

   Temp : Simple_Vector (1 .. Capacity + 1) := (others => 0);

begin
   for Row of reverse Table loop
      for Pos in Row.First_Index .. Row.Last_Index loop
         if Temp (Pos) > Temp (Pos + 1) then
            Temp (Pos) := Temp (Pos) + Row.Element (Pos);
         else
            Temp (Pos) := Temp (Pos + 1) + Row.Element (Pos);
         end if;
      end loop;
   end loop;

   Print_Result (Temp (Temp'First));
end Pr018;

