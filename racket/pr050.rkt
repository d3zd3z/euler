#lang racket

;;; Problem 50
;;;
;;; 15 August 2003
;;;
;;; The prime 41, can be written as the sum of six consecutive primes:
;;;
;;; 41 = 2 + 3 + 5 + 7 + 11 + 13
;;;
;;; This is the longest sum of consecutive primes that adds to a prime below
;;; one-hundred.
;;;
;;; The longest sum of consecutive primes below one-thousand that adds to a
;;; prime, contains 21 terms, and is equal to 953.
;;;
;;; Which prime, below one-million, can be written as the sum of the most
;;; consecutive primes?
;;;
;;; 997651

(require "ssieve.rkt")

(define (primes-upto sieve limit)
  (define element 2)
  (define (next)
    (if (< element limit)
      (let ([this element])
	(set! element (next-prime sieve element))
	this)
      #f))
  (for/list ([i (in-producer next #f)]) i))

(define (euler-50)
  (define limit 1000000)
  (define sieve (make-sieve))
  (define primes (primes-upto sieve limit))

  (define largest 0)
  (define largest-len 0)
  (define (check sum len)
    (when (> len largest-len)
      (set! largest sum)
      (set! largest-len len)))

  (let outer ([elts primes])
    (when (cons? elts)
      (define left (car elts))
      (define more (rest elts))
      (let inner ([sum left]
		  [count 1]
		  [items more])
	(when (cons? items)
	  (define elt (car items))
	  (define new-sum (+ sum elt))
	  (define new-count (add1 count))
	  (when (< new-sum limit)
	    (when (prime? sieve new-sum)
	      (check new-sum new-count))
	    (inner new-sum new-count (cdr items)))))
      (outer more)))
  largest)

(module* main #f
  (euler-50))
