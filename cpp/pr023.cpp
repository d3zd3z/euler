// Problem 23
//
// 02 August 2002
//
// A perfect number is a number for which the sum of its proper divisors is
// exactly equal to the number. For example, the sum of the proper divisors
// of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect
// number.
//
// A number n is called deficient if the sum of its proper divisors is less
// than n and it is called abundant if this sum exceeds n.
//
// As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the
// smallest number that can be written as the sum of two abundant numbers is
// 24. By mathematical analysis, it can be shown that all integers greater
// than 28123 can be written as the sum of two abundant numbers. However,
// this upper limit cannot be reduced any further by analysis even though it
// is known that the greatest number that cannot be expressed as the sum of
// two abundant numbers is less than this limit.
//
// Find the sum of all the positive integers which cannot be written as the
// sum of two abundant numbers.
//
// ?

#include <iostream>
#include <vector>
#include <unordered_set>

// Note that the unordered sets seems to make this about 3.5x faster.

namespace euler {
  namespace pr023 {

    using namespace std;

    vector<int> make_divisors(int limit) {
      vector<int> result(limit, 1);
      result[0] = -1;
      for (int i = 2; i < limit; ++i) {
        for (int j = i + i; j < limit; j += i)
          result[j] += i;
      }
      return result;
    }

    vector<int> make_abundants(int limit) {
      auto divisors = make_divisors(limit);
      vector<int> result;
      for (int i = 1; i < limit; ++i) {
        if (i < divisors[i])
          result.push_back(i);
      }
      return result;
    }

    void solve()
    {
      const int limit = 28124;
      auto abundants = make_abundants(limit);
      const unsigned abundant_size = abundants.size();
      unordered_set<int> invalids;

      for (unsigned ai = 0; ai < abundant_size; ++ai) {
        auto a = abundants[ai];
        for (unsigned bi = ai; bi < abundant_size; ++bi) {
          auto both = a + abundants[bi];
          if (both >= limit)
            break;
          invalids.insert(both);
        }
      }

      int answer = 0;
      for (int i = 1; i < limit; ++i) {
        if (invalids.count(i) == 0)
          answer += i;
      }

      std::cout << answer << "\n";
    }

  }
}
