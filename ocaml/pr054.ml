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

module Card :
  sig
    type t = { value : int; suit : char } with sexp
    val of_string : string -> t
    val to_string : t -> string
    val decode_hands : string -> (t list * t list)
    val hand_to_string : t list -> string
  end = struct
    let names = [| '2'; '3'; '4'; '5'; '6'; '7'; '8'; '9'; 'T'; 'J'; 'Q'; 'K'; 'A' |]
    let name_value =
      let map = Array.foldi names ~init:Int.Map.empty
        ~f:(fun i m s -> Int.Map.add m ~key:(Char.to_int s) ~data:i) in
      fun k -> Int.Map.find_exn map (Char.to_int k)

    type t = { value : int; suit : char }

    let sexp_of_t { value; suit } =
      Sexp.List [Sexp.List [Sexp.Atom "value"; Sexp.Atom (String.of_char names.(value))];
        Sexp.List [Sexp.Atom "suit"; Sexp.Atom (String.of_char suit)]]

    let t_of_sexp _ = failwith "TODO"

    let of_string text =
      let value = name_value text.[0] in
      let suit = text.[1] in
      { value; suit }

    let to_string { value; suit } =
      sprintf "%c%c" names.(value) suit

    let decode_hands text =
      let cards = String.split text ~on:' ' in
      let cards = List.map cards ~f:of_string in
      let p1, p2 = List.split_n cards 5 in
      let swcomp a b = compare b a in  (* TODO: Non poly compare *)
      let p1 = List.sort ~cmp:swcomp p1 in
      let p2 = List.sort ~cmp:swcomp p2 in
      (p1, p2)

    let hand_to_string hand =
      let hand = List.map hand ~f:to_string in
      String.concat ~sep:" " hand
  end

module Rank :
  sig
    type rank
    val rank_of : Card.t list -> rank
    val get_nums : Card.t list -> int list
  end = struct
    (* The card rankings.  Each ranking also has the highest card
     * values.  This allows 'compare' to order the rankings the same.
     *)
    type rank =
      | HighCard of int list
      | OnePair of int list
      | TwoPairs of int list
      | ThreeOfAKind of int list
      | Straight of int list
      | Flush of int list
      | FullHouse of int list
      | FourOfAKind of int list
      | StraightFlush of int list
      | RoyalFlush of int list
      with sexp

    let same_suit = function
      | [] -> failwith "empty"
      | ({ Card.suit = suit; _ } :: ar) ->
          List.for_all ar ~f:(fun { Card.suit = suitb; _ } -> suit = suitb)

    let rec decreasing = function
      | [] -> true
      | [_] -> true
      | (a::b::bs) -> a-1 = b && decreasing (b::bs)

    let rec four_same = function
      | (a::b::c::d::_) when List.for_all [b;c;d] ~f:(fun x -> x = a) ->
          Some [a;b;c;d]
      | [] -> None
      | (_::xs) -> four_same xs

    let three_same _ nums =
      let rec loop = function
        | (a::b::c::_) when List.for_all [b;c] ~f:(fun x -> x = a) ->
            Some (ThreeOfAKind [a;b;c])
        | [] -> None
        | (_::xs) -> loop xs in
      loop nums

    (* Note that the full house is ranked by the triple, even if it is
     * the lower value of the cards. *)
    let full_house _ = function
      | [a;b;c;d;e] when (a = b && a = c && d = e) -> Some (FullHouse [a;b;c])
      | [a;b;c;d;e] when (a = b && c = d && c = e) -> Some (FullHouse [c;d;e])
      | _ -> None

    let two_pair _ nums =
      match List.group nums ~break:(<>) with
        | [[_]; [_;_] as a; [_;_] as b] -> Some (TwoPairs (a @ b))
        | [[_;_] as a; [_]; [_;_] as b] -> Some (TwoPairs (a @ b))
        | [[_;_] as a; [_;_] as b; [_]] -> Some (TwoPairs (a @ b))
        | _ -> None

    let one_pair _ nums =
      let rec scan = function
        | ([_;_] as a :: _) -> Some (OnePair a)
        | (_ :: xs) -> scan xs
        | _ -> None in
      scan (List.group nums ~break:(<>))

    let royal hand = function
      | [ 12; 11; 10; 9; 8 ] as nums when same_suit hand -> Some (RoyalFlush nums)
      | _ -> None

    let straight_flush hand nums =
      if same_suit hand && decreasing nums then
        Some (StraightFlush nums)
      else
        None

    let is_flush hand nums =
      if same_suit hand then
        Some (Flush nums)
      else
        None

    let is_straight _ nums =
      if decreasing nums then
        Some (Straight nums)
      else
        None

    let four_of_a_kind _ nums =
      Option.map (four_same nums) ~f:(fun n -> FourOfAKind n)

    let highest _ nums = match nums with
      | [ a; _; _; _; _] -> Some (HighCard [a])
      | _ -> None

    let get_nums hand =
      List.map hand ~f:(fun c -> c.Card.value)

    let best ops hand =
      let nums = get_nums hand in
      let rec loop = function
        | [] -> failwith "Invalid poker hand"
        | (b::br) ->
            match b hand nums with
              | Some r -> r
              | None -> loop br in
      loop ops

    let ranks = [ royal; straight_flush; four_of_a_kind;
      full_house; is_flush; is_straight; three_same; two_pair;
      one_pair; highest ]

    let rank_of = best ranks

  end
  (* So, it's wrong, but nifty *)

let solve () =
  let lines = In_channel.read_lines "../haskell/poker.txt" in
  (* let lines = In_channel.read_lines "tpoker.txt" in *)
  let wins = List.count lines ~f:(fun line ->
    let p1, p2 = Card.decode_hands line in
    let r1 = Rank.rank_of p1 in
    let r2 = Rank.rank_of p2 in
    (*
    printf "p1: %S (%s), p2: %S (%s) %d\n"
      (Card.hand_to_string p1)
      (Rank.rank_of p1 |> Rank.sexp_of_rank |> Sexp.to_string)
      (Card.hand_to_string p2)
      (Rank.rank_of p2 |> Rank.sexp_of_rank |> Sexp.to_string)
      (compare r1 r2);
    *)
    (r1, Rank.get_nums p1) > (r2, Rank.get_nums p2)) in
    printf "%d\n" wins

let run () =
  solve ()
