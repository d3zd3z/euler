;;; Problem 21
;;;
;;; 05 July 2002
;;;
;;; Let d(n) be defined as the sum of proper divisors of n (numbers less than
;;; n which divide evenly into n).
;;; If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair
;;; and each of a and b are called amicable numbers.
;;;
;;; For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22,
;;; 44, 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1,
;;; 2, 4, 71 and 142; so d(284) = 220.
;;;
;;; Evaluate the sum of all the amicable numbers under 10000.
;;;
;;; 31626

(defpackage #:pr021
  (:use #:cl #:iterate #:euler.sieve)
  (:export #:euler-21))
(in-package #:pr021)

(defun proper-divisor-sum (n)
  (iter (for x in (divisors n))
	(while (< x n))
	(sum x)))

(defun amicablep (n)
  (let ((other (proper-divisor-sum n)))
    (and (/= n other)
	 (= n (proper-divisor-sum other)))))

(defun euler-21 ()
  (iter (for i from 1 to 10000)
	(when (amicablep i)
	  (sum i))))
(setf (get 'euler-21 :euler-answer) 31626)
