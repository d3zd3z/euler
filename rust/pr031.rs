// Problem 31
//
// 22 November 2002
//
//
// In England the currency is made up of pound, -L-, and pence, p, and there
// are eight coins in general circulation:
//
//     1p, 2p, 5p, 10p, 20p, 50p, -L-1 (100p) and -L-2 (200p).
//
// It is possible to make -L-2 in the following way:
//
//     1x-L-1 + 1x50p + 2x20p + 1x5p + 1x2p + 3x1p
//
// How many different ways can -L-2 be made using any number of coins?
//
// 73682

// Using a list avoids a lot of vector copies, and makes this about 10x faster.

// Needed until list is converted to use Rc or Gc.
#[feature(managed_boxes)]

extern mod extra;
use extra::list;
use extra::list::List;

fn main() {
    println(format!("{}", rways(200, allCoins())));
}

fn rways(remaining: uint, coins: @List<uint>) -> uint {
    if list::is_empty(coins) {
        if remaining == 0 { 1 } else { 0 }
    } else {
        let coin = list::head(coins);
        let others = list::tail(coins);

        // TODO: Is there a range-like operator that can decrease?
        let mut total = 0;
        let mut r = remaining as int;
        while r >= 0 {
            let r2 = r as uint;
            total += rways(r2, others);

            r -= coin as int;
        }
        total
    }
}

fn allCoins() -> @List<uint> {
    // Best performance puts the largest coins first.
    list::from_vec([200u, 100, 50, 20, 10, 5, 2, 1])
}
