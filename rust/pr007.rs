// Problem 7
//
// 28 December 2001
//
// By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see
// that the 6th prime is 13.
//
// What is the 10 001st prime number?
//
// 104743

fn main() {
    let mut primes = sieve::make(110000u);
    let mut prime = 2u;
    let mut count = 1;

    while count < 10001 {
        prime = sieve::next_prime(primes, prime);
        count += 1;
    }

    io::println(#fmt("%u", prime));
}
