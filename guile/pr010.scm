#! /usr/local/bin/guile -s
!#

;;; Problem 10
;;;
;;; 08 February 2002
;;;
;;;
;;; The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
;;;
;;; Find the sum of all the primes below two million.
;;;
;;; 142913828922

(add-to-load-path (dirname (current-filename)))
(use-modules (sieve))

(define (euler-10)
  (define s (make-sieve))
  (let loop ((p 2)
	     (sum 0))
    (if (>= p 2000000)
      sum
      (loop (next-prime s p) (+ sum p)))))

(define (main)
  (display (euler-10))
  (newline))
(main)
