#lang racket

;;; Problem 47
;;;
;;; 04 July 2003
;;;
;;; The first two consecutive numbers to have two distinct prime factors are:
;;;
;;; 14 = 2 x 7
;;; 15 = 3 x 5
;;;
;;; The first three consecutive numbers to have three distinct prime factors
;;; are:
;;;
;;; 644 = 2^2 x 7 x 23
;;; 645 = 3 x 5 x 43
;;; 646 = 2 x 17 x 19.
;;;
;;; Find the first four consecutive integers to have four distinct primes
;;; factors. What is the first of these numbers?

(require (only-in
	   (planet soegaard/math:1:5/math)
	   factorize))

;;; Given a list of factor lists, returns #t if they lists are all
;;; unique.
(define (unique-factors? flist)
  (define collection (sort (apply append flist) < #:key car))
  (let loop ([l collection])
    (match l
      [(list a b _ ...)
       (if (equal? a b) #f
	 (loop (cdr l)))]
      [_ #t])))

;;; Are all of the lists of length 'n'.
(define (all-n? lists n)
  (for/and ([l (in-list lists)])
    (= (length l) n)))

(define (solve size)
  (define sizem1 (sub1 size))
  (define start (sequence->list (in-range 1 size)))
  (define facts (map factorize start))

  (let loop ([facts facts]
	     [n size])
    (let ([next-facts (cons (factorize n)
			    (take facts sizem1))])
      (if (and (all-n? next-facts size)
	       (unique-factors? next-facts))
	(- n sizem1)
	(loop next-facts (add1 n))))))

(define (euler-47)
  (solve 4))
(time (euler-47))
