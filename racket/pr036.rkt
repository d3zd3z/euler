#lang racket

;;; Problem 36
;;;
;;; 31 January 2003
;;;
;;; The decimal number, 585 = 1001001001[2] (binary), is palindromic in both
;;; bases.
;;;
;;; Find the sum of all numbers, less than one million, which are palindromic
;;; in base 10 and base 2.
;;;
;;; (Please note that the palindromic number, in either base, may not include
;;; leading zeros.)

(require "euler.rkt")

(define (palindrome? number [base 10])
  (= number (reverse-number number base)))

(define (euler-36)
  (for/sum ([i (in-range 1 1000000)])
    (if (and (palindrome? i 10)
             (palindrome? i 2))
        i
        0)))

(module* main #f
  (euler-36))
