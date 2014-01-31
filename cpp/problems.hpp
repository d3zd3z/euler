// The problem sets.

#ifndef __PROBLEMS_HPP__
#define __PROBLEMS_HPP__

#include <vector>

namespace euler {

struct Problem {
  int number;
  void (*action)();
};

extern const std::vector<Problem> problems;

}

#endif /* __PROBLEMS_HPP__ */
