;;; Problem 16
;;;
;;; 03 May 2002
;;;
;;; 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
;;;
;;; What is the sum of the digits of the number 2^1000?
;;;
;;; 1366

(ns euler.pr016
  (:use clojure.math.numeric-tower))

(defn- digit-sum [n]
  (loop [n n
	 result 0]
    (if (zero? n)
      result
      (recur (quot n 10)
	     (+ result (int (mod n 10)))))))

(defn euler016 []
  (digit-sum (expt 2 1000)))
