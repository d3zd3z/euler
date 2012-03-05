;; #lang racket

;;; Some testing.

#|
(define (foo a)
  (define b (+ a 1))
  (newline)
  (define c (+ a 2))
  (lambda ()
    (set! b (+ b 1))
    (+ b c)))
|#
(define (foo a)
  (lambda ()
    (set! a (+ a 1))
    a))

(define x (foo 10))
; (display (x)) (newline)
(display (x)) (newline)
