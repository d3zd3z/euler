;;; Problem 32
;;;
;;; 06 December 2002
;;;
;;;
;;; We shall say that an n-digit number is pandigital if it makes use of all
;;; the digits 1 to n exactly once; for example, the 5-digit number, 15234, is
;;; 1 through 5 pandigital.
;;;
;;; The product 7254 is unusual, as the identity, 39 x 186 = 7254, containing
;;; multiplicand, multiplier, and product is 1 through 9 pandigital.
;;;
;;; Find the sum of all products whose multiplicand/multiplier/product
;;; identity can be written as a 1 through 9 pandigital.
;;;
;;; HINT: Some products can be obtained in more than one way so be sure to
;;; only include it once in your sum.
;;;
;;; 45228

(import
  (rnrs base (6))
  (rnrs control (6))
  (rnrs lists (6))
  (rnrs io simple (6))
  (only (chezscheme) printf)
  (only (srfi :1 lists) delete-duplicates)
  (euler))

;;; Returns all groups (as a list) that can be built out of this group
;;; of digits.
(define (make-groupings digits)
  (define len (string-length digits))
  (define result '())
  (do ([i 1 (+ i 1)]) ([>= i (- len 2)])
    (do ([j (+ i 1) (+ j 1)]) ([>= j (- len 1)])
      (let ()
	(define (piece a b)
	  (string->number (substring digits a b)))
	(define a (piece 0 i))
	(define b (piece i j))
	(define c (piece j len))
	(when (= (* a b) c)
	  (set! result (cons c result))))))
  result)

(define (euler-32)
  (define products '())
  (define (add parts)
    (set! products (append (make-groupings parts) products)))
  (string-permutations add "123456789")
  (fold-left + 0 (delete-duplicates products)))

(define (main)
  (display (euler-32))
  (newline))
(main)
