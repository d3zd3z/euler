#!/usr/bin/env gsi

;;; Problem 2
;;;
;;; 19 October 2001
;;;
;;; Each new term in the Fibonacci sequence is generated by adding the
;;; previous two terms. By starting with 1 and 2, the first 10 terms will be:
;;;
;;; 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...
;;;
;;; By considering the terms in the Fibonacci sequence whose values do not
;;; exceed four million, find the sum of the even-valued terms.
;;;
;;; 4613732

(define (euler-2)
  (let loop ((a 1)
             (b 1)
             (sum 0))
    (cond ((>= b 4000000) sum)
          (else (loop b (+ a b)
                      (if (even? b) (+ sum b) sum))))))

(define (main . argv)
  (display (euler-2))
  (newline))
