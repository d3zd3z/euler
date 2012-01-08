;;; Utilities shared among euler problems.

(defpackage #:euler
  (:use #:cl #:iterate)
  (:export #:sum-digits #:factorial))
(in-package #:euler)

(defun sum-digits (number)
  (iter (while (plusp number))
	(for (values num den) = (truncate number 10))
	(sum den)
	(setf number num)))

(defun factorial (n)
  (iter (for x from 1 to n)
	(multiply x)))
