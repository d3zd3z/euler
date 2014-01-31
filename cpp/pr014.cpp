// Problem 14
//
// 05 April 2002
//
// The following iterative sequence is defined for the set of positive
// integers:
//
// n → n/2 (n is even)
// n → 3n + 1 (n is odd)
//
// Using the rule above and starting with 13, we generate the following
// sequence:
//
// 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
//
// It can be seen that this sequence (starting at 13 and finishing at 1)
// contains 10 terms. Although it has not been proved yet (Collatz Problem),
// it is thought that all starting numbers finish at 1.
//
// Which starting number, under one million, produces the longest chain?
//
// NOTE: Once the chain starts the terms are allowed to go above one million.
//
// 837799

#include <iostream>

namespace euler {
namespace pr014 {

// Simple non-memoized solution
int chainLength(long long n) {
  int len = 1;
  while (n != 1) {
    len++;
    if (n % 2 == 0)
      n /= 2;
    else
      n = n * 3 + 1;
  }
  return len;
}

int solution() {
  int largest = 0;
  int largest_value = 0;
  for (int i = 1; i < 1000000; i++) {
    int tmp = chainLength(i);
    if (tmp > largest) {
      largest = tmp;
      largest_value = i;
    }
  }
  return largest_value;
}

void solve()
{
  int answer = solution();
  std::cout << answer << "\n";
}

}
}
