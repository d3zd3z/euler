// Problem 9
//
// 25 January 2002
//
// A Pythagorean triplet is a set of three natural numbers, a < b < c, for
// which,
//
// a^2 + b^2 = c^2
//
// For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.
//
// There exists exactly one Pythagorean triplet for which a + b + c = 1000.
// Find the product abc.
//
// 31875000

#include <iostream>

namespace euler {
namespace pr009 {

void solve()
{
  int answer = 0;
  for (auto a = 1; a < 1000; ++a) {
    for (auto b = a; b < 1000; ++b) {
      const auto c = 1000 - a - b;
      if (c > b && a*a + b*b == c*c)
	answer = a*b*c;
    }
  }
  std::cout << answer << "\n";
}

}
}
