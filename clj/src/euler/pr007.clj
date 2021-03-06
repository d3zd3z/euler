;;; Problem 7
;;;
;;; 28 December 2001
;;;
;;; By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see
;;; that the 6th prime is 13.
;;;
;;; What is the 10 001st prime number?
;;;
;;; 104743

(ns euler.pr007
  (:use euler.sieve))

(defn euler007 []
  (nth (lazy-primes) 10000))
