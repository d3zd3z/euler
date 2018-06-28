;;; Problem 24
;;;
;;; 16 August 2002
;;;
;;; A permutation is an ordered arrangement of objects. For example, 3124 is
;;; one possible permutation of the digits 1, 2, 3 and 4. If all of the
;;; permutations are listed numerically or alphabetically, we call it
;;; lexicographic order. The lexicographic permutations of 0, 1 and 2 are:
;;;
;;; 012   021   102   120   201   210
;;;
;;; What is the millionth lexicographic permutation of the digits 0, 1, 2, 3,
;;; 4, 5, 6, 7, 8 and 9?
;;;
;;; 2783915460

#!r6rs

(import
  (rnrs base (6))
  (rnrs io simple (6))
  (rnrs lists (6))
  (only (util) add1 sub1))

(define (factoric0 num base digits)
  (cond ([zero? digits] '())
	(else
	  (let-values ([(q r) (div-and-mod num base)])
	    (cons r (factoric0 q (add1 base) (sub1 digits)))))))

;;; Decompose a number into it's factoric composition.  This works
;;; like regular number composition, except that the base increases by
;;; one each digit.
(define (factoric num digits)
  (reverse (factoric0 num 1 digits)))

;;; Extract the nth value from a list (counting from zero).  Returns
;;; two values, the value taken, and the new list with that item
;;; removed.
(define (take-n lst n)
  (define first (car lst))
  (define rest (cdr lst))
  (cond ([zero? n]
	 (values first rest))
	(else
	  (let-values ([(item rest) (take-n rest (sub1 n))])
	    (values item (cons first rest))))))

;;; Return the nth permutation of the list, assuming the list is
;;; already in lowest order.
(define (nth-permutation lst n)
  (define lst-len (length lst))
  (define order (factoric n lst-len))
  (let loop ([order order]
	     [lst lst]
	     [result '()])
    (if (null? order)
      (reverse result)
      (let-values ([(item lst2) (take-n lst (car order))])
	(loop (cdr order)
	      lst2
	      (cons item result))))))

;;; Note that we count from zero, but the problem description counts
;;; from 1.
(define (euler-24)
  (define digits (nth-permutation '(0 1 2 3 4 5 6 7 8 9) 999999))
  (fold-left (lambda (x a) (+ (* x 10) a)) 0 digits))

(define (main . argv)
  (display (euler-24))
  (newline))

(main)
