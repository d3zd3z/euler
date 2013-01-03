;;; Problem 10
;;;
;;; 08 February 2002
;;;
;;; The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
;;;
;;; Find the sum of all the primes below two million.
;;;
;;; 142913828922

(ns euler.pr010
  (:use euler.sieve))

(defn euler010 []
  (reduce + (for [x (lazy-primes)
		  :while (< x 2000000)]
	      x)))
	      