#lang scheme
;;; The number 145 is well known for the property that the sum of the
;;; factorial of its digits is equal to 145:
;;; 
;;; 1! + 4! + 5! = 1 + 24 + 120 = 145
;;; 
;;; Perhaps less well known is 169, in that it produces the longest chain
;;; of numbers that link back to 169; it turns out that there are only
;;; three such loops that exist:
;;; 
;;; 169 → 363601 → 1454 → 169
;;; 871 → 45361 → 871
;;; 872 → 45362 → 872
;;; 
;;; It is not difficult to prove that EVERY starting number will eventually
;;; get stuck in a loop. For example,
;;; 
;;; 69 → 363600 → 1454 → 169 → 363601 (→ 1454)
;;; 78 → 45360 → 871 → 45361 (→ 871)
;;; 540 → 145 (→ 145)
;;; 
;;; Starting with 69 produces a chain of five non-repeating terms, but the
;;; longest non-repeating chain with a starting number below one million is
;;; sixty terms.
;;; 
;;; How many chains, with a starting number below one million, contain
;;; exactly sixty non-repeating terms?

(define fact
  (let ([fvect (let loop ([ind 1]
			  [prod 1]
			  [accum '(1)])
		 (if (< ind 10)
		   (loop (add1 ind) (* prod (add1 ind)) (cons prod accum))
		   (list->vector (reverse accum))))])
    (lambda (num)
      (vector-ref fvect num))))

(define (fact-sum n)
  (let loop ([sum 0]
	     [n n])
    (if (zero? n)
      sum
      (let-values ([(quot rem) (quotient/remainder n 10)])
	(loop (+ sum (fact rem)) quot)))))

;;; The problem is asking for the entire chain length up until a
;;; repeat, and we know the limit is 60.  Let's just use a hash table
;;; to hold the items we've seen and count them.
(define (chain-length n)
  (define ht (make-hasheqv))
  (let loop ([n n])
    (if (hash-has-key? ht n)
      (hash-count ht)
      (begin
	(hash-set! ht n #t)
	(loop (fact-sum n))))))

;;; TODO: This runs in sufficient time.  We could memoize these
;;; results by using different sentinel values to keep track of what
;;; is happening.

(define (compute limit)
  (let loop ([x 1]
	     [count 0])
    (if (< x limit)
      (if (= (chain-length x) 60)
	(loop (add1 x) (add1 count))
	(loop (add1 x) count))
      count)))

(display (compute 1000000))
(newline)

;;; This code is interesting, but not actually useful, since it isn't
;;; what the problem is asking for.
;;; # Python example of Brent's algorithm from wikipedia.
;;; def brent(f, x0):
;;;     # main phase: search successive powers of two
;;;     power = lam = 1
;;;     tortoise, hare = x0, f(x0) # f(x0) is the element/node next to x0.
;;;     while tortoise != hare:
;;;         if power == lam:   # time to start a new power of two?
;;;             tortoise = hare
;;;             power *= 2
;;;             lam = 0
;;;         hare = f(hare)
;;;         lam += 1
;;;  
;;;     # Find the position of the first repetition of length lambda
;;;     mu = 0
;;;     tortoise = hare = x0
;;;     for i in range(lam):
;;;     # range(lam) produces a list with the values 0, 1, ... , lam-1
;;;         hare = f(hare)
;;;     while tortoise != hare:
;;;         tortoise = f(tortoise)
;;;         hare = f(hare)
;;;         mu += 1
;;;  
;;;     return lam, mu

