// Problem 15
//
// 19 April 2002
//
// Starting in the top left corner of a 2×2 grid, there are 6 routes (without
// backtracking) to the bottom right corner.
//
// [p_015]
//
// How many routes are there through a 20×20 grid?
//
// 137846528820

#include <iostream>
#include <vector>

namespace euler {
namespace pr015 {

const int steps = 20;

void bump(std::vector<int64_t>& values) {
  for (auto i = 0; i < steps; ++i) {
    values[i+1] += values[i];
  }
}

void solve()
{
  std::vector<int64_t> values(steps + 1, 1);
  for (auto i = 0; i < steps; ++i)
    bump(values);
  std::cout << values[steps] << "\n";
}

}
}
