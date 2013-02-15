--  Run any/all project euler problems.

with Ada.Text_IO; use Ada.Text_IO;
with Problem_List; use Problem_List;
with Ada.Command_Line; use Ada.Command_Line;

procedure Main is

   procedure Run (P : access constant Problem);
   procedure Run (P : access constant Problem) is
   begin
      Put (Natural'Image (P.Index));
      Put (": ");
      P.Action.all;
   end Run;

   Number : Natural;
   Ran : Boolean;

begin
   if Argument_Count < 1 then
      Put_Line ("Usage: euler all   or  euler n n n");
   else
      if Argument_Count = 1 and then Argument (1) = "all" then
         for P of Problems loop
            Run (P'Access);
         end loop;
      else
         for I in 1 .. Argument_Count loop
            Number := Natural'Value (Argument (I));
            Ran := False;
            for P of Problems loop
               if P.Index = Number then
                  Run (P'Access);
                  Ran := True;
               end if;
            end loop;
            if not Ran then
               Put_Line ("Unknown problem: " & Argument (I));
            end if;
         end loop;
      end if;
   end if;

end Main;
