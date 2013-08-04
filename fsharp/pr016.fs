// Problem 16
//
// 03 May 2002
//
//
// 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
//
// What is the sum of the digits of the number 2^1000?
//
// 1366

let pr16 () =
  let rec loop n result = 
    if n = 0I then result
    else loop (n / 10I) (result + int (n % 10I))
  loop (2I ** 1000) 0

printfn "%A" (pr16 ())
