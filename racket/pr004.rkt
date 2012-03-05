#lang racket

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Problem 4
;; 
;; 16 November 2001
;; 
;; A palindromic number reads the same both ways. The largest
;; palindrome made from the product of two 2-digit numbers is 9009 = 91
;; × 99.
;; 
;; Find the largest palindrome made from the product of two 3-digit
;; numbers.
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (reverse-digits number)
  (let loop ([number number] [result 0])
    (if (positive? number)
	(let-values ([(n m) (quotient/remainder number 10)])
	  (loop n (+ (* result 10) m)))
	result)))

(define (palindrome? number)
  (= number (reverse-digits number)))

;; Racket's sequence operations.
(define (euler-4)
  (for*/fold ([biggest 0])
	     ([a (in-range 100 999)]
	      [b (in-range a 999)]
	      #:when (palindrome? (* a b)))
	     (max biggest (* a b))))

;; Traditional scheme loops.
(define (euler-4b)
  (let loop ([a 100] [b 100] [answer 0])
    (cond [(= a 1000) answer]
	  [(= b 1000) (loop (+ a 1) (+ a 1) answer)]
	  [else (let* ([product (* a b)]
		       [next (if (palindrome? product) (max answer product) answer)])
		  (loop a (+ b 1) next))])))
