// Problem 3
//
// 02 November 2001
//
// The prime factors of 13195 are 5, 7, 13 and 29.
//
// What is the largest prime factor of the number 600851475143 ?
//
// 6857

#include <iostream>

namespace euler {
namespace pr003 {

void solve()
{
  long long number = 600851475143;
  int factor = 2;

  while (number > 1) {
    if (number % factor == 0)
      number /= factor;
    else
      factor = (factor == 2 ? 3 : factor + 2);
  }

  std::cout << factor << "\n";
}

}
}
