#lang racket

;;; Problem 16
;;;
;;; 03 May 2002
;;;
;;; 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
;;;
;;; What is the sum of the digits of the number 2^1000?

(require "euler.rkt")

(define (euler-16)
  (digit-sum (expt 2 1000)))

(module* main #f
  (euler-16))
