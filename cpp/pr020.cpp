// Problem 20
//
// 21 June 2002
//
// n! means n × (n − 1) × ... × 3 × 2 × 1
//
// For example, 10! = 10 × 9 × ... × 3 × 2 × 1 = 3628800,
// and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 =
// 27.
//
// Find the sum of the digits in the number 100!
//
// 648

#include <iostream>
#include <stdexcept>
#include <vector>

namespace euler {
namespace pr020 {

// Implement this with a base-10000 representation of the number.
class BigBase {
  const int base = 10000;

  std::vector<int> digits;
 public:
  BigBase(int len) {
    digits.assign(len, 0);
    digits[0] = 1;
  }

  void multiply(int by);
  int digit_sum();
};

void BigBase::multiply(int by) {
  int carry = 0;
  for (int i = 0; i < int(digits.size()); ++i) {
    const int temp = digits[i] * by + carry;
    digits[i] = temp % base;
    carry = temp / base;
  }
  if (carry != 0) {
    throw std::overflow_error("Overflow error in multiply");
  }
}

int BigBase::digit_sum() {
  int total = 0;
  for (auto dig: digits) {
    auto tmp = dig;
    while (tmp > 0) {
      total += tmp % 10;
      tmp /= 10;
    }
  }
  return total;
}

void solve()
{
  BigBase acc(40);
  for (int i = 2; i <= 100; ++i) {
    acc.multiply(i);
  }
  int answer = acc.digit_sum();
  std::cout << answer << "\n";
}

}
}
