// Problem 6
//
// 14 December 2001
//
//
// The sum of the squares of the first ten natural numbers is,
//
// 1^2 + 2^2 + ... + 10^2 = 385
//
// The square of the sum of the first ten natural numbers is,
//
// (1 + 2 + ... + 10)^2 = 55^2 = 3025
//
// Hence the difference between the sum of the squares of the first ten
// natural numbers and the square of the sum is 3025 − 385 = 2640.
//
// Find the difference between the sum of the squares of the first one
// hundred natural numbers and the square of the sum.
//
// 25164150

use "collections"

actor Main
  new create(env: Env) =>
    var sum_sq: U64 = 0
    var sum: U64 = 0

    for i in Range[U64](1, 101) do
      sum = sum + i
      sum_sq = sum_sq + (i * i)
    end

    let answer = (sum * sum) - sum_sq

    env.out.print(answer.string())
