// Problem 10
//
// 08 February 2002
//
// The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
//
// Find the sum of all the primes below two million.
//
// 142913828922

extern mod std;
mod sieve;

fn main() {
    let mut primes = sieve::Sieve::new();

    let mut total = 0u;
    let mut p = 2u;
    while p < 2_000_000u {
        total += p;
        p = primes.next_prime(p);
    }

    io::println(fmt!("%u", total));
}
