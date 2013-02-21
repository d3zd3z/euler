;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Problem 4
;;
;; 16 November 2001
;;
;; A palindromic number reads the same both ways. The largest
;; palindrome made from the product of two 2-digit numbers is 9009 = 91
;; × 99.
;;
;; Find the largest palindrome made from the product of two 3-digit
;; numbers.
;;
;; 906609
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defpackage #:pr004
  (:use #:cl #:iterate)
  (:export #:euler-4))
(in-package #:pr004)

(defun reverse-number (number)
  "Reverse the digits of the positive number"
  (iter (with result = 0)
	(with n = number)
	(while (plusp n))
	(for (values num den) = (truncate n 10))
	(setf n num)
	(setf result (+ (* result 10) den))
	(finally (return result))))

(defun palindromep (number)
  "Is this number a palindrome?"
  (= number (reverse-number number)))

(defun euler-4 ()
  (iter outer
	(for a from 100 to 999)
	(iter (for b from a to 999)
	      (for prod = (* a b))
	      (when (palindromep prod)
		(in outer (finding (list prod a b) maximizing prod))))))
