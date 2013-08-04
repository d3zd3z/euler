// Problem 20
//
// 21 June 2002
//
//
// n! means n x (n − 1) x ... x 3 x 2 x 1
//
// For example, 10! = 10 x 9 x ... x 3 x 2 x 1 = 3628800,
// and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 =
// 27.
//
// Find the sum of the digits in the number 100!
//
// 648

let fact (n : int) =
    seq { 1I .. bigint n }
    |> Seq.reduce ( * )

let digitSum n =
    let rec loop n total =
        if n = 0I then total
        else loop (n / 10I) (total + int (n % 10I))
    loop n 0

let pr20 () = fact 100 |> digitSum

printfn "%A" (pr20 ())
