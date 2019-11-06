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

(import srfi-1)

(define (euler-5)
  (fold lcm 1 (iota 20 1)))

(display (euler-5))
(newline)
