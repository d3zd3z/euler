#! /usr/local/bin/guile -s
!#

;;; Problem 15
;;;
;;; 19 April 2002
;;;
;;;
;;; Starting in the top left corner of a 2x2 grid, there are 6 routes (without
;;; backtracking) to the bottom right corner.
;;;
;;; [p_015]
;;;
;;; How many routes are there through a 20x20 grid?
;;;
;;; 137846528820

(define (make-base count)
  (make-vector (1+ count) 1))

(define (bump line)
  (define size (1- (vector-length line)))
  (do ((i 0 (1+ i)))
    ((= i size))
    (let ((i2 (1+ i)))
      (vector-set! line i2
		   (+ (vector-ref line i2)
		      (vector-ref line i))))))

(define (euler-15)
  (define size 20)
  (define base (make-base size))
  (do ((i 0 (1+ i)))
    ((= i size))
    (bump base))
  (vector-ref base size))

(define (main)
  (display (euler-15))
  (newline))
(main)
