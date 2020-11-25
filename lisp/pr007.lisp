;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Problem 7
;;
;; 28 December 2001
;;
;; By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we
;; can see that the 6th prime is 13.
;;
;; What is the 10 001st prime number?
;;
;; 104743
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defpackage #:pr007
  (:use #:cl #:euler.sieve)
  (:export #:euler-7))
(in-package #:pr007)

(defun euler-7 ()
  (loop with sieve = (make-sieve)
        for i from 1 to 10001
        for p = (sieve-next sieve)
        finally (return p)))
(setf (get 'euler-7 :euler-answer) 104743)
