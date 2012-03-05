#lang racket

;;; Problem 15
;;;
;;; 19 April 2002
;;;
;;; Starting in the top left corner of a 2×2 grid, there are 6 routes (without
;;; backtracking) to the bottom right corner.
;;;
;;; [p_015]
;;;
;;; How many routes are there through a 20×20 grid?

(define (base n)
  (make-vector (add1 n) 1))

(define (bump seq)
  (for ([i (in-range (sub1 (vector-length seq)))])
    (vector-set! seq (add1 i)
                 (+ (vector-ref seq i)
                    (vector-ref seq (add1 i)))))
  seq)

(define (routes n)
  (for/fold ([seq (base n)])
      ([i (in-range n)])
    (bump seq)))

(define (euler-15)
  (define r (routes 20))
  (vector-ref r (sub1 (vector-length r))))
