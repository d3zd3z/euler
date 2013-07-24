#! /usr/bin/guile -s
!#

;;; Problem 3
;;;
;;; 02 November 2001
;;;
;;; The prime factors of 13195 are 5, 7, 13 and 29.
;;;
;;; What is the largest prime factor of the number 600851475143 ?
;;;
;;; 6857

(define start-number 600851475143)

(define (euler-3)
  (let loop ((number start-number)
             (factor 2))
    (cond ((= number 1)
           factor)
          ((zero? (remainder number factor))
           (loop (quotient number factor) factor))
          (else
            (loop number (if (= factor 2) 3 (+ factor 2)))))))

(define (main)
  (display (euler-3))
  (newline))
(main)
