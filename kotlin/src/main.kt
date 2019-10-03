package org.davidb.euler

fun main(args: Array<String>) {
    // For now, assume 'all' and try all of them.
    for (p in problems) {
        p().check()
    }
}

val problems: Array<() -> EulerProblem> = arrayOf(
        ::Pr001,
        ::Pr002,
        ::Pr003,
        ::Pr004,
        ::Pr005,
        ::Pr006,
        ::Pr007,
        ::Pr008,
        ::Pr009,
        ::Pr010,
        ::Pr011,
        ::Pr012
)
