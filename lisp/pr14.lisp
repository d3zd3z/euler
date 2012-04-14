;;; Problem 14
;;; 
;;; 05 April 2002
;;; 
;;; The following iterative sequence is defined for the set of positive
;;; integers:
;;; 
;;; n → n/2 (n is even)
;;; n → 3n + 1 (n is odd)
;;; 
;;; Using the rule above and starting with 13, we generate the following
;;; sequence:
;;; 
;;; 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
;;; 
;;; It can be seen that this sequence (starting at 13 and finishing at 1)
;;; contains 10 terms. Although it has not been proved yet (Collatz Problem),
;;; it is thought that all starting numbers finish at 1.
;;; 
;;; Which starting number, under one million, produces the longest chain?
;;; 
;;; NOTE: Once the chain starts the terms are allowed to go above one million.
;;; 

(defpackage #:pr14
  (:use #:cl #:iterate)
  (:export #:euler-14))
(in-package #:pr14)

(defun next-seq (n)
  "Return the next number in the 3n+1 problem."
  (if (oddp n)
      (1+ (* n 3))
      (/ n 2)))

;;; Cache the chain lengths for the smaller cases.  This maps between
;;; an index and a number, which is the chain length at that point.
;;; No entry means we haven't encountered it, yet.
(defparameter *chain-cache* (make-hash-table))

(defun reset-cache ()
  (setf *chain-cache* (make-hash-table)))

(defun chain-length (n)
  "How long is the Collatz chain from N."
  (when (> n 1000)
    ;; Don't cache large values.  The value itself is a tradeoff of space/time.
    ;; It's fastest to cache everything, though.
    (return-from chain-length (1+ (chain-length (next-seq n)))))
  (or (gethash n *chain-cache*)
      (let ((len (if (= n 1) 1
		     (1+ (chain-length (next-seq n))))))
	(setf (gethash n *chain-cache*) len))))

(defun euler-14 ()
  (iter (for i from 1 below 1000000)
	(finding i maximizing (chain-length i))))

;;; Try again with an array based cache.
(defvar *cache2*)
(defun reset-cache2 ()
  (setf *cache2* (make-array 1001 :initial-element 0 :element-type '(unsigned-byte 64))))
(reset-cache2)

(defun chain-length2 (n)
  "How long is the Collatz chain from N."
  (when (>= n (length *cache2*))
    ;; Don't cache large values.
    (return-from chain-length2 (1+ (chain-length2 (next-seq n)))))
  (let ((answer (aref *cache2* n)))
    (if (plusp answer)
	answer
	(let ((len (if (= n 1) 1
		       (1+ (chain-length2 (next-seq n))))))
	  (setf (aref *cache2* n) len)))))

(defun euler-14b ()
  (iter (for i from 1 below 1000000)
	(finding i maximizing (chain-length2 i))))
