;;; Problem 6
;;;
;;; 14 December 2001
;;;
;;; The sum of the squares of the first ten natural numbers is,
;;;
;;; 1^2 + 2^2 + ... + 10^2 = 385
;;;
;;; The square of the sum of the first ten natural numbers is,
;;;
;;; (1 + 2 + ... + 10)^2 = 55^2 = 3025
;;;
;;; Hence the difference between the sum of the squares of the first ten
;;; natural numbers and the square of the sum is 3025 − 385 = 2640.
;;;
;;; Find the difference between the sum of the squares of the first one
;;; hundred natural numbers and the square of the sum.
;;;
;;; 25164150

(import srfi-1)

(define (solve limit)
  (define (sqsum a b)
    (+ (* a a) b))
  (let* ((sums (fold + 0 (iota limit 1)))
	 (sums2 (* sums sums))
	 (squares (fold sqsum 0 (iota limit 1))))
    (- sums2 squares)))

(define (euler-6)
  (solve 100))

(display (euler-6))
(newline)
