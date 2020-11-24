;;; Load things.

;; TODO: Don't push if it is already there
(push *default-pathname-defaults* asdf:*central-registry*)

(setf asdf:*asdf-verbose* t)
(asdf:load-system "euler")
