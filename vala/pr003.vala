// Problem 3
//
// 02 November 2001
//
//
// The prime factors of 13195 are 5, 7, 13 and 29.
//
// What is the largest prime factor of the number 600851475143 ?
//
// 6857

int main() {
	int64 n = 600851475143;
	int p = 3;
	while (n > 1) {
		if (n % p == 0)
			n /= p;
		else
			p += 2;
	}
	stdout.printf("%d\n", p);
	return 0;
}
