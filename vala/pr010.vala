// Problem 10
//
// 08 February 2002
//
//
// The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
//
// Find the sum of all the primes below two million.
//
// 142913828922

int main() {
	int64 total = 0;
	int p = 2;
	var sv = new Euler.Sieve();
	while (p < 2000000) {
		total += p;
		p = sv.next_prime(p);
	}
	stdout.printf("%Ld\n", total);
	return 0;
}
