;;; Simple prime sieve.

#lang racket

(provide prime?
	 next-prime
	 make-sieve)

(struct sieve ([size #:mutable]
	       [vec #:mutable]))

(define (advance n)
  (if (= n 2) 3 (+ n 2)))

(define (fill-sieve s size)
  (let ([buf (make-vector size #t)])
    (vector-set! buf 0 #f)
    (vector-set! buf 1 #f)

    (let loop ([pos 2])
      (when (< pos size)
	(cond [(vector-ref buf pos)
	       (let loop ([n (+ pos pos)])
		 (when (< n size)
		   (vector-set! buf n #f)
		   (loop (+ n pos))))
	       (loop (advance pos))]
	      [else
		(loop (advance pos))])))

    (set-sieve-size! s size)
    (set-sieve-vec! s buf)))

;;; Given an existing size, and a required limit 'n', return a new
;;; size that is better.
(define (better-size existing needed)
  (if (< needed existing)
    existing
    (better-size (* existing 8) needed)))

(define (prime? s n)
  (when (>= n (sieve-size s))
    (fill-sieve s (better-size (sieve-size s) n)))
  (vector-ref (sieve-vec s) n))

(define (next-prime s n)
  (let loop ([n (advance n)])
    (if (prime? s n)
      n
      (loop (advance n)))))

(define (make-sieve)
  (let ([s (sieve 0 '#())])
    (fill-sieve s 1024)
    s))
