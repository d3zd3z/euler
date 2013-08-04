// Problem 3
//
// 02 November 2001
//
//
// The prime factors of 13195 are 5, 7, 13 and 29.
//
// What is the largest prime factor of the number 600851475143 ?
//
// 6857

let pr3 () =
  let rec loop (number : int64) (factor : int64) =
    if number = 1L then factor
    else if number % factor = 0L then
      loop (number / factor) factor
    else
      loop number (if factor = 2L then 3L else factor + 2L)
  loop 600851475143L 2L

printfn "%d" (pr3 ())
