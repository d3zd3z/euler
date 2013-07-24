;;; Euler utilities.
;;;
;;; Permutations of a vector (of numbers)

(use-modules (srfi srfi-1)
	     (srfi srfi-8))

(define (swap seq i j)
  (define tmp (vector-ref seq i))
  (vector-set! seq i (vector-ref seq j))
  (vector-set! set j tmp))

(define (reverse-subseq seq i j)
  (when (< i j)
    (swap seq i j)
    (reverse-subseq seq (1+ i) (1- j))))

;;; First step, write a strict computation of a sequence.

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
