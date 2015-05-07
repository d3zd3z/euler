#lang racket

;;; Problem 34
;;;
;;; 03 January 2003
;;;
;;; 145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.
;;;
;;; Find the sum of all numbers which are equal to the sum of the factorial of
;;; their digits.
;;;
;;; Note: as 1! = 1 and 2! = 2 are not sums they are not included.

(define factorials
  (let ([result (make-vector 10 1)])
    (let loop ([i 1]
               [fact 1])
      (when (< i 10)
        (vector-set! result i fact)
        (loop (add1 i) (* fact (add1 i)))))
    result))

(define (euler-34)
  (define total -3)
  (define last-fact (vector-ref factorials 9))
  (let chain ([number 0]
              [fact-sum 0])
    (when (and (positive? number) (= number fact-sum))
      (set! total (+ total number)))
    (when (<= (* number 10) (+ fact-sum last-fact))
      (for ([i (in-range (if (positive? number) 0 1) 10)])
        (chain (+ (* number 10) i)
               (+ fact-sum (vector-ref factorials i))))))
  total)

(module* main #f
  (euler-34))
