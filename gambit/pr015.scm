;;; Problem 15
;;;
;;; 19 April 2002
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
  (make-vector (+ count 1) 1))

(define (bump line)
  (define size (- (vector-length line) 1))
  (do ((i 0 (+ i 1)))
    ((= i size))
    (let ((i2 (+ i 1)))
      (vector-set! line i2
                   (+ (vector-ref line i2)
                      (vector-ref line i))))))

(define (euler-15)
  (define size 20)
  (define base (make-base size))
  (do ((i 0 (+ i 1)))
    ((= i size))
    (bump base))
  base
  (vector-ref base size))

(display (euler-15))
(newline)
