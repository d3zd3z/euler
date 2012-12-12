;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Prime sieve
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; TODO: Figure out how to build this if we make it as a module.
;;; Right now, we'll just use the top-level namespace.

(use srfi-17)

(declare (unit sieve))

(module sieve (prime? next-prime make-sieve)
  (import scheme chicken)
  (define-record %sieve (setter size) (setter data))

  (define (advance n)
    (if (= n 2) 3 (+ n 2)))

  (define (fill-sieve s size)
    (let ((buf (make-vector size #t)))
      (set! (vector-ref buf 0) #f)
      (set! (vector-ref buf 1) #f)

      (let loop ((pos 2))
	(when (< pos size)
	  (cond ((vector-ref buf pos)
		 (let loop ((n (+ pos pos)))
		   (when (< n size)
		     (set! (vector-ref buf n) #f)
		     (loop (+ n pos))))
		 (loop (advance pos)))
		(else
		  (loop (advance pos))))))

      (set! (%sieve-size s) size)
      (set! (%sieve-data s) buf)))

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
  )
