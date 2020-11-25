;;; Problem 16
;;;
;;; 03 May 2002
;;;
;;; 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
;;;
;;; What is the sum of the digits of the number 2^1000?
;;;
;;; 1366

(defpackage #:pr016
  (:use #:cl #:iterate #:euler)
  (:export #:euler-16))
(in-package #:pr016)

(defun euler-16 ()
  (sum-digits (expt 2 1000)))
(setf (get 'euler-16 :euler-answer) 1366)
