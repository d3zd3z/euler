;;; Problem 23
;;;
;;; 02 August 2002
;;;
;;; A perfect number is a number for which the sum of its proper divisors is
;;; exactly equal to the number. For example, the sum of the proper divisors
;;; of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect
;;; number.
;;;
;;; A number n is called deficient if the sum of its proper divisors is less
;;; than n and it is called abundant if this sum exceeds n.
;;;
;;; As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the
;;; smallest number that can be written as the sum of two abundant numbers is
;;; 24. By mathematical analysis, it can be shown that all integers greater
;;; than 28123 can be written as the sum of two abundant numbers. However,
;;; this upper limit cannot be reduced any further by analysis even though it
;;; is known that the greatest number that cannot be expressed as the sum of
;;; two abundant numbers is less than this limit.
;;;
;;; Find the sum of all the positive integers which cannot be written as the
;;; sum of two abundant numbers.
;;;
;;; 4179871

(ns euler.pr023
  (:use euler.sieve)
  (:use clojure.set))

(defn- abundant? [sieve n]
  (> (proper-divisor-sum sieve n) n))

(defn- abundants [sieve limit]
  (filter #(abundant? sieve %) (range 1 (inc limit))))

(defn euler023 []
  (let [sieve (make-sieve)
	limit 28123
	abundant-list (abundants sieve limit)
	summable (set (for [a abundant-list
			    b abundant-list
			    :let [ab (+ a b)]
			    :when (<= ab limit)]
			ab))
	all-ints (set (range 1 (inc limit)))
	not-writable (difference all-ints summable)]
    (reduce + not-writable)))
