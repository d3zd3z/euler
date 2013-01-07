;;; Problem 4
;;;
;;; 16 November 2001
;;;
;;; A palindromic number reads the same both ways. The largest palindrome made
;;; from the product of two 2-digit numbers is 9009 = 91 x 99.
;;;
;;; Find the largest palindrome made from the product of two 3-digit numbers.
;;;
;;; 906609

(ns euler.pr004
  (:use euler.misc))

(defn euler004
  []
  (reduce max (for [a (range 100 1000)
		    b (range a 1000)
		    :let [c (* a b)]
		    :when (palindrome-number? c)]
		c)))
