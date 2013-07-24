#! /usr/bin/guile -s
!#

;;; Problem 7
;;;
;;; 28 December 2001
;;;
;;;
;;; By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see
;;; that the 6th prime is 13.
;;;
;;; What is the 10 001st prime number?

(add-to-load-path (dirname (current-filename)))

(use-modules (sieve))

(define (euler-7)
  (define s (make-sieve))
  (let loop ((n 2)
	     (count 1))
    (if (= count 10001)
      n
      (loop (next-prime s n) (1+ count)))))

(define (main)
  (display (euler-7))
  (newline))
(main)
