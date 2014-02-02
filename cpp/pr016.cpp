// Problem 16
//
// 03 May 2002
//
// 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
//
// What is the sum of the digits of the number 2^1000?
//
// 1366

#include <iostream>
#include <stdexcept>
#include <vector>

namespace euler {
namespace pr016 {

const int size = 302;

using Digits = std::vector<uint8_t>;

void show(Digits& digits) {
  for (auto p = digits.rbegin(); p != digits.rend(); ++p) {
    std::cout << int(*p);
  }
  std::cout << '\n';
}

void double_number(Digits& digits) {
  int carry = 0;
  for (auto& i : digits) {
    const auto temp = i * 2 + carry;
    i = temp % 10;
    carry = temp / 10;
  }
  if (carry != 0) {
    throw std::runtime_error("Numeric overflow");
  }
}

void solve()
{
  Digits digits(size, 0);
  digits[0] = 1;

  for (auto i = 0; i < 1000; ++i) {
    double_number(digits);
  }
  int answer = 0;
  for (auto i : digits)
    answer += i;
  std::cout << answer << "\n";
}

}
}
