#lang racket

;;; Problem 37
;;;
;;; 14 February 2003
;;;
;;; The number 3797 has an interesting property. Being prime itself, it is
;;; possible to continuously remove digits from left to right, and remain
;;; prime at each stage: 3797, 797, 97, and 7. Similarly we can work from
;;; right to left: 3797, 379, 37, and 3.
;;;
;;; Find the sum of the only eleven primes that are both truncatable from left
;;; to right and right to left.
;;;
;;; NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.

(require math/number-theory)
(require "euler.rkt")

;;; Given a list of numbers, return an augmented list of the numbers
;;; that are primes when a single digit is appended to the right.
(define (add-primes numbers)
  (for*/fold ([result '()])
      ([n (in-list numbers)]
       [d (in-list '(1 3 7 9))])
    (define new (+ (* 10 n) d))
    (if (prime? new)
        (cons new result)
        result)))

;;; Generate the list of all right-truncatable primes.
(define (right-truncatable-primes)
  (let loop ([set '(2 3 5 7)]
             [result '()])
    (if (null? set)
        result
        (loop (add-primes set)
              (append set result)))))

;;; Is this number also left-truncatable?
(define (left-truncatable? number)
  (let loop ([number number])
    (cond [(zero? number)
           #t]
          [(and (> number 1) (prime? number))
           (loop (reverse-number (quotient (reverse-number number) 10)))]
          [else #f])))

(define (euler-37)
  (for/sum ([p (in-list (right-truncatable-primes))]
            #:when (and (> p 9) (left-truncatable? p)))
    p))

(module* main #f
  (euler-37))
