;;; Problem 25
;;;
;;; 30 August 2002
;;;
;;; The Fibonacci sequence is defined by the recurrence relation:
;;;
;;;     F[n] = F[n−1] + F[n−2], where F[1] = 1 and F[2] = 1.
;;;
;;; Hence the first 12 terms will be:
;;;
;;;     F[1] = 1
;;;     F[2] = 1
;;;     F[3] = 2
;;;     F[4] = 3
;;;     F[5] = 5
;;;     F[6] = 8
;;;     F[7] = 13
;;;     F[8] = 21
;;;     F[9] = 34
;;;     F[10] = 55
;;;     F[11] = 89
;;;     F[12] = 144
;;;
;;; The 12th term, F[12], is the first term to contain three digits.
;;;
;;; What is the first term in the Fibonacci sequence to contain 1000 digits?
;;;
;;; 4782

(defpackage #:pr025
  (:use #:cl #:iterate)
  (:export #:euler-25))
(in-package #:pr025)

(defun was-euler-25 ()
  (iter (with a = 1)
	(with b = 1)
	(for index from 1)
	(while (< (log a 10) 999))
	(psetq a b
	       b (+ a b))
	(finally (return index))))

;;; This is a bit clearer, and doesn't have the annoying psetq.
(defun euler-25 ()
  (iter (for (values a b) first (values 1 1) then (values b (+ a b)))
	(for index from 1)
	(while (< (log a 10) 999))
	(finally (return index))))
(setf (get 'euler-25 :euler-answer) 4782)
