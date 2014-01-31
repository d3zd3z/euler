// Euler driver.

#include <iostream>

#include "problems.hpp"

int main(int argc, char* argv[]) {
  /*
  for (auto arg = argv + 1; *arg != nullptr; ++arg) {
    std::cout << *arg << '\n';
  }
  */

  for (auto prob : euler::problems) {
    std::cout << prob.number << ": ";
    prob.action();
  }
}
