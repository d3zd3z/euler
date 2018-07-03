;;; Euler utilities

(library (euler)
  (export
    digit-power-sum
    next-string-permutation string-permutations)
  (import
    (rnrs base (6))
    (rnrs control (6))
    (rnrs mutable-strings (6)))

  (define (digit-power-sum number power)
    (let loop ([number number]
	       [sum 0])
      (if (zero? number)
	sum
	(let ([n (div number 10)]
	      [m (mod number 10)])
	  (loop n (+ sum (expt m power)))))))

  ;;; String permutations.
  (define (swap str i j)
    (define tmp (string-ref str i))
    (string-set! str i (string-ref str j))
    (string-set! str j tmp))

  (define (reverse-subseq str i j)
    (when (< i j)
      (swap str i j)
      (reverse-subseq str (+ i 1) (- j 1))))

  ;;; Fairly direct translation out of the code from Wikipedia.  It
  ;;; isn't very scheme.
  ;;; Permutes the string 'str' in place to produce the next
  ;;; permutation.  Returns the string, if this is possible, or
  ;;; returns #f if there are no remaining permutations.
  (define (next-string-permutation str)
    (define last (- (string-length str) 1))
    (define k #f)
    (do ([x 0 (+ x 1)])
      ([= x last])
      (when (char<? (string-ref str x)
		    (string-ref str (+ x 1)))
	(set! k x)))
    (when k
      (let ([l #f])
	(do ([x (+ k 1) (+ x 1)])
	  ([> x last])
	  (when (char<? (string-ref str k)
			(string-ref str x))
	    (set! l x)))
	(swap str k l)
	(reverse-subseq str (+ k 1) last)))
    (and k str))

  ;;; Call (func str) for each permutation of the given string.  The
  ;;; string will be copied, but each func may be called with the same
  ;;; storage (the string will not remain valid across calls).
  (define (string-permutations func str)
    (let loop ([str (string-copy str)])
      (when str
	(func str)
	(loop (next-string-permutation str)))))

)
