;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Prime sieve
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(module sieve
  (export prime? next-prime make-sieve))

(define-struct %sieve
  (size 0)
  (data '#()))

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
  (let ((s (make-%sieve)))
    (fill-sieve s 1024)
    s))
