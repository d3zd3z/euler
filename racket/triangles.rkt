#lang racket

;;; Machinations on triangles.

(provide generate-triples)
(provide (struct-out triple))

(struct box (p1 p2 q1 q2)
        #:transparent
        #:constructor-name make-box)

(define start-box (make-box 1 1 2 3))

;;; Each box has three children.
(define (children box)
  (define x (box-p2 box))
  (define y (box-q2 box))
  (list (make-box (- y x) x y (- (* y 2) x))
        (make-box x y (+ x y) (+ (* x 2) y))
        (make-box y x (+ y x) (+ (* y 2) x))))

(struct triple (a b c)
        #:transparent
        #:constructor-name make-triple)

(define (circumference triangle)
  (+ (triple-a triangle)
     (triple-b triangle)
     (triple-c triangle)))

;;; Return the three sides of the pythagorean triple describe by the
;;; given box.
(define (box-triangle b)
  (define p1 (box-p1 b))
  (define p2 (box-p2 b))
  (define q1 (box-q1 b))
  (define q2 (box-q2 b))
  (make-triple (* 2 q1 p1)
               (* q2 p2)
               (+ (* p1 q2) (* p2 q1))))
  
;;; Multiply each of the sides of this triangle by k.
(define (multiply-triple tri k)
  (make-triple (* k (triple-a tri))
               (* k (triple-b tri))
               (* k (triple-c tri))))

;;; Generate all of the primitive Pythagorean triples with a
;;; circumference <= limit.  Calls (act triple circumference) for each
;;; possible triple.
(define (fibonacci-generate-triples limit act)
  (let loop ([work (list start-box)])
    (when (cons? work)
      (define box (first work))
      (define next-work (rest work))
      (define triple (box-triangle box))
      (define size (circumference triple))
      (define more-work (if (<= size limit)
                            (let ([more-work (for/fold ([work next-work])
                                                 ([child (in-list (children box))])
                                               (cons child work))])
                              (act triple size)
                              more-work)
                            next-work))
      (loop more-work))))

(define (generate-triples limit act)
  (define (sub-generate triple size)
    (let loop ([k 1])
      (define k-triple (multiply-triple triple k))
      (define k-size (circumference k-triple))
      (when (<= k-size limit)
        (act k-triple k-size)
        (loop (add1 k)))))
  (fibonacci-generate-triples limit sub-generate))
