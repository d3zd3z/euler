#! /usr/local/bin/guile -s
!#

;;; Problem 21
;;;
;;; 05 July 2002
;;;
;;;
;;; Let d(n) be defined as the sum of proper divisors of n (numbers less than
;;; n which divide evenly into n).
;;; If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair
;;; and each of a and b are called amicable numbers.
;;;
;;; For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22,
;;; 44, 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1,
;;; 2, 4, 71 and 142; so d(284) = 220.
;;;
;;; Evaluate the sum of all the amicable numbers under 10000.
;;;
;;; 31626

(add-to-load-path (dirname (current-filename)))
(use-modules (sieve)
	     (srfi srfi-1))

(define limit 10000)

(define (amicable? sieve a)
  (and (< a limit)
       (let* ((b (proper-divisor-sum sieve a))
	      (c (proper-divisor-sum sieve b)))
	 (and (< b limit)
	      (not (= a b))
	      (= a c)))))

(define (euler-21)
  (define sieve (make-sieve))
  (fold (lambda (a b)
	  (if (amicable? sieve a)
	    (+ a b)
	    b))
	0
	(iota (- limit 2) 2)))

(define (main)
  (display (euler-21))
  (newline))
(main)
