;;; Problem 31
;;;
;;; 22 November 2002
;;;
;;; In England the currency is made up of pound, £, and pence, p, and there
;;; are eight coins in general circulation:
;;;
;;;     1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).
;;;
;;; It is possible to make £2 in the following way:
;;;
;;;     1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p
;;;
;;; How many different ways can £2 be made using any number of coins?
;;;
;;; 73682

(defpackage #:pr031
  (:use #:cl #:iterate)
  (:export #:euler-31))
(in-package #:pr031)

(defparameter *coins* '(200 100 50 20 10 5 2 1)
  "The coins available.")

(defvar *count* 0)

;;; This isn't particularly efficient, but this problem is small
;;; enough that it doesn't really matter.
(defun ways (remaining coins)
  (unless coins
    (when (zerop remaining)
      (incf *count*))
    (return-from ways))
  (let ((coin (first coins))
	(other-coins (rest coins)))
    (iter (for r from remaining downto 0 by coin)
	  (ways r other-coins))))

;;; Lets rewrite this without the global state.  Note that this is
;;; actually a bit slower, but now has the possibility of being
;;; memoized.
(defun rways (remaining coins)
  (if (null coins)
      (if (zerop remaining) 1 0)
      (let ((coin (first coins))
            (other-coins (rest coins)))
        (loop for r from remaining downto 0 by coin
              sum (rways r other-coins)))))

(defvar *coin-cache* (make-hash-table :test 'equal)
  "A cache of answers to memways.  The keys are the cons of the
arguments to memways, and the values are the result of the
function.")

(defun memways (remaining coins)
  (if (null coins)
      (if (zerop remaining) 1 0)
      (let ((key (cons remaining (car coins))))
	(multiple-value-bind (answer ok) (gethash key *coin-cache*)
	  (if ok answer
	      (let ((answer (let ((coin (first coins))
				  (other-coins (rest coins)))
                              (loop for r from remaining downto 0 by coin
                                    sum (memways r other-coins)))))
		(setf (gethash key *coin-cache*)
		      answer)
		answer))))))

(defun euler-31a (&optional (limit 200))
  (let ((*count* 0))
    (ways limit *coins*)
    *count*))

(defun euler-31b (&optional (limit 200))
  (rways limit *coins*))

(defun euler-31 (&optional (limit 200))
  (let ((*coin-cache* (make-hash-table :test 'equal)))
    (memways limit *coins*)))

(euler/problem-set:register-problem 31 #'euler-31 73682)
