#lang racket

;;; Problem 35
;;;
;;; 17 January 2003
;;;
;;; The number, 197, is called a circular prime because all rotations of the
;;; digits: 197, 971, and 719, are themselves prime.
;;;
;;; There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37,
;;; 71, 73, 79, and 97.
;;;
;;; How many circular primes are there below one million?

(require (planet soegaard/math:1:5/math))

(define (number-of-digits number)
  (add1 (order-of-magnitude number)))

(define (number-rotations number)
  (define len (number-of-digits number))
  (let loop ([right (sub1 len)]
             [left 0]
             [accum 0]
             [n number]
             [result '()])
    (if (negative? right)
        result
        (let-values ([(n-quotient n-remainder) (quotient/remainder n 10)])
          (define new-accum (+ accum (* (expt 10 left) n-remainder)))
          (loop (sub1 right)
                (add1 left)
                new-accum
                n-quotient
                (cons (+ n-quotient (* (expt 10 right) new-accum)) result))))))

(define (euler-35)
  (let loop ([prime 2]
             [count 0])
    (if (> prime 1000000)
        count
        (loop (next-prime prime)
              (if (andmap prime? (number-rotations prime))
                  (add1 count) count)))))
