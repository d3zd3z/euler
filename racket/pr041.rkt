#lang racket

;;; Problem 41
;;;
;;; 11 April 2003
;;;
;;; We shall say that an n-digit number is pandigital if it makes use of all
;;; the digits 1 to n exactly once. For example, 2143 is a 4-digit pandigital
;;; and is also prime.
;;;
;;; What is the largest n-digit pandigital prime that exists?

;;; Since 1-9 sum to a multiple of 3, as well as 1-8, we know the
;;; result must be a 7 digit number (or possibly less).

(require (planet soegaard/math:1:5/math))
(require "euler.rkt")

(define (euler-41)
  (let loop ([largest 0]
             [item (string-copy "1234567")])
    (if item
        (let ([num (string->number item)])
          (loop (if (prime? num)
                    (max largest num)
                    largest)
                (string-next-permutation item)))
        largest)))
