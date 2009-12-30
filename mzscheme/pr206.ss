#lang scheme

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Find the unique positive integer whose square has the form
;;; 1_2_3_4_5_6_7_8_9_0,
;;; where each “_” is a single digit.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Known that the answer ends in 00, we could check 1/10 as many of
;;; them, and only check for the pattern 1_2_3_4_5_6_7_8_9, which
;;; makes things a bit simpler, and faster.

#|
 | Performance of the unrolled version is insignificantly different
 | from the regular inlined one.
 |#
#|
;;; Does the number match the pattern.  In order to get the
;;; performanced we need, unroll the whole thing.

(define-syntax unroll-check
  (lambda (stx)
    (syntax-case stx ()
      [(_ num 1)
       #'(= (remainder num 10) 1)]
      [(_ num div)
       (let ([ndiv (syntax-e #'div)])
	 #`(let-values ([(n d) (quotient/remainder num 10)])
	     (if (= d #,(remainder ndiv 10))
	       (unroll-check (quotient n 10) #,(sub1 ndiv))
	       #f)))])))

(define (valid-old num)
  (unroll-check num 9))
|#

;(define (quotient/remainder x y)
; (values (quotient x y) (remainder x y)))

(define (valid num)
  (let loop ([num num]
	     [div 9])
    (if (zero? div)
      #t
      (let-values ([(n d) (quotient/remainder num 10)])
	(if (= d div)
	  (loop (quotient n 10) (sub1 div))
	  #f)))))

;(define (sqr x) (* x x))

(define (compute)
  ;(define low (integer-sqrt 10203040506070809))
  ;(define high (add1 (integer-sqrt 19293949596979899)))
  (define low 101010101)
  (define high 138902663)
  (let loop ([i low])
    (when (>= i high)
      (error "Not found"))
    (if (valid (sqr i))
      (* i 10)
      (loop (add1 i)))))

(display (compute))
(newline)
