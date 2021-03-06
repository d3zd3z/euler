;;; Problem 3
;;;
;;; 02 November 2001
;;;
;;; The prime factors of 13195 are 5, 7, 13 and 29.
;;;
;;; What is the largest prime factor of the number 600851475143 ?
;;;
;;; 6857

;;; The starting number is larger than 31 bits, so for portability,
;;; use the bignum extensions.

; (import numbers)

(define start-number (string->number "600851475143"))

;; First implementation does not use any prime numbers, and just
;; divides by things.
(define (euler-3)
  (let loop ((number start-number)
	     (factor 2))
    (cond ((= number 1)
	   factor)
	  ((zero? (remainder number factor))
	   (loop (quotient number factor) factor))
	  (else
	    (loop number (if (= factor 2) 3 (+ factor 2)))))))

(display (euler-3))
(newline)
