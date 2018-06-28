;;; Some utilities

(library (util)
  (export
    add1 sub1 when htest)
  (import
    (rnrs base)
    (rnrs io simple)
    (only (chezscheme) printf current-time time-second))

  (define-syntax when
    (syntax-rules ()
      ((_ test) (if test (void)))
      ((_ test body ...)
       (if test (begin body ...)))))

  (define-syntax add1
    (syntax-rules ()
      ((_ x)
       (+ x 1))))

  (define-syntax sub1
    (syntax-rules ()
      ((_ x)
       (- x 1))))

  ;;; This isn't really that useful, since there's already one in gambit
  ;;; that shows useful stuff, but it's a good quick test to make sure
  ;;; that macros are actually hygeinic across modules.
  (define (time-thunk thunk)
    (let* ((before (time-second (current-time)))
	   (result (thunk))
	   (after (time-second (current-time))))
      (printf "~ss~%" (- after before))
      result))

  (define-syntax htest
    (syntax-rules ()
      ((_ body ...)
       (time-thunk (lambda () body ...)))))
)
