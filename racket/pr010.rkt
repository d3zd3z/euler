#lang racket

;;; Problem 10
;;;
;;; 08 February 2002
;;;
;;; The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
;;;
;;; Find the sum of all the primes below two million.

(require (planet soegaard/math:1:5/math))
(require "sieve.rkt")

(define (euler-10)
  (define sieve (make-sieve))
  (define (next) (sieve-next sieve))
  (let loop ([sum 0]
             [p (next)])
    (if (< p 2000000)
        (loop (+ sum p) (next))
        sum)))

(define (euler-10b)
  (let loop ([sum 0]
             [p 2])
    (if (< p 2000000)
        (loop (+ sum p) (next-prime p))
        sum)))
