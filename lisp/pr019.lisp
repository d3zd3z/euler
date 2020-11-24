;;; Problem 19
;;;
;;; 14 June 2002
;;;
;;; You are given the following information, but you may prefer to do some
;;; research for yourself.
;;;
;;;   • 1 Jan 1900 was a Monday.
;;;   • Thirty days has September,
;;;     April, June and November.
;;;     All the rest have thirty-one,
;;;     Saving February alone,
;;;     Which has twenty-eight, rain or shine.
;;;     And on leap years, twenty-nine.
;;;   • A leap year occurs on any year evenly divisible by 4, but not on a
;;;     century unless it is divisible by 400.
;;;
;;; How many Sundays fell on the first of the month during the twentieth
;;; century (1 Jan 1901 to 31 Dec 2000)?
;;;
;;; 171

(defpackage #:pr019
  (:use #:cl #:iterate #:simple-date)
  (:export #:euler-19))
(in-package #:pr019)

(defun sunday-months-in-year (year)
  (iter (for month from 1 to 12)
	(counting (= (day-of-week (encode-date year month 1))
		     0))))

(defun euler-19 ()
  (iter outer
	(for year from 1901 to 2000)
	(sum (sunday-months-in-year year))))

(euler/problem-set:register-problem 19 #'euler-19 171)
