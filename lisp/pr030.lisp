;;; Problem 30
;;;
;;; 08 November 2002
;;;
;;; Surprisingly there are only three numbers that can be written as the sum
;;; of fourth powers of their digits:
;;;
;;;     1634 = 1^4 + 6^4 + 3^4 + 4^4
;;;     8208 = 8^4 + 2^4 + 0^4 + 8^4
;;;     9474 = 9^4 + 4^4 + 7^4 + 4^4
;;;
;;; As 1 = 1^4 is not a sum it is not included.
;;;
;;; The sum of these numbers is 1634 + 8208 + 9474 = 19316.
;;;
;;; Find the sum of all the numbers that can be written as the sum of fifth
;;; powers of their digits.
;;;
;;; 443839

(defpackage #:pr030
  (:use #:cl #:iterate #:euler)
  (:export #:euler-30))
(in-package #:pr030)

(defun largest-number (power)
  "Calculate the largest number this could possibly be."
  (iter (for num first 9 then (+ (* num 10) 9))
	(for sum = (sum-digits-power num power))
	(when (> num sum)
	  (return sum))))

(defun count-summable (power)
  (iter (for i from 2 to (largest-number power))
	(when (= i (sum-digits-power i power))
	  (sum i))))

(defun euler-30 ()
  (count-summable 5))
