;;; Problem 48
;;;
;;; 18 July 2003
;;;
;;; The series, 1^1 + 2^2 + 3^3 + ... + 10^10 = 10405071317.
;;;
;;; Find the last ten digits of the series, 1^1 + 2^2 + 3^3 + ... + 1000^1000.
;;;
;;; 9110846700

(defpackage #:pr048
  (:use #:cl #:iterate)
  (:export #:euler-48))
(in-package #:pr048)

;;; This kind of might be considered cheating.

(defun euler-48 ()
  (iter (for i from 1 to 1000)
	(sum (expt i i) into sum)
	(finally (return (mod sum (expt 10 10))))))
