#lang racket

;;; Problem 27
;;;
;;; 27 September 2002
;;;
;;; Euler published the remarkable quadratic formula:
;;;
;;; n² + n + 41
;;;
;;; It turns out that the formula will produce 40 primes for the consecutive
;;; values n = 0 to 39. However, when n = 40, 40^2 + 40 + 41 = 40(40 + 1) + 41
;;; is divisible by 41, and certainly when n = 41, 41² + 41 + 41 is clearly
;;; divisible by 41.
;;;
;;; Using computers, the incredible formula  n² − 79n + 1601 was discovered,
;;; which produces 80 primes for the consecutive values n = 0 to 79. The
;;; product of the coefficients, −79 and 1601, is −126479.
;;;
;;; Considering quadratics of the form:
;;;
;;;     n² + an + b, where |a| < 1000 and |b| < 1000
;;;
;;;     where |n| is the modulus/absolute value of n
;;;     e.g. |11| = 11 and |−4| = 4
;;;
;;; Find the product of the coefficients, a and b, for the quadratic
;;; expression that produces the maximum number of primes for consecutive
;;; values of n, starting with n = 0.

(require math/number-theory)

(define (count-primes a b)
  (let loop ([n 0])
    (define p (+ (sqr n) (* a n) b))
    (if (and (positive? p) (prime? p))
        (loop (add1 n))
        n)))

(define (euler-27)
  (define-values (count result)
    (for*/fold ([largest 0]
                [largest-result 0])
        ([a (in-range -999 1000)]
         [b (in-range -999 1000)])
      (define count (count-primes a b))
      (if (> count largest)
          (values count (* a b))
          (values largest largest-result))))
  result)

(module* main #f
  (euler-27))
