;;; Problem 42
;;;
;;; 25 April 2003
;;;
;;; The n^th term of the sequence of triangle numbers is given by, t[n] = ½n(n
;;; +1); so the first ten triangle numbers are:
;;;
;;; 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
;;;
;;; By converting each letter in a word to a number corresponding to its
;;; alphabetical position and adding these values we form a word value. For
;;; example, the word value for SKY is 19 + 11 + 25 = 55 = t[10]. If the word
;;; value is a triangle number then we shall call the word a triangle word.
;;;
;;; Using words.txt (right click and 'Save Link/Target As...'), a 16K text
;;; file containing nearly two-thousand common English words, how many are
;;; triangle words?
;;;
;;; 162

(defpackage #:pr042
  (:use #:cl #:iterate #:split-sequence)
  (:export #:euler-42))
(in-package #:pr042)

(defun trianglep (number)
  "Is NUMBER a triangle number."
  (let* ((sqr (1+ (* number 8)))
	 (root (isqrt sqr)))
    (= (expt root 2) sqr)))

(defun word-value (word)
  (iter (for letter in-vector (string-upcase word))
	(for value = (- (char-code letter) 64))
	(sum value)))

;;; TODO: Use the proper load path to help find the words.
(defun get-words ()
  (let* ((line (with-open-file (stream "words.txt")
		 (read-line stream)))
	 (words (split-sequence #\, line))
	 (words (mapcar #'read-from-string words)))
    (mapcar #'word-value words)))

(defun euler-42 ()
  (iter (for n in (get-words))
	(counting (trianglep n))))
