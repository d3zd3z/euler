;;; Utilities shared among euler problems.

(defpackage #:euler
  (:use #:cl #:iterate)
  (:export #:sum-digits #:sum-digits-power #:factorial
	   #:reverse-number
           #:make-maximizer #:maximizer-update #:maximizer-value
           ))
(in-package #:euler)

(defun sum-digits (number)
  (iter (while (plusp number))
	(for (values num den) = (truncate number 10))
	(sum den)
	(setf number num)))

(defun sum-digits-power (number power)
  (iter (while (plusp number))
	(for (values num den) = (truncate number 10))
	(sum (expt den power))
	(setf number num)))

(defun factorial (n)
  (iter (for x from 1 to n)
	(multiply x)))

(defun reverse-number (number &optional (base 10))
  (iter (with result = 0)
	(with n = number)
	(while (plusp n))
	(for (values num den) = (truncate n base))
	(setf n num)
	(setf result (+ (* result base) den))
	(finally (return result))))

;;; A maximizer is useful for finding a maximum of one element with
;;; regards to another.  It can be useful with loop.
;;;
;;; (loop with m = (make-maximizer :min-value 0)
;;;       for elt in ...
;;;       do (maximize-update m (something elt) elt)
;;;       finally (return (maximizer-value m)))
;;;
;;; This will find the elt with the largest (something elt), but
;;; result in the elt itself.

(defun make-maximizer (&optional (min-value 0))
  "Construct a new maximizer (currently just a cons) with a given
   starting value."
  (cons min-value nil))

(defun maximizer-update (maxer index value)
  "Update the maximizer, replacing the current index/value pair with
   the given if the index is greater than the currently held index."
  (when (> index (car maxer))
    (setf (car maxer) index)
    (setf (cdr maxer) value)))

(declaim (inline maximizer-value))
(defun maximizer-value (maxer)
  (cdr maxer))
