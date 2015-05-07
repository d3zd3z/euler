#lang racket

;;; Problem 43
;;;
;;; 09 May 2003
;;;
;;; The number, 1406357289, is a 0 to 9 pandigital number because it is made
;;; up of each of the digits 0 to 9 in some order, but it also has a rather
;;; interesting sub-string divisibility property.
;;;
;;; Let d[1] be the 1^st digit, d[2] be the 2^nd digit, and so on. In this
;;; way, we note the following:
;;;
;;;   • d[2]d[3]d[4]=406 is divisible by 2
;;;   • d[3]d[4]d[5]=063 is divisible by 3
;;;   • d[4]d[5]d[6]=635 is divisible by 5
;;;   • d[5]d[6]d[7]=357 is divisible by 7
;;;   • d[6]d[7]d[8]=572 is divisible by 11
;;;   • d[7]d[8]d[9]=728 is divisible by 13
;;;   • d[8]d[9]d[10]=289 is divisible by 17
;;;
;;; Find the sum of all 0 to 9 pandigital numbers with this property.

(require "euler.rkt")

(define (vector->number digits)
  (for/fold ([result 0])
      ([digit (in-vector digits)])
    (+ (* result 10) digit)))

(define (valid-number? digits)
  (define (get-digits from)
    (for/fold ([result 0])
        ([i (in-range from (+ from 3))])
      (+ (* result 10) (vector-ref digits (sub1 i)))))
  (define (divisible? number div)
    (zero? (remainder number div)))
  (define (part from div)
    (divisible? (get-digits from) div))
  (for/and ([from (in-range 2 9)]
            [div (in-list '(2 3 5 7 11 13 17))])
    (part from div)))

;;; The number can't start with zero.  The easiest way to get this is
;;; to just start with the first permutation that doesn't start with
;;; zero.

(define (euler-43)
  (let loop ([sum 0]
             [digits (vector-copy '#(1 0 2 3 4 5 6 7 8 9))])
    (if digits
        (loop (if (valid-number? digits)
                  (+ sum (vector->number digits))
                  sum)
              (next-permutation digits <))
        sum)))

(module* main #f
  (euler-43))
