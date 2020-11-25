;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Problem 8
;;
;; 11 January 2002
;;
;; Find the greatest product of five consecutive digits in the
;; 1000-digit number.
;;
;; 73167176531330624919225119674426574742355349194934
;; 96983520312774506326239578318016984801869478851843
;; 85861560789112949495459501737958331952853208805511
;; 12540698747158523863050715693290963295227443043557
;; 66896648950445244523161731856403098711121722383113
;; 62229893423380308135336276614282806444486645238749
;; 30358907296290491560440772390713810515859307960866
;; 70172427121883998797908792274921901699720888093776
;; 65727333001053367881220235421809751254540594752243
;; 52584907711670556013604839586446706324415722155397
;; 53697817977846174064955149290862569321978468622482
;; 83972241375657056057490261407972968652414535100474
;; 82166370484403199890008895243450658541227588666881
;; 16427171479924442928230863465674813919123162824586
;; 17866458359124566529476545682848912883142607690042
;; 24219022671055626321111109370544217506941658960408
;; 07198403850962455444362981230987879927244284909188
;; 84580156166097919133875499200524063689912560717606
;; 05886116467109405077541002256983155200055935729725
;; 71636269561882670428252483600823257530420752963450
;;
;; 40824
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defpackage #:pr008
  (:use #:cl #:iterate)
  (:export #:euler-8))
(in-package #:pr008)

;;; There are two ways we can solve this.  First, we will treat the
;;; number as a large string, and break it into nice chunks.
(defvar +number+
  (concatenate 'string
	       "73167176531330624919225119674426574742355349194934"
	       "96983520312774506326239578318016984801869478851843"
	       "85861560789112949495459501737958331952853208805511"
	       "12540698747158523863050715693290963295227443043557"
	       "66896648950445244523161731856403098711121722383113"
	       "62229893423380308135336276614282806444486645238749"
	       "30358907296290491560440772390713810515859307960866"
	       "70172427121883998797908792274921901699720888093776"
	       "65727333001053367881220235421809751254540594752243"
	       "52584907711670556013604839586446706324415722155397"
	       "53697817977846174064955149290862569321978468622482"
	       "83972241375657056057490261407972968652414535100474"
	       "82166370484403199890008895243450658541227588666881"
	       "16427171479924442928230863465674813919123162824586"
	       "17866458359124566529476545682848912883142607690042"
	       "24219022671055626321111109370544217506941658960408"
	       "07198403850962455444362981230987879927244284909188"
	       "84580156166097919133875499200524063689912560717606"
	       "05886116467109405077541002256983155200055935729725"
	       "71636269561882670428252483600823257530420752963450"))

(defun multiply-digits (number)
  "Multiple the digits of the string NUMBER, returning their product."
  (loop with total = 1
        for ch across number
        do (setf total (* total (- (char-code ch) (char-code #\0))))
        finally (return total)))

(defun euler-8a ()
  (loop with stop = (length +number+)
        for a from 0
        for b = (+ a 5)
        until (> b stop)
        maximize (multiply-digits (subseq +number+ a b))))

;;; Now do using bignums.  This is probably a lot slower.

(defun digit-product (number digits)
  "Multiple the digits of NUMBER, assuming there are DIGITS digits."
  (loop with total = 1
        repeat digits
        for (num den) = (multiple-value-list (truncate number 10))
        do (setf total (* total den))
        do (setf number num)
        finally (return total)))

(defun euler-8b ()
  (loop repeat (- (length +number+) 5)
        for number = (parse-integer +number+) then (truncate number 10)
        maximize (digit-product (mod number 100000) 5)))

(defun euler-8 ()
  (values (euler-8a) (euler-8b)))
(setf (get 'euler-8 :euler-answer) 40824)
