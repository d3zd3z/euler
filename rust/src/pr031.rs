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

// By using slices, we avoid copies of the data.

define_problem!(pr031, 31, 73682);

fn pr031() -> uint {
    let coins = all_coins();
    rways(200, &coins[])
}

fn rways(remaining: uint, coins: &[uint]) -> uint {
    if coins.is_empty() {
        if remaining == 0 { 1 } else { 0 }
    } else {
        let coin = coins[0];
        let others = coins.tail();

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

fn all_coins() -> Vec<uint> {
    vec![200, 100, 50, 20, 10, 5, 2, 1]
}
