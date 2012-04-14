#lang racket

(require (planet soegaard/math:1:5/math))

;;; Utilities shared by multiple problems, but not worth of their own module.

(provide digit-sum)
(provide sum-of-divisors)
(provide digit-power-sum)
(provide next-permutation)
(provide string-next-permutation)
(provide reverse-number)

(define (digit-sum number)
  (let loop ([number number]
             [sum 0])
    (if (zero? number)
        sum
        (let-values ([(n m) (quotient/remainder number 10)])
          (loop n (+ sum m))))))

;;; Return the sum of the digits each raised to power.
(define (digit-power-sum number power)
  (let loop ([number number]
             [sum 0])
    (if (zero? number)
        sum
        (let-values ([(n m) (quotient/remainder number 10)])
          (loop n (+ sum (expt m power)))))))

;;; Reverse a number in the given base.
(define (reverse-number number [base 10])
  (let loop ([number number] [result 0])
    (if (positive? number)
        (let-values ([(n m) (quotient/remainder number base)])
          (loop n (+ (* result base) m)))
        result)))

(define (spread factors)
  (cond [(null? factors) '(1)]
        [else
         (define p (caar factors))
         (define count (cadar factors))
         (define others (spread (cdr factors)))
         (for*/list ([res (in-list others)]
                     [x (in-range (add1 count))])
           (* res (expt p x)))]))

(define (sum-of-divisors n)
  (- (foldl + 0 (spread (factorize n))) n))

;;; Permutations of a sequence.
(define-signature seq^
  (seq-length seq-ref seq-set!))
(define-signature permutation^
  (next-permutation))

(define permutation@
  (unit
    (import seq^)
    (export permutation^)

    (define (swap seq i j)
      (define tmp (seq-ref seq i))
      (seq-set! seq i (seq-ref seq j))
      (seq-set! seq j tmp))

    (define (reverse-subseq seq i j)
      (when (< i j)
        (swap seq i j)
        (reverse-subseq seq (add1 i) (sub1 j))))

    ;; This is a fairly direct translation out of the code from
    ;; Wikipedia.  It's not very schemey.
    (define (next-permutation seq less?)
      (define last (sub1 (seq-length seq)))
      (define k #f)
      (for ([x (in-range last)])
        (when (less? (seq-ref seq x) (seq-ref seq (add1 x)))
          (set! k x)))
      (when k
        (define l #f)
        (for ([x (in-range (add1 k) (add1 last))])
          (when (less? (seq-ref seq k) (seq-ref seq x))
            (set! l x)))
        (swap seq k l)
        (reverse-subseq seq (add1 k) last))
      (and k seq))))

;; Vector permutations
(define-values/invoke-unit permutation@
  (import (rename seq^
                  [vector-length seq-length]
                  [vector-ref seq-ref]
                  [vector-set! seq-set!]))
  (export permutation^))

;; String permutations
(define-values/invoke-unit permutation@
  (import (rename seq^
                  [string-length seq-length]
                  [string-ref seq-ref]
                  [string-set! seq-set!]))
  (export (rename permutation^
                  [full-string-next-permutation next-permutation])))

;; The string version always uses chars.
(define (string-next-permutation str)
  (full-string-next-permutation str char<?))
