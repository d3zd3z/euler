#lang racket

;;; Problem 49
;;;
;;; 01 August 2003
;;;
;;; The arithmetic sequence, 1487, 4817, 8147, in which each of the terms
;;; increases by 3330, is unusual in two ways: (i) each of the three terms are
;;; prime, and, (ii) each of the 4-digit numbers are permutations of one
;;; another.
;;;
;;; There are no arithmetic sequences made up of three 1-, 2-, or 3-digit
;;; primes, exhibiting this property, but there is one other 4-digit
;;; increasing sequence.
;;;
;;; What 12-digit number do you form by concatenating the three terms in this
;;; sequence?
;;;
;;; 296962999629

(require "euler.rkt")
(require "ssieve.rkt")
(require srfi/26)

(define (number->digits num)
  (let loop ([num num]
	     [result '()])
    (if (zero? num) result
      (loop (quotient num 10)
	    (cons (remainder num 10) result)))))

(define (vec-digits->number digits)
  (for/fold ([result 0]) ([i (in-range (vector-length digits))])
    (+ (* result 10) (vector-ref digits i))))

(define (number-permutations base)
  (define start (list->vector (sort (number->digits base) <)))
  (cons (vec-digits->number start)
	(for/list ([vec (in-producer (cut next-permutation <> <) #f start)])
	  (vec-digits->number vec))))

(define (prime-permutations sieve base)
  (filter (cut prime? sieve <>)
	  (number-permutations base)))

;;; Return the partitions of 'sets'.
(define (partitions sets)
  (define (walk sets)
    (if (null? sets) '(())
      (let ([next (walk (cdr sets))])
	(append next (map (lambda (s) (cons (car sets) s)) next)))))
  (walk sets))

;;; Is this set valid according to the problem definition?
(define (valid? nums)
  (match nums
    [(list a b c) (and (not (= a b))
		       (= (- c b) (- b a)))]
    [_ #f]))

;;; Are the digits in this number ascending (or equal)?
(define (ascending-number? num)
  (define digits (number->digits num))
  (let loop ([digits digits])
    (match digits
      [(list a b _ ...) 
       (and (<= a b)
	    (loop (cdr digits)))]
      [_ #t])))

;;; Find all of the sequences from the given base that match the
;;; rules.
(define (find-pieces sieve base)
  (filter valid? (partitions (prime-permutations sieve base))))

;;; Convert the result into ready format.
(define (make-result items)
  (define buf (open-output-string))
  (for-each (cut write <> buf) items)
  (get-output-string buf))

(define (euler-49)
  (define sieve (make-sieve))
  (define result
    (for/fold ([result '()])
      ([i (in-range 1000 10000)]
       #:when (ascending-number? i))
      (append (find-pieces sieve i) result)))
  (make-result (first result)))

(display (euler-49))
(newline)
