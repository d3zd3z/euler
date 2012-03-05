#lang racket

;;; Problem 18
;;;
;;; 31 May 2002
;;;
;;; By starting at the top of the triangle below and moving to adjacent
;;; numbers on the row below, the maximum total from top to bottom is 23.
;;;
;;; 3
;;; 7 4
;;; 2 4 6
;;; 8 5 9 3
;;;
;;; That is, 3 + 7 + 4 + 9 = 23.
;;;
;;; Find the maximum total from top to bottom of the triangle below:
;;;
;;; 75
;;; 95 64
;;; 17 47 82
;;; 18 35 87 10
;;; 20 04 82 47 65
;;; 19 01 23 75 03 34
;;; 88 02 77 73 07 63 67
;;; 99 65 04 28 06 16 70 92
;;; 41 41 26 56 83 40 80 70 33
;;; 41 48 72 33 47 32 37 16 94 29
;;; 53 71 44 65 25 43 91 52 97 51 14
;;; 70 11 33 28 77 73 17 78 39 68 17 57
;;; 91 71 52 38 17 14 91 43 58 50 27 29 48
;;; 63 66 04 68 89 53 67 30 73 16 69 87 40 31
;;; 04 62 98 27 23 09 70 98 73 93 38 53 60 04 23
;;;
;;; NOTE: As there are only 16384 routes, it is possible to solve this problem
;;; by trying every route. However, Problem 67, is the same challenge with a
;;; triangle containing one-hundred rows; it cannot be solved by brute force,
;;; and requires a clever method! ;o)

(define triangle
  '((75)
    (95 64)
    (17 47 82)
    (18 35 87 10)
    (20 04 82 47 65)
    (19 01 23 75 03 34)
    (88 02 77 73 07 63 67)
    (99 65 04 28 06 16 70 92)
    (41 41 26 56 83 40 80 70 33)
    (41 48 72 33 47 32 37 16 94 29)
    (53 71 44 65 25 43 91 52 97 51 14)
    (70 11 33 28 77 73 17 78 39 68 17 57)
    (91 71 52 38 17 14 91 43 58 50 27 29 48)
    (63 66 04 68 89 53 67 30 73 16 69 87 40 31)
    (04 62 98 27 23 09 70 98 73 93 38 53 60 04 23)))

(define aa (list->vector (last triangle)))
(define bb (list->vector (second (reverse triangle))))

;;; Fold two rows.  A needs to have one more element than B.
(define (fold-row a b)
  (build-vector (vector-length b)
                (lambda (i)
                  (define elt (vector-ref b i))
                  (max (+ elt (vector-ref a i))
                       (+ elt (vector-ref a (add1 i)))))))

(define (reduce-table table)
  (match table
    [(list a b xs ...) (reduce-table (cons (fold-row a b) xs))]
    [(list one) (vector-ref one 0)]
    [_ (error "Invalid argument")]))

(define (euler-18)
  (reduce-table (map list->vector (reverse triangle))))

;;; Problem 67 here, since the reduction is the same.
(define (read-triangle path)
  (call-with-input-file* path
    (lambda (port)
      (for/list ([line (in-port read-line port)])
        (list->vector
         (map string->number
              (regexp-match* #px"\\d+" line)))))))
                         
(define (euler-67)
  (define triangle (read-triangle "../haskell/triangle.txt"))
  (reduce-table (reverse triangle)))
