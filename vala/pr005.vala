// Problem 5
//
// 30 November 2001
//
//
// 2520 is the smallest number that can be divided by each of the numbers
// from 1 to 10 without any remainder.
//
// What is the smallest positive number that is evenly divisible by all of
// the numbers from 1 to 20?
//
// 232792560

int main() {
	var total = 1;
	for (var i = 2; i < 20; i++) {
		total = lcm(total, i);
	}
	stdout.printf("%d\n", total);
	return 0;
}

int lcm(int a, int b) {
	return a / gcd(a, b) * b;
}

// GCC will tail-call fix this.
// clang seems to as well.
int gcd(int a, int b) {
	if (b == 0)
		return a;
	return gcd(b, a % b);
}
