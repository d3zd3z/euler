// Problem 10
//
// 08 February 2002
//
// The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
//
// Find the sum of all the primes below two million.
//
// 142913828922

#include <iostream>
#include <cstdint>

#include "sieve.hpp"

namespace euler {
namespace pr010 {

void solve()
{
  Sieve sieve;
  int64_t total = 0;
  int prime = 2;
  while (prime < 2000000) {
    total += prime;
    prime = sieve.next_prime(prime);
  }
  std::cout << total << "\n";
}

}
}
