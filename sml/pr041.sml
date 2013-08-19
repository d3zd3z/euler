(*
 * Problem 41
 *
 * 11 April 2003
 *
 *
 * We shall say that an n-digit number is pandigital if it makes use of
 * all the digits 1 to n exactly once. For example, 2143 is a 4-digit
 * pandigital and is also prime.
 *
 * What is the largest n-digit pandigital prime that exists?
 *
 * 7652413
 *)

(* Some analysis to speed this up.  First of all, any pandigital number
 * 1-8 will be divisible by 3, and therefore not prime.  Likewise, neither 1-9.
 * So, let's assume the result is a pandigital of the digits 1-7.
 *
 * Second, start at the top (7654321) and test the permutations in inverse order.
 *)

structure Pr041 =
struct

  (* A reversed permuter. *)
  structure BackStringKind : PERM_KIND =
  struct
    type elem = char
    structure A = CharArray
    structure V = CharVector
    val lt = Char.>
  end

  structure BackPermuter = PermuterFn (BackStringKind)

  fun toInt x =
    case Int.fromString x of
         NONE => raise Fail "Invalid number"
       | SOME x => x

  fun solve () =
    let
      val sieve = Sieve.make 7654322
      val st = BackPermuter.init "7654321"
      fun loop false = raise Fail "Out of permutations"
        | loop true =
            let
              val num = toInt (BackPermuter.get st)
            in
              if Sieve.isPrime (sieve, num) then
                num
              else
                loop (BackPermuter.next st)
            end
    in
      loop true
    end

end
