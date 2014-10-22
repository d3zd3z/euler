(*
 * Problem 54
 *
 * 10 October 2003
 *
 *
 * In the card game poker, a hand consists of five cards and are
 * ranked, from lowest to highest, in the following way:
 *
 *   • High Card: Highest value card.
 *   • One Pair: Two cards of the same value.
 *   • Two Pairs: Two different pairs.
 *   • Three of a Kind: Three cards of the same value.
 *   • Straight: All cards are consecutive values.
 *   • Flush: All cards of the same suit.
 *   • Full House: Three of a kind and a pair.
 *   • Four of a Kind: Four cards of the same value.
 *   • Straight Flush: All cards are consecutive values of same suit.
 *   • Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.
 *
 * The cards are valued in the order:
 * 2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King, Ace.
 *
 * If two players have the same ranked hands then the rank made up of
 * the highest value wins; for example, a pair of eights beats a pair
 * of fives (see example 1 below). But if two ranks tie, for example,
 * both players have a pair of queens, then highest cards in each hand
 * are compared (see example 4 below); if the highest cards tie then
 * the next highest cards are compared, and so on.
 *
 * Consider the following five hands dealt to two players:
 *
 * Hand   Player 1            Player 2              Winner
 * 1      5H 5C 6S 7S KD      2C 3S 8S 8D TD        Player 2
 *        Pair of Fives       Pair of Eights
 * 2      5D 8C 9S JS AC      2C 5C 7D 8S QH        Player 1
 *        Highest card Ace    Highest card Queen
 * 3      2D 9C AS AH AC      3D 6D 7D TD QD        Player 2
 *        Three Aces          Flush with Diamonds
 *        4D 6S 9H QH QC      3D 6D 7H QD QS
 * 4      Pair of Queens      Pair of Queens        Player 1
 *        Highest card Nine   Highest card Seven
 *        2H 2D 4C 4D 4S      3C 3D 3S 9S 9D
 * 5      Full House          Full House            Player 1
 *        With Three Fours    with Three Threes
 *
 * The file, poker.txt, contains one-thousand random hands dealt to two
 * players. Each line of the file contains ten cards (separated by a
 * single space): the first five are Player 1's cards and the last five
 * are Player 2's cards. You can assume that all hands are valid (no
 * invalid characters or repeated cards), each player's hand is in no
 * specific order, and in each hand there is a clear winner.
 *
 * How many hands does Player 1 win?
 *
 * 376
 *)

open! Core.Std

(*
module Card :
  sig
    type t
    val of_string : string -> t
    val to_string : t -> string
    val decode_hands : string -> (t list * t list)
    val hand_to_string : t list -> string
  end = struct
    module CharMap = Map.Make (Char)
    let names = [| '2'; '3'; '4'; '5'; '6'; '7'; '8'; '9'; 'T'; 'J'; 'Q'; 'K'; 'A' |]
    let name_value =
      let map = Array.foldi names ~f:(fun m i s -> CharMap.add m ~key:s ~data:i) ~init:CharMap.empty in
      fun k -> CharMap.find k map

    type t = { value : int; suit : char }
    let of_string text =
      let value = name_value text.[0] in
      let suit = text.[1] in
      { value = value; suit = suit }

    let to_string { value; suit } =
      Printf.sprintf "%c%c" names.(value) suit

    (* Decode the hands.  The hands are then sorted descending. *)
    let decode_hands text =
      let cards = BatString.nsplit text ~by:" " in
      let cards = List.map of_string cards in
      let p1, p2 = BatList.split_at 5 cards in
      let swcomp a b = compare b a in
      let p1 = List.sort swcomp p1 in
      let p2 = List.sort swcomp p2 in
      (p1, p2)

    let hand_to_string hand =
      let hand = List.map to_string hand in
      String.concat " " hand
  end

module Rank =
  struct
    (* The card rankings.  Each ranking also has the highest card.
     * This allows 'compare' to order the rankings the same. *)
    type rank =
      | HighCard of Card.t
      | OnePair of Card.t
      | TwoPairs of Card.t
      | ThreeOfAKind of Card.t
      | Straight of Card.t
      | Flush of Card.t
      | FullHouse of Card.t
      | FourOfAKind of Card.t
      | StraightFlush of Card.t
      | RoyalFlush of Card.t

  end

let solve () =
  let lines = BatFile.lines_of "../haskell/poker.txt" in
  BatEnum.iter (fun line ->
    let p1, p2 = Card.decode_hands line in
    Printf.printf "p1: %S, p2: %S\n"
      (Card.hand_to_string p1)
      (Card.hand_to_string p2)
  ) lines

let run () =
  solve ()
*)

let run () =
  printf "TODO\n"
