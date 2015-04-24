REBOL [
    Name: sieve.r
    Type: module
    Exports: [make-sieve]
]

; TODO: Use a prototype instead of defining it for each.

make-sieve: funct [] [
    tmp: make object! [
	limit: 8192
	composites: none

	fill: func [/local pos n] [
	    composites: make bitset! (limit + 1)
	    composites/0: true
	    composites/1: true

	    pos: 2
	    while [pos <= limit] [
		either composites/(pos) [
		    pos: pos + 1
		] [
		    n: pos + pos
		    while [n <= limit] [
			composites/(n): true
			n: n + pos
		    ]
		    either pos == 2 [
			pos: pos + 1
		    ] [
			pos: pos + 2
		    ]
		]
	    ]
	]

	prime?: func [n [integer!]] [
	    if n >= limit [
		while [limit < n] [
		    limit: limit * 8
		]
		fill
	    ]
	    not composites/(n)
	]

	next-prime: func [n [integer!]] [
	    either n == 2 [ 3 ] [
		n: n + 2
		while [not prime? n] [
		    n: n + 2
		]
		n
	    ]
	]
    ]

    tmp/fill
    tmp
]
