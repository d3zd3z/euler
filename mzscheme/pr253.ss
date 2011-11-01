#lang scheme
#|
 | 28 August 2009
 | 
 | A small child has a “number caterpillar” consisting of forty jigsaw
 | pieces, each with one number on it, which, when connected together in a
 | line, reveal the numbers 1 to 40 in order.
 | 
 | Every night, the child's father has to pick up the pieces of the
 | caterpillar that have been scattered across the play room. He picks up the
 | pieces at random and places them in the correct order.
 | As the caterpillar is built up in this way, it forms distinct segments
 | that gradually merge together.
 | The number of segments starts at zero (no pieces placed), generally
 | increases up to about eleven or twelve, then tends to drop again before
 | finishing at a single segment (all pieces placed).
 | 
 | For example:
 | 
 |                       ┌─────────────┬──────────────┐
 |                       │    Piece    │ Segments So  │
 |                       │   Placed    │     Far      │
 |                       ├─────────────┼──────────────┤
 |                       │     12      │      1       │
 |                       ├─────────────┼──────────────┤
 |                       │      4      │      2       │
 |                       ├─────────────┼──────────────┤
 |                       │     29      │      3       │
 |                       ├─────────────┼──────────────┤
 |                       │      6      │      4       │
 |                       ├─────────────┼──────────────┤
 |                       │     34      │      5       │
 |                       ├─────────────┼──────────────┤
 |                       │      5      │      4       │
 |                       ├─────────────┼──────────────┤
 |                       │     35      │      4       │
 |                       ├─────────────┼──────────────┤
 |                       │      …      │      …       │
 |                       └─────────────┴──────────────┘
 | 
 | Let M be the maximum number of segments encountered during a random
 | tidy-up of the caterpillar.
 | For a caterpillar of ten pieces, the number of possibilities for each M is
 | 
 |                        ┌─────────┬────────────────┐
 |                        │    M    │ Possibilities  │
 |                        ├─────────┼────────────────┤
 |                        │    1    │      512       │
 |                        ├─────────┼────────────────┤
 |                        │    2    │   250912       │
 |                        ├─────────┼────────────────┤
 |                        │    3    │  1815264       │
 |                        ├─────────┼────────────────┤
 |                        │    4    │  1418112       │
 |                        ├─────────┼────────────────┤
 |                        │    5    │   144000       │
 |                        └─────────┴────────────────┘
 | 
 | so the most likely value of M is 3 and the average value is ^(^385643)⁄_(
 | [113400]) = 3.400732, rounded to six decimal places.
 | 
 | The most likely value of M for a forty-piece caterpillar is 11; but what
 | is the average value of M?
 | 
 | Give your answer rounded to six decimal places.
 |#

(require srfi/54)
(require srfi/26)
(require (only-in (planet soegaard/math/math) factorial))

;;; Count how many ways there are of forming 'b' breaks in a chain of
;;; length 'len'.
(define (break-count b len)
  (match (cons b len)
    [(cons (? negative?) _) 0]
    [(cons 0 _) 1]
    [(cons _ (? (cut < <> 3))) 0]
    [(cons 1 len) (add1 (break-count 1 (sub1 len)))]
    [_ (+ (break-count (sub1 b) (- len 2))
	  (break-count b (sub1 len)))]))
#|
  (cond
    [(<= b 0) 0]
    [(= b 1)
     (cond
       [(< len 2) 0]
       [(= len 3) 1]
       [else (add1 (break-count b (sub1 len)))])]
    [else
      (+ (break-count (sub1 b) (- len 2))
	 (break-count b (- len 1)))]))
|#

#|
 |;;; First attempt is going to be to try a monte-carlo type simulation.
 |;;; I suspect this will be too slow, though.
 |;;;
 |;;; Ugh.  Not only will this take way too long, but it doesn't seem to
 |;;; converge on the right answer, anyway.
 |
 |(define (build-board n)
 |  (define board (build-vector n +))
 |  (let loop ([pos 0])
 |    (when (< pos n)
 |      (let* ([opos (rng n)]
 |	     [tmp (vector-ref board pos)])
 |	(vector-set! board pos (vector-ref board opos))
 |	(vector-set! board opos tmp))
 |      (loop (add1 pos))))
 |  board)
 |
 |;;; Play a piece on the specified boardmap.  Returns a new boardmap,
 |;;; and a delta on the number of segments.
 |(define (add-piece boardmap piece)
 |  (define left (zero? (bitwise-and boardmap (arithmetic-shift 1 (add1 piece)))))
 |  (define right (zero? (bitwise-and boardmap (arithmetic-shift 1 (sub1 piece)))))
 |  (define delta
 |    (cond
 |      [(and left right) 1]
 |      [(or left right) 0]
 |      [else -1]))
 |  (values (bitwise-ior boardmap (arithmetic-shift 1 piece)) delta))
 |
 |(define (max-play n)
 |  (define board (build-board n))
 |  (let loop ([bmap 0]
 |	     [max-segments 0]
 |	     [segments 0]
 |	     [i (sub1 n)])
 |    (if (not (negative? i))
 |      (let* ([piece (vector-ref board i)])
 |	(let*-values ([(nbmap delta) (add-piece bmap piece)]
 |		      [(nsegments) (+ segments delta)])
 |	  ;(cat nbmap 'binary (+ n 2) #t)
 |	  ;(display " ")
 |	  ;(display nsegments)
 |	  ;(newline)
 |	  (loop nbmap (max max-segments nsegments) nsegments (sub1 i))))
 |      max-segments)))
 |
 |(define (likely n)
 |  (let loop ([total 0]
 |	     [count 0])
 |    (when (= 1 (bitwise-and count 65535))
 |      (cat (/ total count) 10 6.0 #t)
 |      (newline))
 |    (loop (+ total (max-play n)) (add1 count))))
 |
 |(define (make-park-miller seed)
 |  (lambda (limit)
 |    (set! seed (remainder (* seed 16807) #x7fffffff))
 |    (remainder seed limit)))
 |(define rng (make-park-miller 1))
 |#
