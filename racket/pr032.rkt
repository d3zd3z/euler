#lang racket

;;; Problem 32
;;;
;;; 06 December 2002
;;;
;;; We shall say that an n-digit number is pandigital if it makes use of all
;;; the digits 1 to n exactly once; for example, the 5-digit number, 15234, is
;;; 1 through 5 pandigital.
;;;
;;; The product 7254 is unusual, as the identity, 39 × 186 = 7254, containing
;;; multiplicand, multiplier, and product is 1 through 9 pandigital.
;;;
;;; Find the sum of all products whose multiplicand/multiplier/product
;;; identity can be written as a 1 through 9 pandigital.
;;;
;;; HINT: Some products can be obtained in more than one way so be sure to
;;; only include it once in your sum.

(require "euler.rkt")
(require racket/set)

;;; Returns all groupings (as a list) that can be built out of this
;;; groups of digits.
(define (make-groupings digits)
  (define len (string-length digits))
  (for*/fold ([result '()])
      ([i (in-range 1 (- len 2))]
       [j (in-range (add1 i) (sub1 len))])
    (define (piece a b)
      (string->number (substring digits a b)))
    (define a (piece 0 i))
    (define b (piece i j))
    (define c (piece j len))
    (if (= (* a b) c)
        (cons c result)
        result)))

(define (euler-32)
  (define products (let loop ([result '()]
                              [digits (string-copy "123456789")])
                     (if digits
                         (loop (cons (make-groupings digits) result)
                               (string-next-permutation digits))
                         result)))
  (foldl + 0 (remove-duplicates (flatten products))))

(module* main #f
  (euler-32))
