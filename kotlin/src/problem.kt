package org.davidb.euler

// The @Problem(num) annotation indicates that this is an Euler
// problem, of the given num.
@Target(AnnotationTarget.CLASS, AnnotationTarget.FUNCTION)
annotation class Problem(val number: Int)

// The @IntAnswer(value) indicates this problem should return an int
// of the given value.
@Target(AnnotationTarget.CLASS, AnnotationTarget.FUNCTION)
annotation class IntAnswer(val answer: Int)

class IncorrectAnswer(val description: String): Throwable()

interface EulerProblem {
    val num: Int
    fun check()
}

abstract class EulerSolution<T>: EulerProblem {
    // The problem number.
    override abstract val num: Int

    // The correct answer.
    abstract val answer: T

    // Compute the correct answer
    abstract fun solve(): T

    // Try solving this problem and throw an exception if the answer
    override fun check() {
        print("pr%03d".format(num))
        // flush
        val got = solve()
        println(": $got")
        if (got != answer) {
            throw IncorrectAnswer("Error in problem $num, expect $answer, got $got")
        }
    }
}
