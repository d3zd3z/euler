;;; Problem 26
;;;
;;; 13 September 2002
;;;
;;; A unit fraction contains 1 in the numerator. The decimal representation of
;;; the unit fractions with denominators 2 to 10 are given:
;;;
;;;     ^1/[2]  =  0.5
;;;     ^1/[3]  =  0.(3)
;;;     ^1/[4]  =  0.25
;;;     ^1/[5]  =  0.2
;;;     ^1/[6]  =  0.1(6)
;;;     ^1/[7]  =  0.(142857)
;;;     ^1/[8]  =  0.125
;;;     ^1/[9]  =  0.(1)
;;;     ^1/[10] =  0.1
;;;
;;; Where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle. It can
;;; be seen that ^1/[7] has a 6-digit recurring cycle.
;;;
;;; Find the value of d < 1000 for which ^1/[d] contains the longest recurring
;;; cycle in its decimal fraction part.
;;;
;;; 983

(ns euler.pr026
  (:use clojure.math.numeric-tower)
  (:use euler.sieve))

(defn- dlog
  "Solve \"(expt 10 k) == 1 (mod n)\".  Should not be called with a
  factor of 10, or it will not terminate."
  [n]
  (loop [k 1]
    (if (= (mod (expt 10 k) n) 1)
      k
      (recur (inc k)))))

(defn- bump
  "(bump [nx (dlog nx)] n) will return either the existing first
argument, or a new-pair if the dlog of n is greater than the current
greatest one."
  [state n]
  (let [dlog-n (dlog n)]
    (if (> dlog-n (first state))
      [n dlog-n]
      state)))

(defn euler026 []
  (let [numbers (drop-while #(< % 7)
			    (take-while #(< % 1000)
					(lazy-primes)))]
    (first (reduce bump [0 0] numbers))))
