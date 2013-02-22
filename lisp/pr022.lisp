;;; Problem 22
;;;
;;; 19 July 2002
;;;
;;; Using names.txt (right click and 'Save Link/Target As...'), a 46K text
;;; file containing over five-thousand first names, begin by sorting it into
;;; alphabetical order. Then working out the alphabetical value for each name,
;;; multiply this value by its alphabetical position in the list to obtain a
;;; name score.
;;;
;;; For example, when the list is sorted into alphabetical order, COLIN, which
;;; is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So,
;;; COLIN would obtain a score of 938 × 53 = 49714.
;;;
;;; What is the total of all the name scores in the file?
;;;
;;; 871198282

(defpackage #:pr022
  (:use #:cl #:iterate #:split-sequence)
  (:export #:euler-22))
(in-package #:pr022)

(defun get-words ()
  (let* ((text (with-open-file (file "names.txt")
		 (read-line file)))
	 (quoted-words (split-sequence #\, text)))
    (mapcar #'read-from-string quoted-words)))

(defun word-value (word)
  (iter (for ch in-vector (string-upcase word))
	(sum (1+ (- (char-code ch) (char-code #\A))))))

(defun euler-22 ()
  (iter (for word in (sort (get-words) #'string<))
	(for index from 1)
	(sum (* index (word-value word)))))
