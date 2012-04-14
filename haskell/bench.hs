-- Benchmark the sieve.

module Main where

import Primes

main :: IO ()
main = print $ last $ takeWhile (< 10000000) $ fprimes
