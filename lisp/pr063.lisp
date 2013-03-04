;;; Problem 63
;;;
;;; 13 February 2004
;;;
;;; The 5-digit number, 16807=7^5, is also a fifth power. Similarly, the
;;; 9-digit number, 134217728=8^9, is a ninth power.
;;;
;;; How many n-digit positive integers exist which are also an nth power?
;;;
;;; 49

(defpackage #:pr063
  (:use #:cl #:iterate)
  (:export #:euler-63))
(in-package #:pr063)

(defun nth-power-count (pow)
  (let ((low (expt 10 (1- pow)))
	(high (expt 10 pow)))
    (iter (for x from 1)
	  (for x-pow = (expt x pow))
	  (until (>= x-pow high))
	  (counting (>= x-pow low)))))

;;; The Project Euler discussion group has an explanation as to why
;;; this doesn't need to be computed past 21, but all probed values
;;; past 21 resulted in 0 values.

(defun euler-63 ()
  (iter (for pow from 1 to 21)
	(summing (nth-power-count pow))))
