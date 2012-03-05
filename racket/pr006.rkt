#lang racket

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Problem 6
;; 
;; 14 December 2001
;; 
;; The sum of the squares of the first ten natural numbers is,
;; 
;; 1^2 + 2^2 + ... + 10^2 = 385
;; 
;; The square of the sum of the first ten natural numbers is,
;; 
;; (1 + 2 + ... + 10)^2 = 55^2 = 3025
;; 
;; Hence the difference between the sum of the squares of the first ten
;; natural numbers and the square of the sum is 3025 − 385 = 2640.
;; 
;; Find the difference between the sum of the squares of the first one
;; hundred natural numbers and the square of the sum.
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (sum-of-squares limit)
  (for/fold ([sum 0])
      ([i (in-range 1 (add1 limit))])
    (+ sum (sqr i))))

(define (square-of-sum limit)
  (sqr (/ (* limit (add1 limit)) 2)))

(define (euler-6)
  (- (square-of-sum 100)
     (sum-of-squares 100)))
