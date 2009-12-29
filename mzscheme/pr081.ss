#lang scheme
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; In the 5 by 5 matrix below, the minimal path sum from the top left to
;;; the bottom right, by only moving to the right and down, is indicated
;;; in bold red and is equal to 2427.
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
;;; the top left to the bottom right by only moving right and down.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; This is just the shortest path search from the upper left to the
;;; lowest right.  A somewhat simplified version of Dijkstra's
;;; algorithm will find out solution.

(require "dijkstra.ss")

;;; Needs to be larger than any possible sum.
(define max-sum (* 100 10000))

;;; Read the table in, and build a list of lists of numbers.
(define (read-nodes)
  (define nested-nodes (read-matrix "matrix.txt"))
  (define prior (map (lambda (x) '()) (first nested-nodes)))
  (define last-node #f)
  (for ([row (in-list nested-nodes)])
    (let* ([left '()]
	   [new-prior
	     (for/list ([value (in-list row)])
	       (let ([node (make-node value max-sum 'never
				      (append left (first prior)))])
		 (set! prior (rest prior))
		 (set! left (list node))
		 (set! last-node node)
		 left))])
      (set! prior new-prior)))
  last-node)

(define (main)
  (define first-node (read-nodes))
  (display (solve-dijkstra first-node))
  (newline))

(time (main))
