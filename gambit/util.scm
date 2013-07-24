(export add1 sub1 when htest)

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
  (let* ((before (time->seconds (current-time)))
         (result (thunk))
         (after (time->seconds (current-time))))
    (print (- after before) "s")
    (newline)
    result))

(define-syntax htest
  (syntax-rules ()
    ((_ body ...)
     (time-thunk (lambda () body ...)))))
