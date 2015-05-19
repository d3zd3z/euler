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

actor Main
  new create(env: Env) =>
    var n: U64 = 600851475143
    var p: U64 = 3
    while n > 1 do
      if (n % p) == 0 then
	n = n / p
      else
	p = p + 2
      end
    end

    env.out.print(p.string())
