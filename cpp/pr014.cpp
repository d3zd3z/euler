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
#include <vector>

namespace euler {
namespace pr014 {

// Simple non-memoized solution
struct Simple {
  int chainLength(long long n);
};

int Simple::chainLength(long long n) {
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

// Cached version.
// The cache seems to have to be at least 10k for this to be faster
// than the simple (non-recursive) version.  Above that, it gets
// faster the larger the cache is, until around a million or so, where
// it actually gets a bit slower (memory management, perhaps)?
class Cached {
 public:
  Cached() {
    cache.assign(10240, -1);
  }
  int chainLength(long long n);
 private:
  std::vector<int> cache;
  int nextChain(long long n);
};

int Cached::chainLength(long long n) {
  if (n < (long long)cache.size()) {
    auto sz = cache[n];
    if (sz >= 0)
      return sz;
    sz = nextChain(n);
    cache[n] = sz;
    return sz;
  } else {
    return nextChain(n);
  }
}

int Cached::nextChain(long long n) {
  if (n == 1)
    return 1;
  if (n % 2 == 0)
    return 1 + chainLength(n / 2);
  else
    return 1 + chainLength(n * 3 + 1);
}

template<class T>
int solution() {
  T solver;
  int largest = 0;
  int largest_value = 0;
  for (int i = 1; i < 1000000; i++) {
    int tmp = solver.chainLength(i);
    if (tmp > largest) {
      largest = tmp;
      largest_value = i;
    }
  }
  return largest_value;
}

void solve()
{
  int answer = solution<Simple>();
  // int answer = solution<Cached>();
  std::cout << answer << "\n";
}

}
}
