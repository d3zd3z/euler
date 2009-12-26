#lang scheme

;;; By replacing the 1^(st) digit of *3, it turns out that six of the
;;; nine possible values: 13, 23, 43, 53, 73, and 83, are all prime.
;;;
;;; By replacing the 3^(rd) and 4^(th) digits of 56**3 with the same
;;; digit, this 5-digit number is the first example having seven
;;; primes among the ten generated numbers, yielding the family:
;;; 56003, 56113, 56333, 56443, 56663, 56773, and 56993. Consequently
;;; 56003, being the first member of this family, is the smallest
;;; prime with this property.
;;;
;;; Find the smallest prime which, by replacing part of the number
;;; (not necessarily adjacent digits) with the same digit, is part of
;;; an eight prime value family.

(require (except-in (planet soegaard/math:1:4/math)
		    generator))
(require scheme/control)
(require srfi/60)

;;; Return the indices in the string str, where chr occurs.  Result is
;;; a vector.
(define (string-indices str chr)
  (list->vector
    (for/list ([i (in-range (string-length str))]
	       #:when (char=? chr (string-ref str i)))
      i)))

;;; Select elements from the given vector that correspond to set bits
;;; in the selector.  Returns a list of only those selected elements
;;; (the result is also reversed).
(define (vector-select vec selector)
  (let loop ([bits selector]
	     [answer '()])
    (if (positive? bits)
      (let ([bit (first-set-bit bits)])
	(loop (copy-bit bit bits #f)
	      (cons (vector-ref vec bit) answer)))
      answer)))

(define zero-char (char->integer #\0))
(define (digits-from chr)
  (substring "0123456789" (- (char->integer chr) zero-char)))

(define (view prime count)
  (when (> count 7)
    (abort prime)))

(define (permutes num chr)
  (define str (number->string num))
  (define indices (string-indices str chr))
  (for ([sel (in-range 1 (ash 1 (vector-length indices)))])
    (define count 0)
    (define prime 0)
    (for ([nch (in-string (digits-from chr))])
      (define str2 (string-copy str))
      (for ([pos (in-list (vector-select indices sel))])
	(string-set! str2 pos nch))
      (let ([num2 (string->number str2)])
	(when (prime? num2)
	  (when (zero? prime)
	    (set! prime num2))
	  (set! count (add1 count)))))
    (when (positive? count)
      (view prime count))))

(provide main)
(define (main)
  (display (prompt
	     (let loop ([num 56003])
	       (for ([chr (in-string "0123")])
		 (permutes num chr))
	       (loop (next-prime num)))))
  (newline))
