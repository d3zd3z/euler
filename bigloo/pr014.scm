;;; Problem 14
;;;
;;; 05 April 2002
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

(module pr014
  (import utilities)
  (main main))

(define (chain-next n)
  (if (odd? n)
    (+ (* n 3) 1)
    (quotient n 2)))

(define (chain-len n)
  (let loop ((n n)
	     (count 1))
    (if (= n 1) count
      (loop (chain-next n)
	    (+ count 1)))))

(define (longest)
  (let loop ((n 1)
	     (longest-term 1)
	     (longest-length 0))
    (if (= n 1000000)
      longest-term
      (let ((len (chain-len n)))
	(if (> len longest-length)
	  (loop (+ n 1) n len)
	  (loop (+ n 1) longest-term longest-length))))))

;;; TODO: Cached version of this.

(define (euler-14)
  (longest))

(define (main argv)
  (display (mytime (euler-14)))
  (newline))
