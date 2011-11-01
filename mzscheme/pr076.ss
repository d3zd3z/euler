#lang scheme
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; It is possible to write five as a sum in exactly six different ways:
;;; 
;;; 4 + 1
;;; 3 + 2
;;; 3 + 1 + 1
;;; 2 + 2 + 1
;;; 2 + 1 + 1 + 1
;;; 1 + 1 + 1 + 1 + 1
;;; 
;;; How many different ways can one hundred be written as a sum of at
;;; least two positive integers?
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Ok, just brute force it.

;;; The first case is special, since it is the only one that requires
;;; an extra sum.
(define (sums n)
  (for/fold ([sum 0])
	    ([i (in-range 1 n)])
	    (+ sum (sum1 (- n i) i))))

;;; Compute the number of ways of adding up the numbers less than 'k'
;;; to get 'n'.
(define (sum1 n k)
  (match k
    [1 0]
    [2 1]
    [3

(define (bogus)
  (define answers #(0 0 1))
  (define (show)
    (define n (vector-length answers))
    (define tmp (for/fold ([sum 1])
		  ([i (in-range 2 n)])
		  (+ sum (vector-ref answers i))))
    (set! answers (vector-append answers (vector tmp)))
    (display answers)
    (printf "~s -> ~s~%" n tmp))
  (let loop ()
    (when (< (vector-length answers) 6)
      (show)
      (loop))))
