// General things for Project euler problems.

module euler.misc;

// TODO: Put constraints to make better errors.
int digitSum(T)(T num) {
    auto sum = 0;
    while (num > 0) {
	sum += num % 10;
	num /= 10;
    }
    return sum;
}
