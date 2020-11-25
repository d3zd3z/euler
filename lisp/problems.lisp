;;; Problem sets.

(defpackage #:euler/problem-set
  (:use #:cl #:cl-ppcre)
  (:export #:find-problems #:run-all #:run-multiple))

(in-package #:euler/problem-set)

(defvar *time-tests* nil)

(defstruct problem
  (number 1 :type integer :read-only t)
  (action nil :type function :read-only t)
  (answer nil :read-only t))

;;; Mapping between a problem number, and the problem struct that
;;; describes the problem.
(defvar *problems* (make-hash-table :test 'eql))

;; To make problem discovery a little easier, we search through all of
;; the packages that start with "PR", and then look for any exported
;; symbol that has an 'euler-answer property.  The value of that
;; property will be used as the answer to the problem.
(defun find-problems ()
  (let ((packages (loop with pkgre = (create-scanner "^PR(\\d{3})$")
                        for pkg in (list-all-packages)
                        for name = (package-name pkg)
                        for info = (register-groups-bind (num) (pkgre name)
                                     (cons pkg (parse-integer num)))
                        when info collect info into result
                        finally (return (sort result #'< :key #'cdr)))))
    (loop for (pkg . num) in packages
          do (loop for symb being each external-symbol of pkg
                        for answer = (get symb :euler-answer)
                        when answer
                        do (let ((problem (make-problem :number num
                                                        :action (symbol-function symb)
                                                        :answer answer)))
                             (setf (gethash num *problems*) problem))))))

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
