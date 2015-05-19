// Problem 1
// 
// 05 October 2001
// 
// If we list all the natural numbers below 10 that are multiples of 3 or 5,
// we get 3, 5, 6 and 9. The sum of these multiples is 23.
// 
// Find the sum of all the multiples of 3 or 5 below 1000.

use "collections"

actor Main
  new create(env: Env) =>
    var total: U32 = 0
    for i in Range[U32](1, 1000) do
      if ((i % 3) == 0) or ((i % 5) == 0) then
	total = total + i
      end
    end
    env.out.print(total.string())
