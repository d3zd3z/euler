#lang scheme
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; NOTE: This problem is a more challenging version of Problem 81.
;;; 
;;; The minimal path sum in the 5 by 5 matrix below, by starting in any
;;; cell in the left column and finishing in any cell in the right
;;; column, and only moving up, down, and right, is indicated in red and
;;; bold; the sum is equal to 994.
;;; 
;;;     131 673 234 103 18
;;; 
;;;     201 96  342 965 150
;;; 
;;;     630 803 746 422 111
;;; 
;;;     537 699 497 121 956
;;; 
;;;     805 732 524 37  331
;;; 
;;; 
;;; Find the minimal path sum, in matrix.txt (right click and 'Save Link/
;;; Target As...'), a 31K text file containing a 80 by 80 matrix, from
;;; the left column to the right column.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Given my generalized Dijkstra solver, this is just a matter of
;;; connecting the nodes differently.

(require srfi/26)
(require "dijkstra.ss")

;;; Needs to be larger than any possible sum.
(define max-sum (* 100 10000))

;;; Take a given column from a nested matrix.
(define (take-2d-column matrix col)
  (list->vector
    (for/list ([ind (in-range (vector-length matrix))])
      (vector-ref (vector-ref matrix ind) col))))

(define-syntax-rule (for/vector args ...)
  (list->vector (for/list args ...)))
(define (vector-for-each proc vec)
  (for ([i (in-range (vector-length vec))])
    (proc (vector-ref vec i))))

;;; Transpose a rectangular matrix.
(define (transpose matrix)
  (define height (vector-length matrix))
  (define width (vector-length (vector-ref matrix 0)))
  (for/vector ([y (in-range width)])
    (for/vector ([x (in-range height)])
      (vector-ref (vector-ref matrix x) y))))

;;; Given a column/row of nodes, connect them together
;;; bi-directionally within the column/row.  The input should be a
;;; single vector.
(define (connect-up-down nodes)
  (define count (vector-length nodes))
  (for ([pos (in-range count)])
    (define this-node (vector-ref nodes pos))
    (when (> pos 0)
      (add-node-neighbor! this-node (vector-ref nodes (sub1 pos))))
    (when (< pos (sub1 count))
      (add-node-neighbor! this-node (vector-ref nodes (add1 pos))))))

;;; Same, but only connect to the left.
(define (connect-left nodes)
  (define count (vector-length nodes))
  (for ([pos (in-range count)])
    (define this-node (vector-ref nodes pos))
    (when (> pos 0)
      (add-node-neighbor! this-node (vector-ref nodes (sub1 pos))))))

(define (read-nodes-as-matrix path)
  (let ([number-nodes (read-matrix path)])
    (list->vector
      (map (lambda (row)
	     (list->vector
	       (map (cut make-node <> max-sum 'never '()) row)))
	   number-nodes))))

;;; Read the table in, and build a list of lists of numbers.
(define (read-nodes)
  (define row-nodes (read-nodes-as-matrix "matrix.txt"))
  (define col-nodes (transpose row-nodes))
  ;;; Two 0-weight nodes to tie the paths together.
  (define leftmost-node (make-node 0 max-sum 'never '()))
  (define rightmost-node (make-node 0 max-sum 'never '()))
  (define hooked-row-nodes
    (vector-map (cut vector-append (vector leftmost-node)
		     <>
		     (vector rightmost-node))
		row-nodes))
  (vector-for-each connect-left hooked-row-nodes)
  (vector-for-each connect-up-down col-nodes)
  rightmost-node)

(define (read-nodes-83)
  (define row-nodes (read-nodes-as-matrix "matrix.txt"))
  (define col-nodes (transpose row-nodes))
  (define last-row (vector-ref row-nodes (sub1 (vector-length row-nodes))))
  (define last-node (vector-ref last-row (sub1 (vector-length last-row))))
  (vector-for-each connect-up-down row-nodes)
  (vector-for-each connect-up-down col-nodes)
  (set-node-neighbors! last-node '())
  (vector-ref (vector-ref row-nodes 0) 0))

(define (main)
  (define first-node (read-nodes))
  (display "Problem 82\n")
  (display (solve-dijkstra first-node))
  (newline))

(define (main-83)
  (define first-node (read-nodes-83))
  (display "Problem 83\n")
  (display (solve-dijkstra first-node))
  (newline))

(time (main))
(time (main-83))
