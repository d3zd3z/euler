;;; This is a more conventional sieve.

(defpackage #:euler.big-sieve
  (:use #:cl #:iterate)
  (:export #:make-sieve #:primep #:next-prime))
(in-package #:euler.big-sieve)

(defun advance (n)
  (if (= n 2) 3 (+ n 2)))

(defun fill-sieve (size)
  (let ((buf (make-array size :element-type 'bit :initial-element 1)))
    (setf (aref buf 0) 0)
    (setf (aref buf 1) 0)
    (iter (for pos first 2 then (advance pos))
	  (while (< pos size))
	  (when (plusp (aref buf pos))
	    (iter (for n first (+ pos pos) then (+ n pos))
		  (while (< n size))
		  (setf (aref buf n) 0)))
	  (finally (return buf)))))

(defstruct sieve
  (size 1024 :type integer)
  (data (fill-sieve 1024) :type (bit-vector *)))

(defun better-size (existing needed)
  "Given an existing size, and a required limit 'n', return a new size
  that is better."
  (iter (for new first existing then (* new 8))
	(until (> new needed))
	(finally (return new))))

(defun primep (s n)
  (let ((current-size (sieve-size s)))
    (when (>= n current-size)
      (let ((new-size (better-size current-size n)))
	(setf (sieve-size s) new-size)
	(setf (sieve-data s) (fill-sieve new-size))))
    (plusp (aref (sieve-data s) n))))

(defun next-prime (s n)
  "Return the next number after 'n' that is prime."
  (iter (for n2 first (advance n) then (advance n2))
	(when (primep s n2)
	  (return n2))))
