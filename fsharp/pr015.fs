// Problem 15
//
// 19 April 2002
//
//
// Starting in the top left corner of a 2x2 grid, there are 6 routes (without
// backtracking) to the bottom right corner.
//
// [p_015]
//
// How many routes are there through a 20x20 grid?
//
// 137846528820

// Imperative solution.
let baseData n = Array.create (n+1) 1L

let bump vec =
  for i = 0 to Array.length vec - 2 do
    vec.[i+1] <- vec.[i] + vec.[i+1]
  done

let routes n =
  let vec = baseData n in
  for _i = 1 to n do
    bump vec
  done
  vec.[n]

// And a functional solution.
let fbase n = List.init (n+1) (fun _ -> 1L)

let rec fbump = function
  | (a::b::r) -> a :: fbump (a+b :: r)
  | (a:int64 list) -> a

let fsolve n =
  let rec loop items =
    seq {
      yield items
      yield! loop (fbump items)
    }
  loop (fbase n)
  |> Seq.nth n
  |> List.rev
  |> List.head

let pr15 () =
  // routes 20
  fsolve 20

printfn "%d" (pr15 ())
