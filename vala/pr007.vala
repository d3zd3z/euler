// Problem 7
//
// 28 December 2001
//
//
// By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see
// that the 6th prime is 13.
//
// What is the 10 001st prime number?
//
// 104743

int main() {
	var sv = new Euler.Sieve();
	// sv.dump();
	var p = 2;
	for (var i = 2; i <= 10001; i++) {
		p = sv.next_prime(p);
	}
	stdout.printf("%d\n", p);
	return 0;
}
