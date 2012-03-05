#lang racket

;;; Problem 31
;;;
;;; 22 November 2002
;;;
;;; In England the currency is made up of pound, £, and pence, p, and there
;;; are eight coins in general circulation:
;;;
;;;     1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).
;;;
;;; It is possible to make £2 in the following way:
;;;
;;;     1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p
;;;
;;; How many different ways can £2 be made using any number of coins?

(define coins '(200 100 50 20 10 5 2 1))

(define (rways remaining coins)
  (if (null? coins)
      (if (zero? remaining) 1 0)
      (let ([coin (first coins)]
            [other-coins (rest coins)])
        (for/sum ([r (in-range remaining -1 (- coin))])
          (rways r other-coins)))))

;;; There doesn't seem to be much reason to memoize, the problem space
;;; just isn't big enough.

(define (euler-31)
  (rways 200 coins))
