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

;;; The visited states of the node are:
;;;   'never - Not yet seen.
;;;   'seen - Seen and inserted into the queue.
;;;   'done - Fully computed.
(define-struct node
  (value
    (sum #:mutable)
    (visited #:mutable)
    neighbors))
(define (show-node node)
  (printf "Visiting ~s, sum ~s~%" (node-value node) (node-sum node)))

;;; Needs to be larger than any possible sum.
(define max-sum (* 100 10000))

;;; Read the table in, and build a list of lists of numbers.
(define (read-nodes)
  (define (read-it inp)
    (for/list ([line (in-lines inp)])
      (map string->number (regexp-split #rx"," line))))
  (define nested-nodes
    (call-with-input-file* "matrix.txt" read-it))
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

;;; The work queue is an unsorted list of nodes.
(define work-queue '())

(define (insert-work node)
  (set! work-queue (cons node work-queue)))

;;; Remove the node with the smallest value from the queue.
(define (take-smallest-work)
  (define min-node (argmin node-sum work-queue))
  (set! work-queue (remq min-node work-queue))
  min-node)

;;; Add a node to the work queue, if not already present.  Update the
;;; visited state to indicate that status.
(define (add-to-work node)
  (when (eq? (node-visited node) 'never)
    (set-node-visited! node 'seen)
    (insert-work node)))

(define (dijkstra)
  (define node (take-smallest-work))
  (define my-sum (node-sum node))
  (match (node-neighbors node)
    ['()  ;; No neighbors, this is our answer.
     my-sum]
    [items
      (for ([child items])
	(when (eq? (node-visited child) 'done)
	  (error "Cycle detected"))
	(let ([sum (+ my-sum (node-value child))])
	  (when (< sum (node-sum child))
	    (set-node-sum! child sum)))
	(add-to-work child))
      (dijkstra)]))

(define (main)
  (define first-node (read-nodes))
  (set-node-sum! first-node (node-value first-node))
  (insert-work first-node)
  (display (dijkstra))
  (newline))

(main)
