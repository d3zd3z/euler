// Problem 32
//
// 06 December 2002
//
//
// We shall say that an n-digit number is pandigital if it makes use of all
// the digits 1 to n exactly once; for example, the 5-digit number, 15234, is
// 1 through 5 pandigital.
//
// The product 7254 is unusual, as the identity, 39 x 186 = 7254, containing
// multiplicand, multiplier, and product is 1 through 9 pandigital.
//
// Find the sum of all products whose multiplicand/multiplier/product
// identity can be written as a 1 through 9 pandigital.
//
// HINT: Some products can be obtained in more than one way so be sure to
// only include it once in your sum.
//
// 45228

open System

// Extract digits out of char-array'd number as anumber
let getNum (chars : char array) pos len =
    let text = new String (chars, pos, len)
    Int32.Parse text

let pr32 () =
    seq {
        for chars in Misc.stringPermute "123456789" do

        // try nn*nnn=nnnn
        let aa = getNum chars 0 2
        let bb = getNum chars 2 3
        let cc = getNum chars 5 4
        if aa * bb = cc then yield cc

        // And try n*nnnn=nnnn
        let a2 = getNum chars 0 1
        let b2 = getNum chars 1 4
        if a2 * b2 = cc then yield cc
    }
    |> Set.ofSeq
    |> Set.fold (+) 0

printfn "%A" (pr32 ())
