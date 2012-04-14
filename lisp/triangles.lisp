;;; Machinations on triangles.

(defpackage #:euler.triangles
  (:use #:cl #:iterate)
  (:export #:generate-triples))
(in-package #:euler.triangles)

(defstruct box
  "A single fibonacci box, using p1 p2 instead of p and p' to get
usable names."
  p1 p2 q1 q2)

(defparameter *start-box*
  (make-box :p1 1 :p2 1 :q1 2 :q2 3))

;;; Each box has three children.
(defun children (box)
  "Return the three children of this as a fresh list."
  (let ((x (box-p2 box))
	(y (box-q2 box)))
    (list (make-box :p1 (- y x)
		    :p2 x
		    :q1 y
		    :q2 (- (* y 2) x))
	  (make-box :p1 x
		    :p2 y
		    :q1 (+ x y)
		    :q2 (+ (* x 2) y))
	  (make-box :p1 y
		    :p2 x
		    :q1 (+ y x)
		    :q2 (+ (* y 2) x)))))

(defstruct triple a b c)

(defun box-triangle (box)
  "Return the three sides of the pythagorean triple described by the
given box."
  (with-accessors ((p1 box-p1)
		   (p2 box-p2)
		   (q1 box-q1)
		   (q2 box-q2))
      box
    (make-triple :a (* 2 q1 p1)
		 :b (* q2 p2)
		 :c (+ (* p1 q2) (* p2 q1)))))

(defun circumference (triangle)
  (+ (triple-a triangle)
     (triple-b triangle)
     (triple-c triangle)))

(defun multiply-triple (triple k)
  "Multiple each of the sides of this tringle by K."
  (make-triple :a (* k (triple-a triple))
	       :b (* k (triple-b triple))
	       :c (* k (triple-c triple))))

(defun fibonacci-generate-triples (limit act)
  "Generate all of the primitive Pythagorean triples with a
circumference <= limit.  Calls (ACT triple circumference) for each
possible triple."
  (let ((work (list *start-box*)))
    (iter (while (consp work))
	  (let* ((box (pop work))
		 (triple (box-triangle box))
		 (size (circumference triple)))
	    (when (<= size limit)
	      (iter (for child in (children box))
		    (push child work))
	      (funcall act triple size))))))

(defun generate-triples (limit act)
  (flet ((sub-generate (triple size)
	   (declare (ignore size))
	   (iter (for k from 1)
		 (for k-triple = (multiply-triple triple k))
		 (for k-size = (circumference k-triple))
		 (while (<= k-size limit))
		 (funcall act k-triple k-size))))
    (fibonacci-generate-triples limit #'sub-generate)))

