// Problem 11
//
// 22 February 2002
//
// In the 20×20 grid below, four numbers along a diagonal line have been
// marked in red.
//
// 08 02 22 97 38 15 00 40 00 75 04 05 07 78 52 12 50 77 91 08
// 49 49 99 40 17 81 18 57 60 87 17 40 98 43 69 48 04 56 62 00
// 81 49 31 73 55 79 14 29 93 71 40 67 53 88 30 03 49 13 36 65
// 52 70 95 23 04 60 11 42 69 24 68 56 01 32 56 71 37 02 36 91
// 22 31 16 71 51 67 63 89 41 92 36 54 22 40 40 28 66 33 13 80
// 24 47 32 60 99 03 45 02 44 75 33 53 78 36 84 20 35 17 12 50
// 32 98 81 28 64 23 67 10 26 38 40 67 59 54 70 66 18 38 64 70
// 67 26 20 68 02 62 12 20 95 63 94 39 63 08 40 91 66 49 94 21
// 24 55 58 05 66 73 99 26 97 17 78 78 96 83 14 88 34 89 63 72
// 21 36 23 09 75 00 76 44 20 45 35 14 00 61 33 97 34 31 33 95
// 78 17 53 28 22 75 31 67 15 94 03 80 04 62 16 14 09 53 56 92
// 16 39 05 42 96 35 31 47 55 58 88 24 00 17 54 24 36 29 85 57
// 86 56 00 48 35 71 89 07 05 44 44 37 44 60 21 58 51 54 17 58
// 19 80 81 68 05 94 47 69 28 73 92 13 86 52 17 77 04 89 55 40
// 04 52 08 83 97 35 99 16 07 97 57 32 16 26 26 79 33 27 98 66
// 88 36 68 87 57 62 20 72 03 46 33 67 46 55 12 32 63 93 53 69
// 04 42 16 73 38 25 39 11 24 94 72 18 08 46 29 32 40 62 76 36
// 20 69 36 41 72 30 23 88 34 62 99 69 82 67 59 85 74 04 36 16
// 20 73 35 29 78 31 90 01 74 31 49 71 48 86 81 16 23 57 05 54
// 01 70 54 71 83 51 54 69 16 92 33 48 61 43 52 01 89 19 67 48
//
// The product of these numbers is 26 × 63 × 78 × 14 = 1788696.
//
// What is the greatest product of four adjacent numbers in any direction
// (up, down, left, right, or diagonally) in the 20×20 grid?
//
// 70600674

fn main() {
    let mut max = 0u;
    let deltas = ~[Delta {dx: 0, dy: 1}, Delta {dx: 1, dy: 0},
                   Delta {dx: 1, dy: 1}, Delta {dx: 1, dy: -1}];
    let src = source();
    for x in range(0, 20) {
        for y in range(0, 20) {
            for delta in deltas.iter() {
                let prod = product(src, x, y, delta);
                if prod > max {
                    max = prod;
                }
            }
        }
    }
    println(fmt!("%u", max));
}

struct Delta {dx: int, dy: int}

fn product(ary: &[~[uint]], x: int, y: int, d: &Delta) -> uint {
    let mut px = x;
    let mut py = y;
    let mut prod = 1u;
    let mut count = 0u;
    while count < 4u {
        count += 1u;
        if px >= 20 || py >= 20 || px < 0 || py < 0 { prod = 0u; break; }
        prod *= ary[py][px];
        px += d.dx;
        py += d.dy;
    }
    prod
}

