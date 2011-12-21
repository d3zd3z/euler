//////////////////////////////////////////////////////////////////////
// Problem 80
//
// 08 October 2004
//
// It is well known that if the square root of a natural number
// is not an integer, then it is irrational. The decimal
// expansion of such square roots is infinite without any
// repeating pattern at all.
//
// The square root of two is 1.41421356237309504880..., and the
// digital sum of the first one hundred decimal digits is 475.
//
// For the first one hundred natural numbers, find the total of
// the digital sums of the first one hundred decimal digits for
// all the irrational square roots.
//////////////////////////////////////////////////////////////////////

package main

import (
	"big"
	"fmt"
)

// And, worse, this gives the wrong answer.
func main() {
	fmt.Printf("Hello world\n")
	fmt.Printf("Num: %+v\n", sumInts(isqrt(toBase100(2))))
	sum := 0
	for i := 1; i <= 100; i++ {
		tmp := intSqrt(i)
		if tmp * tmp != i {
			sum += sumInts(isqrt(toBase100(i)))
		}
	}
	fmt.Printf("%d\n", sum)
}

func toBase100(num int) (result []int) {
	tmp := make([]int, 0, 10)

	for num > 0 {
		tmp = append(tmp, num % 100)
		num /= 100
	}
	result = make([]int, 0, 100)
	result = append(result, tmp...)

	for len(result) < 100 {
		result = append(result, 0)
	}

	return
}

// Integer square root.
func intSqrt(num int) (result int) {
	bit := 1
	for (bit << 2) < num {
		bit <<= 2
	}

	for bit != 0 {
		if num >= result + bit {
			num -= result + bit
			result = (result >> 1) + bit
		} else {
			result >>= 1
		}
		bit >>= 2
	}
	return
}

func isqrt(digits []int) (result []int) {
	result = make([]int, len(digits))

	var p big.Int
	var c big.Int
	var hundred big.Int
	hundred.SetInt64(100)

	var p20 big.Int
	var y big.Int
	var aBig big.Int
	var ten big.Int
	ten.SetInt64(10)
	for i, dig := range digits {
		// fmt.Printf("c=%v, p=%v\n", &c, &p)
		aBig.SetInt64(int64(dig))
		c.Mul(&c, &hundred)
		c.Add(&c, &aBig)

		x := 9
		var xBig big.Int
		p20.SetInt64(20)
		p20.Mul(&p20, &p)

		for {
			xBig.SetInt64(int64(x))
			y.Add(&p20, &xBig)
			y.Mul(&y, &xBig)
			if y.Cmp(&c) < 0 {
				c.Sub(&c, &y)
				break
			} else {
				x--
			}
		}
		result[i] = x
		p.Mul(&p, &ten)
		p.Add(&p, &xBig)
	}

	return
}

func sumInts(digits []int) (sum int) {
	for _, dig := range digits {
		sum += dig
	}
	return
}

/*
module Main where

-- See:
-- http://en.wikipedia.org/wiki/Methods_of_computing_square_roots#Decimal_.28base_10.29
-- for a description of this algorithm.

nextP :: Integer -> Integer -> (Integer, Integer)
nextP p c =
   walk 9 where
   walk x = let y = (p20 + x) * x in if y < c then (x, c-y) else walk (x-1)
   p20 = p * 20

iSqrtDigs :: Integer -> Integer -> [Int] -> [Int]
iSqrtDigs _ _ [] = []
iSqrtDigs p c (a:as) =
   let aInt = fromIntegral a in
   let c' = c * 100 + aInt in
   let (x, c2) = nextP p c' in
   fromIntegral x : iSqrtDigs (p * 10 + x) c2 as

deBase100 0 = []
deBase100 n = deBase100 (n `div` 100) ++ [n `mod` 100]

sourceNum :: Int -> [Int]
sourceNum n = take 100 $ deBase100 n ++ repeat 0

sqrtSum :: Int -> Int
sqrtSum = sum . iSqrtDigs 0 0 . sourceNum

isqrt :: Int -> Int
isqrt = floor . sqrt . fromIntegral 

isSquare :: Int -> Bool
isSquare x = let q = isqrt x in q*q == x

euler80 :: Int
euler80 = sum $ map sqrtSum $ filter (not . isSquare) [1 .. 100]

main :: IO ()
main = print euler80
*/
