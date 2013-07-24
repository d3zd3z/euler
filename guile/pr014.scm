#! /usr/bin/guile -s
!#

;;; Problem 14
;;;
;;; 05 April 2002
;;;
;;;
;;; The following iterative sequence is defined for the set of positive
;;; integers:
;;;
;;; n → n/2 (n is even)
;;; n → 3n + 1 (n is odd)
;;;
;;; Using the rule above and starting with 13, we generate the following
;;; sequence:
;;;
;;; 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
;;;
;;; It can be seen that this sequence (starting at 13 and finishing at 1)
;;; contains 10 terms. Although it has not been proved yet (Collatz Problem),
;;; it is thought that all starting numbers finish at 1.
;;;
;;; Which starting number, under one million, produces the longest chain?
;;;
;;; NOTE: Once the chain starts the terms are allowed to go above one million.
;;;
;;; 837799

(use-modules (ice-9 vlist))

;;; Simple, non-memoized version
(define (chain-length n)
  (let loop ((length 1)
	     (n n))
    (cond ((= n 1) length)
	  ((even? n) (loop (1+ length) (quotient n 2)))
	  (else (loop (1+ length) (1+ (* n 3)))))))

(define (solve chain-length)
  (let loop ((largest 0)
	     (largest-value #f)
	     (n 1))
    (if (= n 1000000)
      largest-value
      (let ((temp (chain-length n)))
	(if (> temp largest)
	  (loop temp n (1+ n))
	  (loop largest largest-value (1+ n)))))))

;;; Cache using the vhash.  Although immutable, it seems rather slow.
(define (cached-chain-length)
  (define cache vlist-null)
  (define (top-lookup n)
    (define box (vhash-assv n cache))
    (if box (cdr box)
      (let ((result (next-lookup n)))
	(set! cache (vhash-consv n result cache))
	result)))
  (define (next-lookup n)
    (cond ((= n 1) 1)
	  ((even? n) (1+ (top-lookup (quotient n 2))))
	  (else (1+ (top-lookup (1+ (* n 3)))))))
  top-lookup)

;;; This is about the fastest.
(define (hashed-chain-len)
  (define cache (make-hash-table))
  (define (top-lookup n)
    (define box (hashv-ref cache n))
    (or box
	(let ((result (next-lookup n)))
	  (hashv-set! cache n result)
	  result)))
  (define (next-lookup n)
    (cond ((= n 1) 1)
	  ((even? n) (1+ (top-lookup (quotient n 2))))
	  (else (1+ (top-lookup (1+ (* n 3)))))))
  top-lookup)

(define (euler-14)
  (solve (hashed-chain-len)))

(define (main)
  (display (euler-14))
  (newline))
(main)
