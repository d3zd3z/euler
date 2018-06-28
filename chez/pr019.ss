;#!/usr/bin/env gsi

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

(import
  (rnrs base)
  (rnrs io simple)
  (srfi :19 time))

(define (sunday? year month)
  (= (date-week-day (make-date 0 0 0 0 1 month year 0)) 0))

(define (euler-19)
  (let outer ((year 1901)
              (count 0))
    (if (= year 2001)
        count
        (outer
         (+ year 1)
         (let inner ((month 1)
                     (count count))
           (if (= month 13)
               count
               (inner (+ month 1) (+ count (if (sunday? year month) 1 0)))))))))

(define (main . argv)
  (display (euler-19))
  (newline))

(main)
