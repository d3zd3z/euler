// Problem 36
//
// 31 January 2003
//
//
// The decimal number, 585 = 1001001001[2] (binary), is palindromic in both
// bases.
//
// Find the sum of all numbers, less than one million, which are palindromic
// in base 10 and base 2.
//
// (Please note that the palindromic number, in either base, may not include
// leading zeros.)
//
// 872187

module Pr036

let reverse_number bas number =
    let rec loop number result =
        if number = 0 then result
        else loop (number / bas) (result * bas + (number % bas)) in
    loop number 0

let is_palindrome bas number =
    number = reverse_number bas number

let pr036 () =
    seq { 1 .. 999999 }
    |> Seq.filter (fun x -> is_palindrome 10 x && is_palindrome 2 x)
    |> Seq.sum

#if COMPILED
printfn "%A" (pr036 ())
#endif
