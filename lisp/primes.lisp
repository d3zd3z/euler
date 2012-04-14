;;; Miller-Rabin primality testing.

(defpackage #:mr-prime
  (:use #:cl #:iterate)
  (:export #:miller-rabin #:mr-prime-p))
(in-package #:mr-prime)

;; TODO: Declarations so the compilers know this requires integers.
(defun exp-mod (base power modulus)
  "Compute (mod (expt base power) modulus) but more efficiently."
  (iter (with size = (integer-length power))
	(with result = 1)
	(with b = base)
	(for index from 0 below size)
	(when (logbitp index power)
	  (setf result (mod (* result b) modulus)))
	(setf b (mod (* b b) modulus))
	(finally (return result))))

(defun compute-s-d (n)
  (iter (for s first 0 then (1+ s))
	(for d first (1- n) then (ash d -1))
	(when (logbitp 0 d)
	  (return (values s d)))))

(defun mr-round (n s d)
  "Compute one round of Miller-Rabin. Returns T if this number might
  be prime, or NIL if it is definitely not."
  (let* ((a (+ 2 (random (- n 3))))
	 (x (exp-mod a d n)))
    (when (or (= x 1) (= x (1- n)))
      (return-from mr-round t))
    (iter (repeat (1- s))
	  (setf x (mod (* x x) n))
	  (when (= x 1)
	    (return-from mr-round nil))
	  (when (= x (1- n))
	    (return-from mr-round t)))
    nil))

(defun miller-rabin (n &optional (k 20))
  "Determine is N is probably prime  Probability will be (1/4)^K."
  (multiple-value-bind (s d) (compute-s-d n)
    (iter (repeat k)
	  (unless (mr-round n s d)
	    (return nil))
	  (finally (return t)))))

(defun mr-prime-p (n)
  (cond ((= n 2) t)
	((= n 3) t)
	((= n 5) t)
	((= n 7) t)
	((zerop (mod n 2)) nil)
	((zerop (mod n 3)) nil)
	((zerop (mod n 5)) nil)
	((zerop (mod n 7)) nil)
	(t (miller-rabin n))))
