--  Run any/all project euler problems.

with Ada.Text_IO; use Ada.Text_IO;
with Problem_List; use Problem_List;

procedure Main is

begin
   for P of Problems loop
      Put (Natural'Image (P.Index));
      Put (": ");
      P.Action.all;
   end loop;
end Main;
