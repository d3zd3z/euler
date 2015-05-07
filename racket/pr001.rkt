#lang racket

;;; If we list all the natural numbers below 10 that are multiples of
;;; 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
;;;
;;; Find the sum of all the multiples of 3 or 5 below 1000.

(require math/number-theory)

;;; Direct solution, with my own loop.
(define (sol1 limit)
  (let loop ([num 3]
	     [total 0])
    (if (< num limit)
      (loop (add1 num)
	    (if (or (divides? 3 num) (divides? 5 num))
	      (+ total num)
	      total))
      total)))

;;; More efficient solution, using generators and seqences.
(define (sol2 limit)
  (define (phase range)
    (for/fold ([sum 0])
	      ([i range])
	      (+ i sum)))
  (+ (phase (in-range 3 limit 3))
     (phase (in-range 5 limit 15))
     (phase (in-range 10 limit 15))))

(define (show limit)
  (let ([a (sol1 limit)]
	[b (sol2 limit)])
    (unless (= a b)
      (error "Result mismatch"))
    (printf "~a~n" b)))

(define (euler-1)
  (show 1000))

(module* main #f
  (euler-1))
