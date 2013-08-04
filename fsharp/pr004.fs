// Problem 4
//
// 16 November 2001
//
// A palindromic number reads the same both ways. The largest palindrome made
// from the product of two 2-digit numbers is 9009 = 91 x 99.
//
// Find the largest palindrome made from the product of two 3-digit numbers.
//
// 906609

let reverse_digits number =
  let rec loop number result =
    if number > 0 then
      loop (number / 10) (result * 10 + (number % 10))
    else
      result
  loop number 0

let is_palindrome number =
  number = reverse_digits number

let pr4_explicit () =
  let rec outer biggest a =
    if a > 999 then biggest else
      let b =
        let rec inner biggest b =
          if b > 999 then biggest
          else if is_palindrome (a * b) then
            inner (max (a * b) biggest) (b + 1)
          else
            inner biggest (b + 1)
        inner biggest a
      outer b (a + 1)
  outer 0 100

// Try this with sequences.
let pr4 () =
  seq {
    for a in 1 .. 999 do
    yield! seq {
      for b in a .. 999 do
      let c = a * b
      if is_palindrome c then yield c } }
  |> Seq.reduce max

printfn "%A" (pr4 ())
