;;; Problem 17
;;;
;;; 17 May 2002
;;;
;;; If the numbers 1 to 5 are written out in words: one, two, three, four,
;;; five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.
;;;
;;; If all the numbers from 1 to 1000 (one thousand) inclusive were written
;;; out in words, how many letters would be used?
;;;
;;; NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and
;;; forty-two) contains 23 letters and 115 (one hundred and fifteen) contains
;;; 20 letters. The use of "and" when writing out numbers is in compliance
;;; with British usage.
;;;
;;; 21124

(defpackage #:pr017
  (:use #:cl #:iterate)
  (:export #:euler-17))
(in-package #:pr017)

;;; format's ~r almost works, but doesn't actually specify the
;;; formatting and such.  Of my lisp implementations, clisp seems to
;;; be the only one that uses
(defparameter *need-and*
  (let ((text (format nil "~R" 342)))
    (cond ((string= text "three hundred forty-two") t)
	  ((string= text "three hundred and forty-two") nil)
	  (t (error "Unrecognized ~~R output ~S" text)))))

(defun needs-and (number)
  "Does NUMBER need an \"and\" inserted between the hundred and the
rest of the number?"
  (multiple-value-bind (upper lower)
      (truncate number 100)
    (and (plusp upper) (plusp lower))))

;;; Cheat a little here.  We're only counting letters, so just add the
;;; word and to the end.  It doesn't need to be inserted in the right
;;; place.
(defun safe-text (number)
  (let ((base (format nil "~R" number)))
    (if (needs-and number)
	(concatenate 'string base " and")
	base)))

(defun textual-length (number)
  (iter (for ch in-vector (string-upcase (safe-text number)))
	(counting (and (char>= ch #\A) (char<= ch #\Z)))))

(defun euler-17 ()
  (iter (for i from 1 to 1000)
	(sum (textual-length i))))
