// Problem 4
//
// 16 November 2001
//
//
// A palindromic number reads the same both ways. The largest palindrome made
// from the product of two 2-digit numbers is 9009 = 91 × 99.
//
// Find the largest palindrome made from the product of two 3-digit numbers.
//
// 906609

int main() {
	int largest = 0;
	for (var a = 100; a <= 999; a++) {
		for (var b = a; b <= 999; b++) {
			var c = a * b;
			if (c > largest && is_palindrome(c))
				largest = c;
		}
	}
	stdout.printf("%d\n", largest);
	return 0;
}

bool is_palindrome(int n) {
	return n == reverse(n);
}

int reverse(int n) {
	int result = 0;
	while (n > 0) {
		result = result * 10 + n % 10;
		n = n / 10;
	}
	return result;
}
