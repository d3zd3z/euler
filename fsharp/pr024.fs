// Problem 24
//
// 16 August 2002
//
//
// A permutation is an ordered arrangement of objects. For example, 3124 is
// one possible permutation of the digits 1, 2, 3 and 4. If all of the
// permutations are listed numerically or alphabetically, we call it
// lexicographic order. The lexicographic permutations of 0, 1 and 2 are:
//
// 012   021   102   120   201   210
//
// What is the millionth lexicographic permutation of the digits 0, 1, 2, 3,
// 4, 5, 6, 7, 8 and 9?

open System
open System.Collections
open System.Collections.Generic

let pr24 () =
    let iter = Misc.stringPermute "0123456789"
    for i = 1 to 1000000 do
        ignore <| (iter :> IEnumerator).MoveNext ()
    let result = (iter :> IEnumerator<_>).Current
    new String (result)

printfn "%s" (pr24 ())
