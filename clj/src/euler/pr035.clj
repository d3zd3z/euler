;;; Problem 35
;;;
;;; 17 January 2003
;;;
;;; The number, 197, is called a circular prime because all rotations of the
;;; digits: 197, 971, and 719, are themselves prime.
;;;
;;; There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37,
;;; 71, 73, 79, and 97.
;;;
;;; How many circular primes are there below one million?
;;;
;;; 55

(ns euler.pr035
  (:use clojure.math.numeric-tower)
  (:use euler.sieve))

(defn- number-of-digits
  "Return the number of digits in the given number.  Considers zero to
have no digits"
  [number]
  (loop [number number
	 count 0]
    (if (zero? number)
      count
      (recur (quot number 10) (inc count)))))

(defn- number-rotations
  "Return all of the rotations of the given number."
  [number]
  (let [len (number-of-digits number)]
    (loop [right (dec len)
	   left 0
	   accum 0
	   n number
	   result []]
      (if (neg? right)
	result
	(let [n-quotient (quot n 10)
	      n-remainder (rem n 10)
	      new-accum (+ accum (* (expt 10 left) n-remainder))]
	  (recur (dec right)
		 (inc left)
		 new-accum
		 n-quotient
		 (conj result (+ n-quotient (* (expt 10 right) new-accum)))))))))

(defn euler035 []
  (count
   (let [sieve (make-sieve)]
     (for [p (sieved-lazy-primes sieve)
	   :while (< p 1000000)
	   :when (every? #(prime? sieve %) (number-rotations p))]
       p))))
