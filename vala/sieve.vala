// A simple prime sieve.

class Euler.Sieve : Object {

	private bool[] composites;

	public int size {
		get { return composites.length; }
		private set { fill(value); }
	}

	private void fill(int size) {
		// This apppears to be zero initialized.
		composites = new bool[size];
		composites[0] = true;
		composites[1] = true;

		var pos = 2;
		while (pos < size) {
			if (composites[pos]) {
				pos += 2;
			} else {
				var n = pos + pos;
				while (n < size) {
					composites[n] = true;
					n += pos;
				}
				if (pos == 2)
					pos++;
				else
					pos += 2;
			}
		}
	}

	public bool is_prime(int n) {
		if (n >= size) {
			var new_size = size;
			while (new_size < n)
				new_size *= 8;
			size = new_size;
		}
		return !composites[n];
	}

	public int next_prime(int n) {
		if (n == 2)
			return 3;
		n += 2;
		while (!is_prime(n))
			n += 2;
		return n;
	}

	public Sieve() {
		size = 8192;
	}

	public void dump() {
		stdout.printf("Sieve to %d\n", size);
		for (int i = 2; i < size; i++) {
			if (!composites[i])
				stdout.printf(" %d", i);
		}
		stdout.printf("\n");
	}
}
