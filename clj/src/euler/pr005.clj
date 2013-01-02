;;; Problem 5
;;;
;;; 30 November 2001
;;;
;;; 2520 is the smallest number that can be divided by each of the numbers
;;; from 1 to 10 without any remainder.
;;;
;;; What is the smallest positive number that is evenly divisible by all of
;;; the numbers from 1 to 20?
;;;
;;; 232792560

(ns euler.pr005)

(defn gcd
  [a b]
  (loop [a a
	 b b]
    (if (zero? b) a
	(recur b (mod a b)))))

(defn lcm
  [a b]
  (* (/ a (gcd a b)) b))

(defn euler005
  []
  (reduce lcm (range 1 21)))
