#lang racket

;;; Problem 46
;;;
;;; 20 June 2003
;;;
;;; It was proposed by Christian Goldbach that every odd composite number can
;;; be written as the sum of a prime and twice a square.
;;;
;;; 9 = 7 + 2x1^2
;;; 15 = 7 + 2x2^2
;;; 21 = 3 + 2x3^2
;;; 25 = 7 + 2x3^2
;;; 27 = 19 + 2x2^2
;;; 33 = 31 + 2x1^2
;;;
;;; It turns out that the conjecture was false.
;;;
;;; What is the smallest odd composite that cannot be written as the sum of a
;;; prime and twice a square?
;;;
;;; 5777

(require "ssieve.rkt")

;;; Find the goldbach composition of the given odd number.
;;; Slightly modified to only return the first answer.
(define (gold sieve n)
  (let/ec out
    (define answer '())
    (do ([p 2 (next-prime sieve p)])
      ((>= p n))
      (do ([s 1 (add1 s)])
	((= s p))
	(when (= n (+ p (* 2 s s)))
	  (out (list (cons p s)))
	  (set! answer (cons (cons p s) answer)))))
    answer))

(define (euler-46)
  (define sieve (make-sieve))
  (let loop ([n 9])
    (if (and (not (prime? sieve n))
	     (null? (gold sieve n)))
      n
      (loop (+ n 2)))))
