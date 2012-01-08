;;; A simple benchmark.

(defpackage #:bench
  (:use #:cl #:iterate))
(in-package #:bench)

(let ((fasls (iter (for src in '("heap.lisp" "sieve.lisp" "pr10.lisp"))
		   (format t "compiling ~S~%" src)
		   (for (values fasl warns errors) = (compile-file src :verbose nil))
		   (declare (ignorable warns))
		   (when errors
		     (error "Error compiling: ~s" src))
		   (collect fasl))))
  (iter (for fasl in fasls)
	(load fasl)
	(delete-file fasl)))

(format t "Benchmark of euler10 on ~S~%" (lisp-implementation-type))
(time (pr10:euler-10))
(time (pr10:euler-10))
(time (pr10:euler-10))
