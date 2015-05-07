#lang racket

;;; Problem 30
;;;
;;; 08 November 2002
;;;
;;; Surprisingly there are only three numbers that can be written as the sum
;;; of fourth powers of their digits:
;;;
;;;     1634 = 1^4 + 6^4 + 3^4 + 4^4
;;;     8208 = 8^4 + 2^4 + 0^4 + 8^4
;;;     9474 = 9^4 + 4^4 + 7^4 + 4^4
;;;
;;; As 1 = 1^4 is not a sum it is not included.
;;;
;;; The sum of these numbers is 1634 + 8208 + 9474 = 19316.
;;;
;;; Find the sum of all the numbers that can be written as the sum of fifth
;;; powers of their digits.

(require "euler.rkt")

;;; Calculate the largest number this power could possible be.
(define (largest-number power)
  (let loop ([num 9])
    (define sum (digit-power-sum num power))
    (if (> num sum) sum
        (loop (+ (* num 10) 9)))))

(define (count-summable power)
  (for/sum ([i (in-range 2 (add1 (largest-number power)))])
    (if (= i (digit-power-sum i power))
        i
        0)))

(define (euler-30)
  (count-summable 5))

(module* main #f
  (euler-30))
