;;; Prime sieve.

(define-module (sieve)
  #:export (make-sieve prime? next-prime
		       divisor-count factorize
		       divisors proper-divisor-sum))

(use-modules (srfi srfi-1))
(use-modules (srfi srfi-9))

(define-record-type <sieve>
		    (make-sieve%)
		    sieve?
		    (size sieve-size set-sieve-size!)
		    (data sieve-data set-sieve-data!))

(define (advance n)
  (if (= n 2) 3 (+ n 2)))

(define (fill-sieve s size)
  (let ((buf (make-vector size #t)))
    (vector-set! buf 0 #f)
    (vector-set! buf 1 #f)

    (let loop ((pos 2))
      (when (< pos size)
	(cond ((vector-ref buf pos)
	       (let iloop ((n (+ pos pos)))
		 (when (< n size)
		   (vector-set! buf n #f)
		   (iloop (+ n pos))))
	       (loop (advance pos)))
	      (else
		(loop (advance pos))))))
    (set-sieve-size! s size)
    (set-sieve-data! s buf)))

;;; Given an existing size, and a required limit 'n', return a new
;;; size that is better.
(define (better-size existing needed)
  (if (< needed existing)
    existing
    (better-size (* existing 8) needed)))

(define (prime? s n)
  (define current-size (sieve-size s))
  (when (>= n (sieve-size s))
    (let ((new-size (better-size current-size n)))
      (fill-sieve s new-size)))
  (vector-ref (sieve-data s) n))

(define (next-prime s n)
  (let loop ((n (advance n)))
    (if (prime? s n)
      n
      (loop (advance n)))))

(define (make-sieve)
  (let ((s (make-sieve%)))
    (fill-sieve s 1024)
    s))

;;; How many divisors to this number.
(define (divisor-count sieve n)
  (let loop ((result 1)
	     (n n)
	     (prime 2))
    (if (= n 1) result
      (let iloop ((divide-count 0)
		  (n n))
	(if (zero? (remainder n prime))
	  (iloop (1+ divide-count)
		 (quotient n prime))
	  (loop (* result (1+ divide-count))
		n
		(next-prime sieve prime)))))))

;;; Append this factor, if the count is positive.
(define (add-factor result p count)
  (if (positive? count)
    (cons (cons p count) result)
    result))

;;; Factorize the given number.
(define (factorize sieve n)
  (let loop ((result '())
	     (n n)
	     (p 2)
	     (count 0))
    (if (= n 1)
      (add-factor result p count)
      (if (zero? (remainder n p))
	(loop result (quotient n p) p (1+ count))
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
	(if (> i x-power) result
	  (loop (append result (map (lambda (x) (* x power)) others))
		(* power x-prime)
		(1+ i)))))))

(define (divisors sieve n)
  (sort! (spread (factorize sieve n)) <))

(define (proper-divisor-sum sieve n)
  (- (reduce + 0 (divisors sieve n)) n))
