;;; A priority queue based on a heap.

;;; Tacky
;;; (ql:quickload '#:alexandria)

(defpackage #:euler.heap
  (:use #:cl #:iterate)
  (:export #:heap-less #:heap-pop #:heap-push #:make-heap #:heapify))
(in-package #:euler.heap)

;;; Heap-oriented priority queue.

(defgeneric heap-less (a b)
  (:documentation
   "Compare two elements in a heap.  Returns T if A<B as defined for
   this particular heap type."))

(defmethod heap-less ((a real) (b real))
  (< a b))

(defun swap (heap i j)
  (rotatef (aref heap i) (aref heap j)))

(defun down (heap i n)
  "Given a HEAP size N, move the Ith node down appropriately"
  (iter (for j1 = (1+ (* i 2)))
	(until (>= j1 n))
	(for j2 = (1+ j1)) ; Right child
	(for j = (if (and (< j2 n) (not (heap-less (aref heap j1) (aref heap j2))))
		     j2 j1))
	(until (heap-less (aref heap i) (aref heap j)))
	(swap heap i j)
	(setf i j)))

(defun up (heap j)
  "Move element J upward in HEAP to the appropriate place."
  (iter (for i = (truncate (1- j) 2))
	(until (or (= i j) (heap-less (aref heap i) (aref heap j))))
	(swap heap i j)
	(setf j i)))

(defun heapify (heap)
  "Adjust the vector to make it a heap"
  (iter (with n = (length heap))
	(for i from (1- (truncate n 2)) downto 0)
	(down heap i n)))

(defun heap-pop (heap)
  (let ((n (1- (length heap))))
    (swap heap 0 n)
    (down heap 0 n)
    (vector-pop heap)))

(defun heap-push (elt heap)
  (up heap (vector-push-extend elt heap)))

(defun make-heap (&optional initial-contents)
  (let ((heap (make-array (length initial-contents)
			  :fill-pointer t
			  :adjustable t
			  :initial-contents initial-contents)))
    (heapify heap)
    heap))

(defun make-random-vector (size)
  (iter (for i from 1 to size)
	(collect i into result result-type 'vector)
	(finally (alexandria:shuffle result)
		 (return result))))

(defun make-random-heap1 (size)
  (iter (with heap = (make-heap))
	(for i in-vector (make-random-vector size))
	(heap-push i heap)
	(finally (return heap))))

(defun make-random-heap2 (size)
  (make-heap (make-random-vector size)))

(defun test-heap (size)
  (let* ((heap (if (zerop (random 2))
		   (make-random-heap1 size)
		   (make-random-heap2 size)))
	 (outputs (iter (while (plusp (length heap)))
			(collect (heap-pop heap)))))
    (iter (for i from 1 to size)
	  (for x in outputs)
	  (unless (= i x)
	    (return-from test-heap 'failure)))
    'success))

(defun test-heap-many (size count)
  (iter (for counter from 1 to count)
	(counting (eq (test-heap size) 'success) into successes)
	(finally (return (list :successes successes :failures (- count successes))))))
