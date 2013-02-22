;;; Utilities shared among euler problems.

(defpackage #:euler
  (:use #:cl #:iterate)
  (:export #:sum-digits #:sum-digits-power #:factorial
	   #:reverse-number))
(in-package #:euler)

(defun sum-digits (number)
  (iter (while (plusp number))
	(for (values num den) = (truncate number 10))
	(sum den)
	(setf number num)))

(defun sum-digits-power (number power)
  (iter (while (plusp number))
	(for (values num den) = (truncate number 10))
	(sum (expt den power))
	(setf number num)))

(defun factorial (n)
  (iter (for x from 1 to n)
	(multiply x)))

(defun reverse-number (number &optional (base 10))
  (iter (with result = 0)
	(with n = number)
	(while (plusp n))
	(for (values num den) = (truncate n base))
	(setf n num)
	(setf result (+ (* result base) den))
	(finally (return result))))
