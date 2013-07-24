;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Prime sieve
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(import util)
(import (srfi sorting)
        (srfi lists))
(export prime? next-prime make-sieve
        divisor-count factorize divisors
        proper-divisor-sum)

(define-structure %sieve size data)

(define (advance n)
  (if (= n 2) 3 (+ n 2)))

(define (fill-sieve s size)
  (let ((buf (make-vector size #t)))
    (vector-set! buf 0 #f)
    (vector-set! buf 1 #f)

    (let loop ((pos 2))
      (when (< pos size)
	(cond ((vector-ref buf pos)
               (let loop ((n (+ pos pos)))
                 (when (< n size)
                   (vector-set! buf n #f)
                   (loop (+ n pos))))
               (loop (advance pos)))
              (else
               (loop (advance pos))))))

    (%sieve-size-set! s size)
    (%sieve-data-set! s buf)))

;;; Given an existing size exiting, and a required limit 'n', return a
;;; new size that is better.
(define (better-size existing needed)
  (if (< needed existing)
    existing
    (better-size (* existing 8) needed)))

(define (prime? s n)
  (when (>= n (%sieve-size s))
    (fill-sieve s (better-size (%sieve-size s) n)))
  (vector-ref (%sieve-data s) n))

(define (next-prime s n)
  (let loop ((n (advance n)))
    (if (prime? s n)
      n
      (loop (advance n)))))

(define (make-sieve)
  (let ((s (make-%sieve 0 '#())))
    (fill-sieve s 1024)
    s))

(define (divisor-count sieve n)
  (let loop ((result 1)
             (n n)
             (prime 2))
    (if (= n 1) result
        (let iloop ((divide-count 0)
                    (n n))
          (if (zero? (remainder n prime))
              (iloop (add1 divide-count)
                     (quotient n prime))
              (loop (* result (add1 divide-count))
                    n
                    (next-prime sieve prime)))))))

(define (add-factor result p count)
  (if (positive? count)
      (cons (cons p count) result)
      result))

(define (factorize sieve n)
  (let loop ((result '())
             (n n)
             (p 2)
             (count 0))
    (if (= n 1)
        (add-factor result p count)
        (if (zero? (remainder n p))
            (loop result (quotient n p) p (+ count 1))
            (loop (add-factor result p count)
                  n (next-prime sieve p) 0)))))

(define (spread factors)
  (if (null? factors)
      (list 1)
      (let* ((x (car factors))
             (x-prime (car x))
             (x-power (cdr x))
             (others (spread (cdr factors))))
        (let loop ((result '())
                   (power 1)
                   (i 0))
          (if (> i x-power)
              result
              (loop (append result (map (lambda (x) (* x power)) others))
                    (* power x-prime)
                    (+ i 1)))))))

(define (divisors sieve n)
  (sort! (spread (factorize sieve n)) <))

(define (proper-divisor-sum sieve n)
  (- (reduce + 0 (divisors sieve n)) n))
