#! /usr/local/bin/guile -s
!#

;;; Problem 16
;;;
;;; 03 May 2002
;;;
;;;
;;; 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
;;;
;;; What is the sum of the digits of the number 2^1000?
;;;
;;; 1366

(define (sum-digits n)
  (let loop ((n n)
	     (total 0))
    (if (zero? n) total
      (loop (quotient n 10)
	    (+ total (remainder n 10))))))

(define (euler-16)
  (sum-digits (expt 2 1000)))

(define (main)
  (display (euler-16))
  (newline))
(main)
