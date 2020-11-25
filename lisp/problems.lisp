;;; Problem sets.

(defpackage #:euler/problem-set
  (:use #:cl)
  (:export #:register-problem #:run-all #:run-multiple))

(in-package #:euler/problem-set)

(defvar *time-tests* nil)

(defstruct problem
  (number 1 :type integer :read-only t)
  (action nil :type function :read-only t)
  (answer nil :read-only t))

;;; Mapping between a problem number, and the problem struct that
;;; describes the problem.
(defvar *problems* (make-hash-table :test 'eql))

(defun register-problem (number action answer)
  (let ((prob (make-problem :number number :action action :answer answer)))
    (setf (gethash number *problems*) prob)))

(defun run-single (problem)
  (format t "~&~a: " (problem-number problem))
  (let* ((result (if *time-tests*
                    (time (funcall (problem-action problem)))
                    (funcall (problem-action problem))))
         (answer (problem-answer problem))
         (correct? (equalp result answer)))
    (format t "~a ~a~%" result
            (if correct? "✓"
                (format nil "✗ (expect ~a)" answer)))))

(defun run-all ()
  (let* ((keys (loop for key being each hash-keys of *problems*
                     collect key))
         (skeys (sort keys #'<)))
    (loop for key in skeys
          do (run-single (gethash key *problems*)))))

(defun run-multiple (nums)
  (loop for num in nums
        do (run-single (gethash num *problems*))))
