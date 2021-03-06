;;; Problem 1
;;;
;;; 05 October 2001
;;;
;;; If we list all the natural numbers below 10 that are multiples of 3 or 5,
;;; we get 3, 5, 6 and 9. The sum of these multiples is 23.
;;;
;;; Find the sum of all the multiples of 3 or 5 below 1000.
;;;
;;; 233168

(module pr001
  (main main))

(define (divides? number div)
  (zero? (remainder number div)))

(define (mult? number)
  (or (divides? number 3)
      (divides? number 5)))

(define (add1 x) (+ x 1))

(define (euler-1)
  (let loop ((sum 0)
	     (number 1))
    (cond
      ((>= number 1000)
       sum)
      ((mult? number)
       (loop (+ sum number) (add1 number)))
      (else
	(loop sum (add1 number))))))

(define (main argv)
  (display (euler-1))
  (newline))
