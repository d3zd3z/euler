;;; Problem 20
;;;
;;; 21 June 2002
;;;
;;; n! means n x (n − 1) x ... x 3 x 2 x 1
;;;
;;; For example, 10! = 10 x 9 x ... x 3 x 2 x 1 = 3628800,
;;; and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 =
;;; 27.
;;;
;;; Find the sum of the digits in the number 100!
;;;
;;; 648

#!r6rs
(import
  (rnrs base)
  (rnrs io simple))

(define (fact n)
  (let loop ((n n)
             (result 1))
    (if (zero? n) result
        (loop (- n 1)
              (* result n)))))

(define (digit-sum n)
  (let loop ((n n)
             (sum 0))
    (if (zero? n) sum
        (loop (div n 10)
              (+ sum (mod n 10))))))

(define (euler-20)
  (digit-sum (fact 100)))

(define (main . argv)
  (display (euler-20))
  (newline))

(main)
