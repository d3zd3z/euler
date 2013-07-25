;;; Euler utilities.
;;;

(define-module (euler)
  #:export (digit-power-sum
	     next-string-permutation string-permutations))

(use-modules (srfi srfi-1)
	     (srfi srfi-8)
	     (srfi srfi-42))

;;; Return the sum of the digits each raised to power.
(define (digit-power-sum number power)
  (let loop ((number number)
	     (sum 0))
    (if (zero? number)
      sum
      (let ((n (quotient number 10))
	    (m (remainder number 10)))
	(loop n (+ sum (expt m power)))))))

;;; String permutations.
(define (swap str i j)
  (define tmp (string-ref str i))
  (string-set! str i (string-ref str j))
  (string-set! str j tmp))

;;; Reverse part.
(define (reverse-subseq str i j)
  (when (< i j)
    (swap str i j)
    (reverse-subseq str (1+ i) (1- j))))

;;; Fairly direct translation out of the code from Wikipedia.  It
;;; isn't not very schemey.
;;; Permutes the string 'str' in place to produce the next
;;; permutation.  Returns the string, if this is possible, or returns
;;; #f if there are no remaining permutations.
(define (next-string-permutation str)
  (define last (1- (string-length str)))
  (define k #f)
  (do-ec (:range x last)
	 (when (char<? (string-ref str x)
		       (string-ref str (1+ x)))
	   (set! k x)))
  (when k
    (let ((l #f))
      (do-ec (:range x (1+ k) (1+ last))
	     (when (char<? (string-ref str k)
			   (string-ref str x))
	       (set! l x)))
      (swap str k l)
      (reverse-subseq str (1+ k) last)))
  (and k str))

;;; Call (func str) for each permutation of the given string.  The
;;; string will be copied, but each func may be called with the same
;;; storage (the string will not remain valid across calls).
(define (string-permutations func str)
  (let loop ((str (string-copy str)))
    (when str
      (func str)
      (loop (next-string-permutation str)))))
