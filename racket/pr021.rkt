#lang racket

;;; Problem 21
;;;
;;; 05 July 2002
;;;
;;; Let d(n) be defined as the sum of proper divisors of n (numbers less than
;;; n which divide evenly into n).
;;; If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair
;;; and each of a and b are called amicable numbers.
;;;
;;; For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22,
;;; 44, 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1,
;;; 2, 4, 71 and 142; so d(284) = 220.
;;;
;;; Evaluate the sum of all the amicable numbers under 10000.

(require (planet soegaard/math:1:5/math))
(require "euler.rkt")

;;; The positive-divisors function from soegaard/math isn't very
;;; efficient.  Speed could be improved by building the divisors out
;;; of the results of factorize.

(define (amicable? n)
  (define other (sum-of-divisors n))
  (and (not (= other n))
       (< other 10000)
       (positive? other)
       (= n (sum-of-divisors other))))

(define (euler-21)
  (for/sum ([i (in-range 1 10000)])
    (if (amicable? i) i 0)))
