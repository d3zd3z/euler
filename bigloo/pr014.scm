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

(define (longest chain-len)
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
;;; Compute a cached version by keeping an array of learned counts.
;;; These are initially #f, and we fill them in as we learn them.

(define (make-cache size)
  (make-vector size #f))

(define (cached-chain-len n cache)
  (define cache-limit (vector-length cache))
  (define (go-next n)
    (let* ((next-num (if (odd? n)
		       (+ (* n 3) 1)
		       (quotient n 2)))
	   (result (+ 1 (cached-chain-len next-num cache))))
      (when (< n cache-limit)
	(vector-set! cache n result))
      result))
  (define (next n)
    (if (= n 1) 1
      (go-next n)))

  (if (< n cache-limit)
    (let ((v (vector-ref cache n)))
      (if v v
	(next n)))
    (next n)))

(define (euler-14)
  (define cache (make-cache 100000))
  ; (longest chain-len)
  ; (longest (cut cached-chain-len <> cache))
  (longest (lambda (n) (cached-chain-len n cache))))

(define (main argv)
  (display (mytime (euler-14)))
  (newline))
