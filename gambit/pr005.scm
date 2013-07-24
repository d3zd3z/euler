;#!/usr/bin/env gsi

;;; Problem 5
;;;
;;; 30 November 2001
;;;
;;; 2520 is the smallest number that can be divided by each of the numbers
;;; from 1 to 10 without any remainder.
;;;
;;; What is the smallest positive number that is evenly divisible by all of
;;; the numbers from 1 to 20?
;;;
;;; 232792560

(import (srfi lists))

(define (euler-5)
  (fold lcm 1 (iota 20 1)))

(define (main . argv)
  (display (euler-5))
  (newline))

;; BH doesn't understand 'main', so just run it.
(main)
