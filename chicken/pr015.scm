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

(require-extension numbers)

(define (base n)
  (make-vector (add1 n) 1))

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
  (define item (base size))
  (do ((i 0 (add1 i)))
      ((= i size))
    (bump item))
  (vector-ref item size))

(display (euler-15))
(newline)
