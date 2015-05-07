#lang racket

;;; Problem 48
;;;
;;; 18 July 2003
;;;
;;; The series, 1^1 + 2^2 + 3^3 + ... + 10^10 = 10405071317.
;;;
;;; Find the last ten digits of the series, 1^1 + 2^2 + 3^3 + ... + 1000^1000.
;;;
;;; 9110846700

(define (euler-48)
  (remainder (for/sum ([i (in-range 1 1001)])
	       (expt i i))
	     10000000000))

(module* main #f
  (display (euler-48))
  (newline))
