;;; Problem 27
;;;
;;; 27 September 2002
;;;
;;;
;;; Euler published the remarkable quadratic formula:
;;;
;;; n^2 + n + 41
;;;
;;; It turns out that the formula will produce 40 primes for the consecutive
;;; values n = 0 to 39. However, when n = 40, 40^2 + 40 + 41 = 40(40 + 1) + 41
;;; is divisible by 41, and certainly when n = 41, 41^2 + 41 + 41 is clearly
;;; divisible by 41.
;;;
;;; Using computers, the incredible formula  n^2 − 79n + 1601 was discovered,
;;; which produces 80 primes for the consecutive values n = 0 to 79. The
;;; product of the coefficients, −79 and 1601, is −126479.
;;;
;;; Considering quadratics of the form:
;;;
;;;     n^2 + an + b, where |a| < 1000 and |b| < 1000
;;;
;;;     where |n| is the modulus/absolute value of n
;;;     e.g. |11| = 11 and |−4| = 4
;;;
;;; Find the product of the coefficients, a and b, for the quadratic
;;; expression that produces the maximum number of primes for consecutive
;;; values of n, starting with n = 0.
;;; -59231

#!r6rs

(import
  (rnrs base (6))
  (rnrs control (6))
  (rnrs io simple (6))
  (only (util) add1)
  (sieve))

(define (count-primes sieve a b)
  (let loop ((n 0))
    (define p (+ (* n n) (* a n) b))
    (if (and (positive? p) (prime? sieve p))
      (loop (add1 n))
      n)))

(define (euler-27)
  (define sieve (make-sieve))
  (define largest 0)
  (define largest-result 0)
  (do ([a -999 (add1 a)]) ((= a 1000))
    (do ([b -999 (add1 b)]) ((= b 1000))
      (let ([count (count-primes sieve a b)])
	(when (> count largest)
	  (set! largest count)
	  (set! largest-result (* a b))))))
  largest-result)

(define (main)
  (display (euler-27))
  (newline))
(main)
