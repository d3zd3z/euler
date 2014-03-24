#! /usr/bin/guile -s
!#

;;; Problem 23
;;;
;;; 02 August 2002
;;;
;;;
;;; A perfect number is a number for which the sum of its proper divisors is
;;; exactly equal to the number. For example, the sum of the proper divisors
;;; of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect
;;; number.
;;;
;;; A number n is called deficient if the sum of its proper divisors is less
;;; than n and it is called abundant if this sum exceeds n.
;;;
;;; As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the
;;; smallest number that can be written as the sum of two abundant numbers is
;;; 24. By mathematical analysis, it can be shown that all integers greater
;;; than 28123 can be written as the sum of two abundant numbers. However,
;;; this upper limit cannot be reduced any further by analysis even though it
;;; is known that the greatest number that cannot be expressed as the sum of
;;; two abundant numbers is less than this limit.
;;;
;;; Find the sum of all the positive integers which cannot be written as the
;;; sum of two abundant numbers.
;;;
;;; 4179871

(add-to-load-path (dirname (current-filename)))
(use-modules (sieve)
	     (srfi srfi-1))

#|
(define (abundant? sieve n)
  (> (proper-divisor-sum sieve n) n))

(define (abundants sieve limit)
  (filter (lambda (x) (abundant? sieve x))
	  (iota limit 1)))

(define (euler-23)
  (let* ((limit 28123)
	 (sieve (make-sieve))
	 (abundant-list (abundants sieve limit))
	 (abundant-set (make-hash-table)))
    (define (as-sum? elt)
      (any (lambda (x)
	     (hashv-ref abundant-set (- elt x)))
	   abundant-list))
    (display "for-each") (newline) (force-output)
    (for-each (lambda (elt)
		(hashv-set! abundant-set elt #t))
	      abundant-list)
    (display "reducing") (newline) (force-output)
    (reduce + 0
	    (filter (lambda (x) (not (as-sum? x)))
		    (iota limit 1)))))
|#

;; Faster version.
(define (make-divisors limit)
  (define result (make-vector limit 1))
  (vector-set! result 0 #f)
  (do ((i 2 (1+ i)))
      ((>= i limit))
    (do ((j (+ i i) (+ j i)))
        ((>= j limit))
      (vector-set! result j (+ (vector-ref result j) i))))
  result)

(define (make-abundants limit)
  (define divisors (make-divisors limit))
  (define result '())
  (do ((i 1 (1+ i)))
      ((>= i limit))
    (when (< i (vector-ref divisors i))
      (set! result (cons i result))))
  (reverse! result))

(define (euler-23)
  (define limit 28124)
  (define abundants (make-abundants limit))
  (define invalids (make-hash-table))
  (define total 0)
  (do ((aa abundants (cdr aa)))
      ((null? aa))
    (let ((a (car aa)))
      (let loop ((bb aa))
	(when (not (null? bb))
	  (let* ((b (car bb))
		 (both (+ a b)))
	    (when (< both limit)
	      (hashv-set! invalids both #t)
	      (loop (cdr bb))))))))

  (do ((i 1 (1+ i)))
      ((>= i limit))
    (unless (hashv-ref invalids i)
      (set! total (+ total i))))
  total)

(define (main)
  (display (euler-23))
  (newline))
(main)
