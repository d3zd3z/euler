#lang scheme

;;; Dikstra's shortest path code, common amongst problems 81-83.

;;; The visited states of the node are:
;;;   'never - Not yet seen.
;;;   'seen - Seen and inserted into the queue.
;;;   'done - Fully computed.
(provide read-matrix
	 (struct-out node)
	 add-node-neighbor!
	 show-node
	 solve-dijkstra)

;;; Read in the matrix table into a list of lists.
(define (read-matrix path)
  (define (read-it inp)
    (for/list ([line (in-lines inp)])
      (map string->number (regexp-split #rx"," line))))
  (call-with-input-file* path read-it))

(define-struct node
  (value
    (sum #:mutable)
    (visited #:mutable)
    (neighbors #:mutable)))
(define (show-node node)
  (printf "Visiting ~s, sum ~s neigh:" (node-value node) (node-sum node))
  (for ([i (in-list (node-neighbors node))])
    (printf " ~a" (node-value i)))
  (newline))

(define (add-node-neighbor! node neighbor)
  (set-node-neighbors! node (cons neighbor (node-neighbors node))))

;;; Needs to be larger than any possible sum.
(define max-sum (* 100 10000))

(define (solve-dijkstra first-node)

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
	  (unless (eq? (node-visited child) 'done)
	    (let ([sum (+ my-sum (node-value child))])
	      (when (< sum (node-sum child))
		(set-node-sum! child sum)))
	    (add-to-work child)))
	(set-node-visited! node 'done)
	(dijkstra)]))

  ;; Make sure the first node has a proper sum, insert it, and run
  ;; with it.
  (set-node-sum! first-node (node-value first-node))
  (insert-work first-node)
  (dijkstra))
