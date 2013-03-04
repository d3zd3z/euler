;;; Problem 52
;;;
;;; 12 September 2003
;;;
;;; It can be seen that the number, 125874, and its double, 251748, contain
;;; exactly the same digits, but in a different order.
;;;
;;; Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x, and 6x,
;;; contain the same digits.
;;;
;;; 142857

;;; The answer is actually a fairly commonly known fact about the
;;; repeating decimal digits of the value 1/7.  However, it is still
;;; an interesting problem to solve efficiently by searching.
;;;
;;; Some simple deduction can easily determine that the result will be
;;; 6 digits, and will start with a 1.

(defpackage #:pr052
  (:use #:cl #:iterate)
  (:export #:euler-52))
(in-package #:pr052)

(defun digits-of (number)
  "Convert the number to it's digit representation, with the digits
sorted canonically."
  (let ((text (princ-to-string number)))
    (sort text #'char<)))

(defun euler-52 ()
  (iter (for i from 100000 to 199999)
	(for i-digits = (digits-of i))
	(iter (for mult from 2 to 6)
	      (unless (string= i-digits (digits-of (* i mult)))
		(leave))
	      (finally (return-from euler-52 i))))
  nil)
