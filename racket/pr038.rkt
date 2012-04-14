#lang racket

;;; Problem 38
;;;
;;; 28 February 2003
;;;
;;; Take the number 192 and multiply it by each of 1, 2, and 3:
;;;
;;;     192 × 1 = 192
;;;     192 × 2 = 384
;;;     192 × 3 = 576
;;;
;;; By concatenating each product we get the 1 to 9 pandigital, 192384576. We
;;; will call 192384576 the concatenated product of 192 and (1,2,3)
;;;
;;; The same can be achieved by starting with 9 and multiplying by 1, 2, 3, 4,
;;; and 5, giving the pandigital, 918273645, which is the concatenated product
;;; of 9 and (1,2,3,4,5).
;;;
;;; What is the largest 1 to 9 pandigital 9-digit number that can be formed as
;;; the concatenated product of an integer with (1,2, ... , n) where n > 1?

;;; Is this number a full 9-element pandigital number.
(define (pandigital? number)
  (let loop ([bits 0]
             [number number])
    (if (zero? number)
        (= bits 1022)                   ; 1-9 without the zero.
        (let-values ([(n m) (quotient/remainder number 10)])
          (define bit-value (arithmetic-shift 1 m))
          (if (zero? (bitwise-and bits bit-value))
              (loop (bitwise-ior bits bit-value)
                    n)
              #f)))))

;;; Given a numeric base, return a resulting number by successively
;;; multiplying by the integers starting with 1.
(define (large-sum base)
  (let loop ([digits 0]
             [result 0]
             [i 1])
    (if (>= digits 9)
        result
        (let* ([piece (* base i)]
               [piece-digits (add1 (order-of-magnitude piece))])
          (loop (+ digits piece-digits)
                (+ (* result (expt 10 piece-digits))
                   piece)
                (add1 i))))))

(define (euler-38)
  (for*/fold ([largest 0])
      ([a (in-range 1 10000)]
       [sum (in-value (large-sum a))]
       #:when (pandigital? sum))
    (max largest sum)))
