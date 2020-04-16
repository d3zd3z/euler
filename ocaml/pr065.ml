(*
 * Problem 65
 *
 * 12 March 2004
 *
 * The square root of 2 can be written as an infinite continued fraction.
 *
 * √2 = 1 + 1
 *          [blackdot]
 *          2 + 1
 *              [blackdot]
 *              2 + 1
 *                  [blackdot]
 *                  2 + 1
 *                      [blackd]
 *                      2 + ...
 *
 * The infinite continued fraction can be written, √2 = [1;(2)], (2)
 * indicates that 2 repeats ad infinitum. In a similar way, √23 = [4;
 * (1,3,1,8)].
 *
 * It turns out that the sequence of partial values of continued fractions
 * for square roots provide the best rational approximations. Let us consider
 * the convergents for √2.
 *
 * 1 + 1 = 3/2
 *     *
 *     2
 * 1 + 1        = 7/5
 *     [black]
 *     2 +   1
 *           *
 *           2
 * 1 + 1            = 17/12
 *     [blackdot]
 *     2 + 1
 *         [black]
 *         2 +   1
 *               *
 *               2
 * 1 +  1                = 41/29
 *      [blackdot]
 *      2 +  1
 *           [blackdot]
 *           2 + 1
 *               [black]
 *               2 +  1
 *                    *
 *                    2
 *
 * Hence the sequence of the first ten convergents for √2 are:
 *
 * 1, 3/2, 7/5, 17/12, 41/29, 99/70, 239/169, 577/408, 1393/985, 3363/2378,
 * ...
 *
 * What is most surprising is that the important mathematical constant,
 * e = [2; 1,2,1, 1,4,1, 1,6,1 , ... , 1,2k,1, ...].
 *
 * The first ten terms in the sequence of convergents for e are:
 *
 * 2, 3, 8/3, 11/4, 19/7, 87/32, 106/39, 193/71, 1264/465, 1457/536, ...
 *
 * The sum of digits in the numerator of the 10^th convergent is 1+4+5+7=17.
 *
 * Find the sum of digits in the numerator of the 100^th convergent of the
 * continued fraction for e.
 *
 * 272
 *)

open Core

open Misc.Fix_zarith

let e_coef len =
  let len3 = (len + 2) / 3 in
  let nums = List.init len3 ~f:succ in
  let nums = List.concat_map nums ~f:(fun x -> [1; 2*x; 1]) in
  List.take (2 :: nums) len

let expand elts = match List.rev elts with
  | (x::xs) ->
      let rec loop result = function
        | [] -> result
        | (x::xs) ->
            loop Q.(of_int x + (one / result)) xs
      in
      loop (Q.of_int x) xs
  | [] -> failwith "Undefined empty continued fraction"

let solve () =
  let n = expand (e_coef 100) in
  let n = Q.num n in
  let ten = Z.of_int 10 in
  let rec loop (res : int) (n : Z.t) =
    if Z.(n = zero) then res
    else loop (res + Z.to_int Z.(n mod ten)) Z.(n / ten) in
  loop 0 n

type ilist = int list [@@deriving show]

let run () =
  printf "%d\n" (solve ())
