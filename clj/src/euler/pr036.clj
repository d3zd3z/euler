;;; Problem 36
;;;
;;; 31 January 2003
;;;
;;; The decimal number, 585 = 1001001001[2] (binary), is palindromic in both
;;; bases.
;;;
;;; Find the sum of all numbers, less than one million, which are palindromic
;;; in base 10 and base 2.
;;;
;;; (Please note that the palindromic number, in either base, may not include
;;; leading zeros.)
;;;
;;; 872187

(ns euler.pr036
  (:use euler.misc))

(defn euler036 []
  (reduce +
	  (for [i (range 1 1000000)]
	    (if (and (palindrome-number? i 10)
		     (palindrome-number? i 2))
	      i
	      0))))
