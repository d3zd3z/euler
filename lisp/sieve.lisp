;;; A buildable prime-sieve, as described in
;;; http://programmingpraxis.com/2011/10/14/the-first-n-primes/

(defpackage #:euler.sieve
  (:use #:cl #:iterate #:euler.heap #:alexandria)
  (:export #:make-sieve #:sieve-next #:nth-prime #:factorize
	   #:primes-upto #:primes-from-to #:primep
	   #:reset-prime-sieve #:divisors))
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

;;; A cached version of the sieve.  Keeps a single sieve state, and
;;; fills in the array as values are requested.
(defvar *prime-sieve*)
(defvar *primes*)

(defun reset-prime-sieve ()
  (setf *prime-sieve* (make-sieve)
	*primes* (make-array 0 :fill-pointer t :adjustable t)))

(reset-prime-sieve)

(defun nth-prime (n)
  "Return the Nth prime number, counting 2 as prime zero."
  (iter (while (<= (length *primes*) n))
	(vector-push-extend (sieve-next *prime-sieve*) *primes*))
  (aref *primes* n))

;; Iterative to avoid problems with TCO going away for debugging.
(defun binary-search (seq value &optional (low 0) (high (1- (length seq))))
  (iter (when (< high low)
	  (return nil))
	(let* ((middle (floor (+ low high) 2))
	       (middle-elt (aref seq middle)))
	  (cond ((> middle-elt value)
		 (setf high (1- middle)))
		((< middle-elt value)
		 (setf low (1+ middle)))
		(t (return middle))))))

(defun enough-primes (n)
  "Make sure there is a prime that is >= N in *primes*."
  (iter (while (or (emptyp *primes*)
		   (> n (last-elt *primes*))))
	(vector-push-extend (sieve-next *prime-sieve*) *primes*)))

(defun primep (n)
  "Returns a true value if N is prime (actual value is the index of
this prime number, with 2 being zero."
  (enough-primes n)
  (binary-search *primes* n))

(defun primes-upto (n)
  "Return the primes not greater than N."
  (iter (with sieve = (make-sieve))
	(for p = (sieve-next sieve))
	(while (<= p n))
	(collect p)))

(defun primes-from-to (a b)
  "Returns primes >= B and <= B"
  (iter (with sieve = (make-sieve))
	(for p = (sieve-next sieve))
	(while (<= p b))
	(when (>= p a)
	  (collect p))))

(defun divides-out (n factor)
  "Compute how many times FACTOR divides into N.  Returns two values,
the count, and the result of (/ factor (expt N count))"
  (iter (for (values num den) = (truncate n factor))
	(while (zerop den))
	(setf n num)
	(counting t into count)
	(finally (return (values count n)))))

(defun factorize (n)
  "Compute the prime factors of N, along with their powers.  Returns a
list of pairs, with the car as the prime factor, and the cdr as the
power."
  (iter (while (> n 1))
	(for i from 0)
	(for p = (nth-prime i))
	(for (values power next-n) = (divides-out n p))
	(when (plusp power)
	  (collect (cons p power))
	  (setf n next-n))))

(defun spread (factors)
  (unless factors
    (return-from spread '(1)))
  (iter outer
	(with (p . count) = (first factors))
	(for res in (spread (rest factors)))
	(iter (for x from 0 to count)
	      (in outer (collect (* res (expt p x)))))))

(defun divisors (n)
  "Return the divisors of N."
  (spread (factorize n)))
