#lang racket

;;; Problem 23
;;;
;;; 02 August 2002
;;;
;;; A perfect number is a number for which the sum of its proper divisors is
;;; exactly equal to the number. For example, the sum of the proper divisors
;;; of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect
;;; number.
;;;
;;; A number n is called deficient if the sum of its proper divisors is less
;;; than n and it is called abundant if this sum exceeds n.
;;;
;;; As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the
;;; smallest number that can be written as the sum of two abundant numbers is
;;; 24. By mathematical analysis, it can be shown that all integers greater
;;; than 28123 can be written as the sum of two abundant numbers. However,
;;; this upper limit cannot be reduced any further by analysis even though it
;;; is known that the greatest number that cannot be expressed as the sum of
;;; two abundant numbers is less than this limit.
;;;
;;; Find the sum of all the positive integers which cannot be written as the
;;; sum of two abundant numbers.

(require "euler.rkt")
(require racket/set)

(define (abundant? n)
  (> (sum-of-divisors n) n))

(define (generate-abundants limit)
  (for/list ([i (in-range 1 (add1 limit))]
             #:when (abundant? i))
    i))

(define (euler-23)
  (define limit 28123)
  (define (sub n)
    (set! tagged (set-remove tagged n)))
  (define abundants (generate-abundants limit))
  (define tagged (list->seteqv (for/list ([i (in-range 1 (add1 limit))]) i)))
  (for* ([a (in-list abundants)]
         [b (in-list abundants)])
    (define ab (+ a b))
    (when (<= ab limit)
      (sub ab)))
  (for/sum ([elt (in-set tagged)])
    elt))

;;; Try this with a vector instead of a set.
(define (euler-23b)
  (define limit 28123)
  (define nlimit (add1 limit))
  (define tagged (make-vector nlimit #t))
  (define (sub n)
    (when (< n nlimit)
      (vector-set! tagged n #f)))
  (define abundants (generate-abundants limit))
  (for* ([a (in-list abundants)]
         [b (in-list abundants)])
    (sub (+ a b)))
  (for/sum ([i (in-range 1 nlimit)])
    (if (vector-ref tagged i) i 0)))

(module* main #f
  (time (euler-23))
  (time (euler-23b)))
