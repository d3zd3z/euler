;;; A buildable prime-sieve, as described in
;;; http://programmingpraxis.com/2011/10/14/the-first-n-primes/

(defpackage #:euler.sieve
  (:use #:cl #:iterate #:euler.heap)
  (:export #:make-sieve #:sieve-next))
(in-package #:euler.sieve)

(defstruct node
  (next 0 :type integer)
  (steps '() :type list))

(defstruct sieve
  (prime 2 :type integer)
  (nodes (make-hash-table) :type hash-table)
  (heap (make-heap) :type vector))

(defmethod heap-less ((a node) (b node))
  (< (node-next a) (node-next b)))

(defun add-node (sieve next step)
  "Add a new step, possibly creating the node.  The node should not
already be present in the heap."
  (let ((node (gethash next (sieve-nodes sieve))))
    (unless node
      (setf node (make-node :next next))
      (setf (gethash next (sieve-nodes sieve)) node)
      (heap-push node (sieve-heap sieve)))
    (push step (node-steps node))))

(defun update-first (sieve)
  "Update the lowest keyed node in the heap."
  (let* ((head (heap-pop (sieve-heap sieve)))
	 (next (node-next head)))
    (remhash next (sieve-nodes sieve))
    ;; Spread out the steps to all appropriate nodes.
    (iter (for step in (node-steps head))
	  (add-node sieve (+ next step) step))))

(defun sieve-next (sieve)
  "Return the next prime from the SIEVE, modifying the sieve in
place."
  (case (sieve-prime sieve)
    (2 (setf (sieve-prime sieve) 3)
       2)
    (3 (setf (sieve-prime sieve) 5)
       (add-node sieve 9 6)
       3)
    (otherwise
     ;; Advance the prime number until done.
     (iter (for peek = (aref (sieve-heap sieve) 0))
	   (for cur = (sieve-prime sieve))

	   ;; If the 'next' divisor is greater than our current number, this is prime.
	   (when (< cur (node-next peek))
	     (setf (sieve-prime sieve) (+ cur 2))
	     (add-node sieve (* cur cur) (+ cur cur))
	     (return-from sieve-next cur))

	   ;; Otherwise it's is compositive, advance the next values, and move on.
	   (update-first sieve)
	   (incf (sieve-prime sieve) 2)))))

(defun play ()
  (iter (with p = (make-sieve))
	(for i from 1 to 12)
	(for n = (sieve-next p))
	(pprint n)
	(pprint p)
	(finally (return p))))

(defun lots (limit)
  (iter (with p = (make-sieve))
	(for n = (sieve-next p))
	(while (< n limit))
	(finally (return n))))
	