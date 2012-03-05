#lang racket

;;; Problem 20
;;;
;;; 21 June 2002
;;;
;;; n! means n × (n − 1) × ... × 3 × 2 × 1
;;;
;;; For example, 10! = 10 × 9 × ... × 3 × 2 × 1 = 3628800,
;;; and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 =
;;; 27.
;;;
;;; Find the sum of the digits in the number 100!

(require "euler.rkt")

(define (factorial n)
  (for/product ([i (in-range 1 (add1 n))])
    i))

(define (euler-20)
  (digit-sum (factorial 100)))
