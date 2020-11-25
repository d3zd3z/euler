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

(defpackage #:pr036
  (:use #:cl #:iterate)
  (:export #:euler-36))
(in-package #:pr036)

(defun reverse-number (number base)
  (loop with result = 0
        with n = number
        while (plusp n)
        for (num den) = (multiple-value-list (truncate n base))
        do (setf n num)
        do (setf result (+ (* result base) den))
        finally (return result)))

#|
(defun reverse-number (number base)
  (declare (fixnum number base)
	   (optimize (speed 3) (safety 0)))
  (iter (declare (declare-variables))
	(with result = 0)
	(declare (fixnum result))
	(with (the fixnum n) = number)
	(while (plusp n))
	(for (values num den) = (truncate n base))
	(declare (fixnum num den))
	(setf n num)
	(setf result (+ (the fixnum (* result base)) den))
	(finally (return result))))
|#

(defun palindromep (number base)
  (= number (reverse-number number base)))

(defun euler-36 ()
  (loop for i from 1 to 999999
        when (and (palindromep i 10)
                  (palindromep i 2))
        sum i))
(setf (get 'euler-36 :euler-answer) 872187)
