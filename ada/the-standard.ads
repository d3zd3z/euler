--  Representation of package Standard

--  This is not accurate Ada, since new base types cannot be
--  created, but the listing shows the target dependent
--  characteristics of the Standard types for this compiler

package Standard is
pragma Pure (Standard);

   type Boolean is (False, True);
   for Boolean'Size use 1;
   for Boolean use (False => 0, True => 1);

   type Integer is range -(2 **31) .. +(2 **31 - 1);
   for Integer'Size use 32;

   subtype Natural  is Integer range 0 .. Integer'Last;
   subtype Positive is Integer range 1 .. Integer'Last;

   type Short_Short_Integer is range -(2 **7) .. +(2 **7 - 1);
   for Short_Short_Integer'Size use 8;

   type Short_Integer is range -(2 **15) .. +(2 **15 - 1);
   for Short_Integer'Size use 16;

   type Long_Integer is range -(2 **63) .. +(2 **63 - 1);
   for Long_Integer'Size use 64;

   type Long_Long_Integer is range -(2 **63) .. +(2 **63 - 1);
   for Long_Long_Integer'Size use 64;

   type Short_Float is digits 6
     range -16#0.FFFF_FF#E32 .. 16#0.FFFF_FF#E32;
   for Short_Float'Size use 32;

   type Float is digits 6
     range -16#0.FFFF_FF#E32 .. 16#0.FFFF_FF#E32;
   for Float'Size use 32;

   type Long_Float is digits 15
     range -16#0.FFFF_FFFF_FFFF_F8#E256 .. 16#0.FFFF_FFFF_FFFF_F8#E256;
   for Long_Float'Size use 64;

   type Long_Long_Float is digits 18
     range -16#0.FFFF_FFFF_FFFF_FFFF#E4096 .. 16#0.FFFF_FFFF_FFFF_FFFF#E4096;
   for Long_Long_Float'Size use 128;

   type Character is (...)
   for Character'Size use 8;
   --  See RM A.1(35) for details of this type

   type Wide_Character is (...)
   for Wide_Character'Size use 16;
   --  See RM A.1(36) for details of this type

   type Wide_Wide_Character is (...)
   for Wide_Wide_Character'Size use 32;
   --  See RM A.1(36) for details of this type
   type String is array (Positive range <>) of Character;
   pragma Pack (String);

   type Wide_String is array (Positive range <>) of Wide_Character;
   pragma Pack (Wide_String);

   type Wide_Wide_String is array (Positive range <>)  of Wide_Wide_Character;
   pragma Pack (Wide_Wide_String);

   type Duration is delta 0.000000001
     range -((2 ** 63 - 1) * 0.000000001) ..
           +((2 ** 63 - 1) * 0.000000001);
   for Duration'Small use 0.000000001;

   Constraint_Error : exception;
   Program_Error    : exception;
   Storage_Error    : exception;
   Tasking_Error    : exception;
   Numeric_Error    : exception renames Constraint_Error;

end Standard;
