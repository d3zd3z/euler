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
;;; 104743
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require (only-in
	   math/number-theory
	   nth-prime))
(require "ssieve.rkt")

;; Ok, this is cheating a bit.
(define (euler-7a)
  (nth-prime 10000))

#|
(define (euler-7b)
  (define sieve (make-sieve))
  (for ([i (in-range 10000)])
       (sieve-next sieve))
  (sieve-next sieve))
|#
(define (euler-7c)
  (define sieve (make-sieve))
  (do ([i 0 (add1 i)]
       [p 2 (next-prime sieve p)])
    ((= i 10000) p)))

;; For testing.
(module* main #f
  (display (euler-7c))
  (newline))
