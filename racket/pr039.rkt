#lang racket

;;; Problem 39
;;;
;;; 14 March 2003
;;;
;;; If p is the perimeter of a right angle triangle with integral length
;;; sides, {a,b,c}, there are exactly three solutions for p = 120.
;;;
;;; {20,48,52}, {24,45,51}, {30,40,50}
;;;
;;; For which value of p ≤ 1000, is the number of solutions maximised?

(require "triangles.rkt")

(define (euler-39)
  (define buckets (make-hasheqv))
  (generate-triples 1000
                    (lambda (triple p)
                      (hash-set! buckets p
                                 (add1 (hash-ref buckets p 0)))))
  (define-values (p answer)
    (for/fold ([largest 0]
               [largest-value 0])
        ([(p count) (in-hash buckets)])
      (if (> count largest)
          (values count p)
          (values largest largest-value))))
  answer)

(module* main #f
  (euler-39))
