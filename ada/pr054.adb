----------------------------------------------------------------------
--  Problem 54
--
--  10 October 2003
--
--  In the card game poker, a hand consists of five cards and are ranked,
--  from lowest to highest, in the following way:
--
--    • High Card: Highest value card.
--    • One Pair: Two cards of the same value.
--    • Two Pairs: Two different pairs.
--    • Three of a Kind: Three cards of the same value.
--    • Straight: All cards are consecutive values.
--    • Flush: All cards of the same suit.
--    • Full House: Three of a kind and a pair.
--    • Four of a Kind: Four cards of the same value.
--    • Straight Flush: All cards are consecutive values of same suit.
--    • Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.
--
--  The cards are valued in the order:
--  2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King, Ace.
--
--  If two players have the same ranked hands then the rank made up of
--  the highest value wins; for example, a pair of eights beats a pair of
--  fives (see example 1 below). But if two ranks tie, for example, both
--  players have a pair of queens, then highest cards in each hand are
--  compared (see example 4 below); if the highest cards tie then the
--  next highest cards are compared, and so on.
--
--  Consider the following five hands dealt to two players:
--
--  Hand   Player 1            Player 2              Winner
--  1      5H 5C 6S 7S KD      2C 3S 8S 8D TD        Player 2
--         Pair of Fives       Pair of Eights
--  2      5D 8C 9S JS AC      2C 5C 7D 8S QH        Player 1
--         Highest card Ace    Highest card Queen
--  3      2D 9C AS AH AC      3D 6D 7D TD QD        Player 2
--         Three Aces          Flush with Diamonds
--         4D 6S 9H QH QC      3D 6D 7H QD QS
--  4      Pair of Queens      Pair of Queens        Player 1
--         Highest card Nine   Highest card Seven
--         2H 2D 4C 4D 4S      3C 3D 3S 9S 9D
--  5      Full House          Full House            Player 1
--         With Three Fours    with Three Threes
--
--  The file, poker.txt, contains one-thousand random hands dealt to two
--  players. Each line of the file contains ten cards (separated by a
--  single space): the first five are Player 1's cards and the last five
--  are Player 2's cards. You can assume that all hands are valid (no
--  invalid characters or repeated cards), each player's hand is in no
--  specific order, and in each hand there is a clear winner.
--
--  How many hands does Player 1 win?
--
--  376
----------------------------------------------------------------------

with Ada.Containers.Generic_Array_Sort;
with Ada.Text_IO; use Ada.Text_IO;
--  with Euler; use Euler;

