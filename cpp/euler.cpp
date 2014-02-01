// Euler driver.

#include <cstring>
#include <iostream>
#include <map>
#include <string>

#include "problems.hpp"

void runone(const euler::Problem& prob) {
  std::cout << prob.number << ": ";
  std::cout.flush();
  prob.action();
}

void runall() {
  for (auto& prob : euler::problems) {
    runone(prob);
  }
}

int main(int argc, char* argv[]) {
  if (argc == 1) {
    std::cerr << "Usage: euler all   OR   euler n n n\n";
    return 1;
  }
  if (argc == 2 && strcmp(argv[1], "all") == 0) {
    runall();
    return 0;
  }

  // Otherwise, make a mapping, and run them individually.
  std::map<int, euler::Problem> pmap;
  for (auto prob : euler::problems) {
    pmap[prob.number] = prob;
  }

  for (auto arg = argv + 1; *arg != nullptr; ++arg) {
    const int num = std::stoi(*arg);
    auto prob = pmap.find(num);
    if (prob == pmap.end()) {
      std::cout << "Unknown problem: " << num << '\n';
    } else {
      runone(prob->second);
    }
  }

  return 0;
}
