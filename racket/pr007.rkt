#lang racket

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Problem 7
;;; 
;;; 28 December 2001
;;; 
;;; By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we
;;; can see that the 6th prime is 13.
;;; 
;;; What is the 10 001st prime number?
;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require (planet soegaard/math:1:5/math))
(require "sieve.rkt")

;; Ok, this is cheating a bit.
(define (euler-7a)
  (nth-prime 10001))

(define (euler-7b)
  (define sieve (make-sieve))
  (for ([i (in-range 10000)])
       (sieve-next sieve))
  (sieve-next sieve))


;; For testing.
(display (euler-7b))
(newline)

