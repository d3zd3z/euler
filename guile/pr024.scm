#! /usr/bin/guile -s
!#

;;; Problem 24
;;;
;;; 16 August 2002
;;;
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

(use-modules (srfi srfi-1)
	     (srfi srfi-8)
	     (srfi srfi-26))

;;; This is entirely strict, which works, but takes a lot of memory.
(define (lex-perm items)
  (define (pick pos acc)
    (receive (hd tl) (split-at items pos)
      (append (map (lambda (x)
		     (cons (car tl) x))
		   (lex-perm (append hd (cdr tl))))
	      acc)))
  (if (null? (cdr items))
    (list items)
    (fold-right pick '() (iota (length items)))))

;;; Rewrite this as an internal iterator, rather than returning the
;;; entire result.
(define (push-perm func items)
  (define (pick func pos)
    (receive (hd tl) (split-at items pos)
      (define (step part)
	(func (cons (car tl) part)))
      (push-perm step (append hd (cdr tl)))))
  (if (null? (cdr items))
    (func items)
    (for-each (cut pick func <>) (iota (length items)))))

(define (push-solve)
  (define count 999999)
  (define (each item)
    (set! count (1- count))
    (when (zero? count)
      (throw 'result item)))
  (catch
    'result
    (lambda ()
      (push-perm each (iota 10)))
    (lambda (key result)
      result)))

(define (show items)
  (define (each item)
    (display item)
    (newline))
  (push-perm each items))

(define (assemble digits)
  (let loop ((digits digits)
	     (result 0))
    (if (null? digits) result
      (loop (cdr digits)
	    (+ (* result 10) (car digits))))))

(define (euler-24)
  ; (assemble (list-ref (lex-perm (iota 10)) 999999))
  (assemble (push-solve))
  )

(define (main)
  (display (euler-24))
  (newline))
(main)
