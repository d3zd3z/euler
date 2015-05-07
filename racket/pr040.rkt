#lang racket

;;; Problem 40
;;;
;;; 28 March 2003
;;;
;;; An irrational decimal fraction is created by concatenating the positive
;;; integers:
;;;
;;; 0.123456789101112131415161718192021...
;;;
;;; It can be seen that the 12^th digit of the fractional part is 1.
;;;
;;; If d[n] represents the n^th digit of the fractional part, find the value
;;; of the following expression.
;;;
;;; d[1] × d[10] × d[100] × d[1000] × d[10000] × d[100000] × d[1000000]

;;; This is naive, and memory hungry, but it works.
(define (digits limit)
  (call-with-output-bytes
   (lambda (str)
     (for ([i (in-range 1 (add1 limit))])
       (display i str)))))

(define (euler-40)
  (define all (digits 200000))
  (let loop ([e 1]
             [result 1])
    (if (> e 1000000)
        result
        (let ([ch (bytes-ref all (sub1 e))])
          (loop (* e 10)
                (* result
                   (- ch
                      (char->integer #\0))))))))

(module* main #f
  (euler-40))
