;;; Some utilities.

(module utilities
  (export (syntax add1)
	  (syntax sub1)
	  (syntax mytime)
	  %%time-help))

(define-syntax add1
  (syntax-rules ()
    ((_ x) (+ x 1))))
(define-syntax sub1
  (syntax-rules ()
    ((_ x) (- x 1))))

;;; Evaluate and print the time.
;;; Unfortunately, this appears to not be hygienic.

(define (%%time-help thunk)
  (multiple-value-bind (res rtime stime utime)
    (time thunk)
    (print "real: " rtime " sys: " stime " user: " utime)
    res))
(define-syntax mytime
  (syntax-rules ()
    ((_ action) (%%time-help (lambda () action)))))
