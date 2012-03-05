#lang racket

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Problem 3
;; 
;; 02 November 2001
;; 
;; The prime factors of 13195 are 5, 7, 13 and 29.
;; 
;; What is the largest prime factor of the number 600851475143 ?
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require (planet soegaard/math:1:5/math))

;; Not particularly hard with these libraries.
(define (euler-3)
  (first (last (factorize 600851475143))))