procedure Pr054 is

   type Suit_Type is (Heart, Club, Diamond, Spade);

   subtype Rank_Type is Natural range 2 .. 14;

   type Card_Type is
      record
         Rank : Rank_Type;
         Suit : Suit_Type;
      end record;

   type Large_Hand is array (Positive range <>) of Card_Type;

   subtype Hand_Type is Large_Hand (1 .. 5);

   function Encode_Hand (H : Hand_Type) return String;

   function Card_Greater (Left, Right : Card_Type) return Boolean;

   procedure Hand_Sort is new Ada.Containers.Generic_Array_Sort
     (Index_Type   => Positive,
      Element_Type => Card_Type,
      Array_Type   => Large_Hand,
      "<"          => Card_Greater);

   Suit_Letters : constant array (Suit_Type) of Character :=
     (Heart   => 'H',
      Club    => 'C',
      Diamond => 'D',
      Spade   => 'S');

   Rank_Letters : constant array (Rank_Type) of Character :=
     (2 => '2', 3 => '3', 4 => '4', 5 => '5', 6 => '6', 7 => '7',
      8 => '8', 9 => '9', 10 => 'T', 11 => 'J', 12 => 'Q',
      13 => 'K', 14 => 'A');

   procedure Decode_Hands (Text : String; Left, Right : out Hand_Type);

   procedure Decode_Card (Text : String; Result : out Card_Type);

   function Encode_Card (C : Card_Type) return String;

   function Same_Suits (H : Large_Hand) return Boolean;
   function Descending_Ranks (H : Large_Hand) return Boolean;

   --  Predicates for the rankings.  Would actually be handy to make
   --  these functions, but there seems to be a problem with GNAT2012
   --  that access functions don't take out parameters, even though
   --  regular functions can.
   procedure Is_Royal_Flush (H : Hand_Type;
                             Highest : out Rank_Type;
                             Satisfies : out Boolean);
   procedure Is_Straight_Flush (H : Hand_Type;
                                Highest : out Rank_Type;
                                Satisfies : out Boolean);
   procedure Is_Four_Of_A_Kind (H : Hand_Type;
                                Highest : out Rank_Type;
                                Satisfies : out Boolean);
   procedure Is_Full_House (H : Hand_Type;
                            Highest : out Rank_Type;
                            Satisfies : out Boolean);
   procedure Is_Flush (H : Hand_Type;
                       Highest : out Rank_Type;
                       Satisfies : out Boolean);
   procedure Is_Straight (H : Hand_Type;
                          Highest : out Rank_Type;
                          Satisfies : out Boolean);
   procedure Is_Three_Of_A_Kind (H : Hand_Type;
                                 Highest : out Rank_Type;
                                 Satisfies : out Boolean);
   procedure Is_Two_Pair (H : Hand_Type;
                          Highest : out Rank_Type;
                          Satisfies : out Boolean);
   procedure Is_One_Pair (H : Hand_Type;
                          Highest : out Rank_Type;
                          Satisfies : out Boolean);
   procedure Is_Highest (H : Hand_Type;
                         Highest : out Rank_Type;
                         Satisfies : out Boolean);

   --  Note that these go from highest to lowest, which will make '<'
   --  comparison backward.
   type Ranking_Type is
     (Royal_Flush, Straight_Flush, Four_Of_A_Kind, Full_House,
      Flush, Straight, Three_Of_A_Kind, Two_Pair, One_Pair, Highest);

   Rank_Checks : constant array (Ranking_Type) of
     access procedure (H : Hand_Type;
                       Highest : out Rank_Type;
                       Satisfies : out Boolean) :=
     (Royal_Flush => Is_Royal_Flush'Access,
      Straight_Flush => Is_Straight_Flush'Access,
      Four_Of_A_Kind => Is_Four_Of_A_Kind'Access,
      Full_House => Is_Full_House'Access,
      Flush => Is_Flush'Access,
      Straight => Is_Straight'Access,
      Three_Of_A_Kind => Is_Three_Of_A_Kind'Access,
      Two_Pair => Is_Two_Pair'Access,
      One_Pair => Is_One_Pair'Access,
      Highest => Is_Highest'Access);

   type Ranking_Info is
      record
         Ranking : Ranking_Type;
         Highest_Rank : Rank_Type;
      end record;

   function Determine_Ranking (Hand : Hand_Type) return Ranking_Info;

   function ">" (Left, Right : Hand_Type) return Boolean;

   procedure Decode_Card (Text : String; Result : out Card_Type) is
   begin
      case Text (Text'First) is
         when 'J' =>
            Result.Rank := 11;
         when 'Q' =>
            Result.Rank := 12;
         when 'K' =>
            Result.Rank := 13;
         when 'A' =>
            Result.Rank := 14;
         when 'T' =>
            Result.Rank := 10;
         when '2' .. '9' =>
            Result.Rank := Character'Pos (Text (Text'First)) -
              Character'Pos ('0');
         when others =>
            Put_Line ("Unknown character: " & Text);
            raise Constraint_Error;
      end case;

      case Text (Text'First + 1) is
         when 'H' =>
            Result.Suit := Heart;
         when 'C' =>
            Result.Suit := Club;
         when 'D' =>
            Result.Suit := Diamond;
         when 'S' =>
            Result.Suit := Spade;
         when others =>
            raise Constraint_Error;
      end case;
   end Decode_Card;

   procedure Decode_Hands (Text : String; Left, Right : out Hand_Type) is
   begin
      for I in Left'Range loop
         Decode_Card (Text (Text'First + 3 * (I - Left'First) .. Text'Last),
                      Left (I));
         Decode_Card (Text (Text'First + 3 * (I - Left'First) + 15 ..
                              Text'Last), Right (I));
      end loop;
   end Decode_Hands;

   --  Note that this is actually Greater.
   function Card_Greater (Left, Right : Card_Type) return Boolean is
   begin
      if Left.Rank > Right.Rank then
         return True;
      elsif Left.Rank < Right.Rank then
         return False;
      else
         return Left.Suit > Right.Suit;
      end if;
   end Card_Greater;

   function Encode_Card (C : Card_Type) return String is
   begin
      return Result : String (1 .. 2) do
         Result (1) := Rank_Letters (C.Rank);
         Result (2) := Suit_Letters (C.Suit);
      end return;
   end Encode_Card;

   function Encode_Hand (H : Hand_Type) return String is
      Pos : Natural;
   begin
      return Result : String (1 .. 3 * Hand_Type'Length - 1) :=
        (others => ' ')
      do
         for I in H'Range loop
            Pos := 3 * (I - 1) + H'First;
            Result (Pos .. Pos + 1) := Encode_Card (H (I));
         end loop;
      end return;
   end Encode_Hand;

   function Same_Suits (H : Large_Hand) return Boolean is
      First_Suit : constant Suit_Type := H (H'First).Suit;
   begin
      for I in H'First + 1 .. H'Last loop
         if H (I).Suit /= First_Suit then
            return False;
         end if;
      end loop;
      return True;
   end Same_Suits;

   function Descending_Ranks (H : Large_Hand) return Boolean is
      Highest_Rank : constant Rank_Type := H (H'First).Rank;
   begin
      if Highest_Rank < 6 then
         return False;
      end if;

      for I in 1 .. H'Length - 1 loop
         if H (H'First + I).Rank /= Highest_Rank - I then
            return False;
         end if;
      end loop;

      return True;
   end Descending_Ranks;

   procedure Is_Royal_Flush (H : Hand_Type;
                             Highest : out Rank_Type;
                             Satisfies : out Boolean)
   is
   begin
      --  Fairly easy, since we're comparing all of the cards.
      if Same_Suits (H) and then
        H (1).Rank = 14 and then
        H (2).Rank = 13 and then
        H (3).Rank = 12 and then
        H (4).Rank = 11 and then
        H (5).Rank = 10
      then
         Highest := H (1).Rank;
         Satisfies := True;
      else
         Satisfies := False;
      end if;
   end Is_Royal_Flush;

   procedure Is_Straight_Flush (H : Hand_Type;
                                Highest : out Rank_Type;
                                Satisfies : out Boolean)
   is
   begin
      if Same_Suits (H) and then Descending_Ranks (H) then
         Highest := H (H'First).Rank;
         Satisfies := True;
      else
         Satisfies := False;
      end if;
   end Is_Straight_Flush;

   procedure Is_Four_Of_A_Kind (H : Hand_Type;
                                Highest : out Rank_Type;
                                Satisfies : out Boolean)
   is
      Middle_Rank : constant Rank_Type := H (3).Rank;
   begin
      Satisfies := False;

      if H (2).Rank = Middle_Rank and then
        H (4).Rank = Middle_Rank
      then
         if H (1).Rank = Middle_Rank then
            Highest := H (1).Rank;
            Satisfies := True;
         elsif H (5).Rank = Middle_Rank then
            Highest := H (2).Rank;
            Satisfies := True;
         end if;
      end if;
   end Is_Four_Of_A_Kind;

   procedure Is_Full_House (H : Hand_Type;
                            Highest : out Rank_Type;
                            Satisfies : out Boolean)
   is
   begin
      Satisfies := False;

      --  Note that the highest card of a full house is always the
      --  triple, even if the pair is higher in rank.
      if H (1).Rank = H (2).Rank and then H (4).Rank = H (5).Rank then
         if H (2).Rank = H (3).Rank then
            Highest := H (1).Rank;
            Satisfies := True;
         elsif H (3).Rank = H (4).Rank then
            Highest := H (3).Rank;
            Satisfies := True;
         end if;
      end if;
   end Is_Full_House;

   procedure Is_Flush (H : Hand_Type;
                       Highest : out Rank_Type;
                       Satisfies : out Boolean)
   is
   begin
      if Same_Suits (H) then
         Highest := H (1).Rank;
         Satisfies := True;
      else
         Satisfies := False;
      end if;
   end Is_Flush;

   procedure Is_Straight (H : Hand_Type;
                          Highest : out Rank_Type;
                          Satisfies : out Boolean)
   is
   begin
      if Descending_Ranks (H) then
         Highest := H (H'First).Rank;
         Satisfies := True;
      else
         Satisfies := False;
      end if;
   end Is_Straight;

   procedure Is_Three_Of_A_Kind (H : Hand_Type;
                                 Highest : out Rank_Type;
                                 Satisfies : out Boolean)
   is
      Middle : constant Rank_Type := H (3).Rank;
   begin
      Satisfies := False;

      if H (2).Rank = Middle then
         if H (1).Rank = Middle then
            Highest := H (1).Rank;
            Satisfies := True;
         elsif H (4).Rank = Middle then
            Highest := H (2).Rank;
            Satisfies := True;
         end if;
      elsif H (4).Rank = Middle and then H (5).Rank = Middle then
         Highest := H (3).Rank;
         Satisfies := True;
      end if;
   end Is_Three_Of_A_Kind;

   procedure Is_Two_Pair (H : Hand_Type;
                          Highest : out Rank_Type;
                          Satisfies : out Boolean)
   is
      function Pair_Check (A1, A2, B1, B2 : Natural) return Boolean;
      function Pair_Check (A1, A2, B1, B2 : Natural) return Boolean
      is
      begin
         if H (A1).Rank = H (A2).Rank and then
           H (B1).Rank = H (B2).Rank
         then
            Highest := H (A1).Rank;
            return True;
         else
            return False;
         end if;
      end Pair_Check;
   begin
      if Pair_Check (1, 2, 3, 4) or else
        Pair_Check (1, 2, 4, 5) or else
        Pair_Check (2, 3, 4, 5)
      then
         Satisfies := True;
      else
         Satisfies := False;
      end if;
   end Is_Two_Pair;

   procedure Is_One_Pair (H : Hand_Type;
                          Highest : out Rank_Type;
                          Satisfies : out Boolean)
   is
   begin
      for I in H'First .. H'Last - 1 loop
         if H (I).Rank = H (I + 1).Rank then
            Highest := H (I).Rank;
            Satisfies := True;
            return;
         end if;
      end loop;
      Satisfies := False;
   end Is_One_Pair;

   procedure Is_Highest (H : Hand_Type;
                         Highest : out Rank_Type;
                         Satisfies : out Boolean)
   is
   begin
      Satisfies := True;
      Highest := H (1).Rank;
   end Is_Highest;

   function Determine_Ranking (Hand : Hand_Type) return Ranking_Info is
      Satisfies : Boolean;
   begin
      return Result : Ranking_Info do
         for R in Ranking_Type'Range loop
            Rank_Checks (R).all (Hand, Result.Highest_Rank, Satisfies);
            if Satisfies then
               Result.Ranking := R;
               exit;
            end if;
         end loop;
      end return;
   end Determine_Ranking;

   function ">" (Left, Right : Hand_Type) return Boolean is
      Left_Rank : Ranking_Info renames Determine_Ranking (Left);
      Right_Rank : Ranking_Info renames Determine_Ranking (Right);
   begin
      --  Remember, the Ranking comparisons need to be reversed.
      if Left_Rank.Ranking < Right_Rank.Ranking then
         return True;
      elsif Left_Rank.Ranking > Right_Rank.Ranking then
         return False;
      elsif Left_Rank.Highest_Rank > Right_Rank.Highest_Rank then
         return True;
      elsif Left_Rank.Highest_Rank < Right_Rank.Highest_Rank then
         return False;
      else
         for I in Hand_Type'Range loop
            if Left (I).Rank > Right (I).Rank then
               return True;
            elsif Left (I).Rank < Right (I).Rank then
               return False;
            end if;
         end loop;

         Put_Line ("Identical hands, no ranking");
         raise Program_Error;
      end if;
   end ">";

   procedure Check_Hands (Text : String; Expect_Left : Boolean);
   procedure Check_Hands (Text : String; Expect_Left : Boolean) is
      Left, Right : Hand_Type;
   begin
      Decode_Hands (Text, Left, Right);
      Hand_Sort (Left);
      Hand_Sort (Right);
      if (Left > Right) /= Expect_Left then
         Put_Line ("Incorrect winner: " & Text);
         Put_Line (Encode_Hand (Left));
         Put_Line (Encode_Hand (Right));
         raise Program_Error;
      end if;
   end Check_Hands;

   procedure Solve (Name : String);
   procedure Solve (Name : String) is
      File : File_Type;
      Count : Natural := 0;
   begin
      Open (File => File, Mode => In_File, Name => Name);

      while not End_Of_File (File) loop
         declare
            Line : constant String := Get_Line (File);
            Left, Right : Hand_Type;
         begin
            Decode_Hands (Line, Left, Right);
            Hand_Sort (Left);
            Hand_Sort (Right);
            if Left > Right then
               Count := Count + 1;
            end if;
         end;
      end loop;

      Close (File);

      Put_Line (Natural'Image (Count));
   end Solve;

begin
   --  Verify the examples given.
   Check_Hands ("5H 5C 6S 7S KD 2C 3S 8S 8D TD", False);
   Check_Hands ("5D 8C 9S JS AC 2C 5C 7D 8S QH", True);
   Check_Hands ("2D 9C AS AH AC 3D 6D 7D TD QD", False);
   Check_Hands ("4D 6S 9H QH QC 3D 6D 7H QD QS", True);
   Check_Hands ("2H 2D 4C 4D 4S 3C 3D 3S 9S 9D", True);

   Solve ("../haskell/poker.txt");
end Pr054;