fn source() -> ~[~[uint]] {
    let mut result: ~[~[uint]] = ~[];

    result.push(~[08u, 02u, 22u, 97u, 38u, 15u, 00u, 40u, 00u, 75u,
            04u, 05u, 07u, 78u, 52u, 12u, 50u, 77u, 91u, 08u]);
    result.push(~[49u, 49u, 99u, 40u, 17u, 81u, 18u, 57u, 60u, 87u,
            17u, 40u, 98u, 43u, 69u, 48u, 04u, 56u, 62u, 00u]);
    result.push(~[81u, 49u, 31u, 73u, 55u, 79u, 14u, 29u, 93u, 71u,
            40u, 67u, 53u, 88u, 30u, 03u, 49u, 13u, 36u, 65u]);
    result.push(~[52u, 70u, 95u, 23u, 04u, 60u, 11u, 42u, 69u, 24u,
            68u, 56u, 01u, 32u, 56u, 71u, 37u, 02u, 36u, 91u]);
    result.push(~[22u, 31u, 16u, 71u, 51u, 67u, 63u, 89u, 41u, 92u,
            36u, 54u, 22u, 40u, 40u, 28u, 66u, 33u, 13u, 80u]);
    result.push(~[24u, 47u, 32u, 60u, 99u, 03u, 45u, 02u, 44u, 75u,
            33u, 53u, 78u, 36u, 84u, 20u, 35u, 17u, 12u, 50u]);
    result.push(~[32u, 98u, 81u, 28u, 64u, 23u, 67u, 10u, 26u, 38u,
            40u, 67u, 59u, 54u, 70u, 66u, 18u, 38u, 64u, 70u]);
    result.push(~[67u, 26u, 20u, 68u, 02u, 62u, 12u, 20u, 95u, 63u,
            94u, 39u, 63u, 08u, 40u, 91u, 66u, 49u, 94u, 21u]);
    result.push(~[24u, 55u, 58u, 05u, 66u, 73u, 99u, 26u, 97u, 17u,
            78u, 78u, 96u, 83u, 14u, 88u, 34u, 89u, 63u, 72u]);
    result.push(~[21u, 36u, 23u, 09u, 75u, 00u, 76u, 44u, 20u, 45u,
            35u, 14u, 00u, 61u, 33u, 97u, 34u, 31u, 33u, 95u]);
    result.push(~[78u, 17u, 53u, 28u, 22u, 75u, 31u, 67u, 15u, 94u,
            03u, 80u, 04u, 62u, 16u, 14u, 09u, 53u, 56u, 92u]);
    result.push(~[16u, 39u, 05u, 42u, 96u, 35u, 31u, 47u, 55u, 58u,
            88u, 24u, 00u, 17u, 54u, 24u, 36u, 29u, 85u, 57u]);
    result.push(~[86u, 56u, 00u, 48u, 35u, 71u, 89u, 07u, 05u, 44u,
            44u, 37u, 44u, 60u, 21u, 58u, 51u, 54u, 17u, 58u]);
    result.push(~[19u, 80u, 81u, 68u, 05u, 94u, 47u, 69u, 28u, 73u,
            92u, 13u, 86u, 52u, 17u, 77u, 04u, 89u, 55u, 40u]);
    result.push(~[04u, 52u, 08u, 83u, 97u, 35u, 99u, 16u, 07u, 97u,
            57u, 32u, 16u, 26u, 26u, 79u, 33u, 27u, 98u, 66u]);
    result.push(~[88u, 36u, 68u, 87u, 57u, 62u, 20u, 72u, 03u, 46u,
            33u, 67u, 46u, 55u, 12u, 32u, 63u, 93u, 53u, 69u]);
    result.push(~[04u, 42u, 16u, 73u, 38u, 25u, 39u, 11u, 24u, 94u,
            72u, 18u, 08u, 46u, 29u, 32u, 40u, 62u, 76u, 36u]);
    result.push(~[20u, 69u, 36u, 41u, 72u, 30u, 23u, 88u, 34u, 62u,
            99u, 69u, 82u, 67u, 59u, 85u, 74u, 04u, 36u, 16u]);
    result.push(~[20u, 73u, 35u, 29u, 78u, 31u, 90u, 01u, 74u, 31u,
            49u, 71u, 48u, 86u, 81u, 16u, 23u, 57u, 05u, 54u]);
    result.push(~[01u, 70u, 54u, 71u, 83u, 51u, 54u, 69u, 16u, 92u,
            33u, 48u, 61u, 43u, 52u, 01u, 89u, 19u, 67u, 48u]);
    result
}
