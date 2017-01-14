//////////////////////////////////////////////////////////////////////
// Problem 96
//
// 27 May 2005
//
// Su Doku (Japanese meaning number place) is the name given to a
// popular puzzle concept. Its origin is unclear, but credit must be
// attributed to Leonhard Euler who invented a similar, and much more
// difficult, puzzle idea called Latin Squares. The objective of Su
// Doku puzzles, however, is to replace the blanks (or zeros) in a 9 by
// 9 grid in such that each row, column, and 3 by 3 box contains each
// of the digits 1 to 9. Below is an example of a typical starting
// puzzle grid and its solution grid.
//
// ┌───────┬───────┬───────┐          ┌───────┬───────┬───────┐
// │ 0 0 3 │ 0 2 0 │ 6 0 0 │          │ 4 8 3 │ 9 2 1 │ 6 5 7 │
// │ 9 0 0 │ 3 0 5 │ 0 0 1 │          │ 9 6 7 │ 3 4 5 │ 8 2 1 │
// │ 0 0 1 │ 8 0 6 │ 4 0 0 │          │ 2 5 1 │ 8 7 6 │ 4 9 3 │
// ├───────┼───────┼───────┤          ├───────┼───────┼───────┤
// │ 0 0 8 │ 1 0 2 │ 9 0 0 │          │ 5 4 8 │ 1 3 2 │ 9 7 6 │
// │ 7 0 0 │ 0 0 0 │ 0 0 8 │ [spacer] │ 7 2 9 │ 5 6 4 │ 1 3 8 │
// │ 0 0 6 │ 7 0 8 │ 2 0 0 │          │ 1 3 6 │ 7 9 8 │ 2 4 5 │
// ├───────┼───────┼───────┤          ├───────┼───────┼───────┤
// │ 0 0 2 │ 6 0 9 │ 5 0 0 │          │ 3 7 2 │ 6 8 9 │ 5 1 4 │
// │ 8 0 0 │ 2 0 3 │ 0 0 9 │          │ 8 1 4 │ 2 5 3 │ 7 6 9 │
// │ 0 0 5 │ 0 1 0 │ 3 0 0 │          │ 6 9 5 │ 4 1 7 │ 3 8 2 │
// └───────┴───────┴───────┘          └───────┴───────┴───────┘
//
// A well constructed Su Doku puzzle has a unique solution and can be
// solved by logic, although it may be necessary to employ "guess and
// test" methods in order to eliminate options (there is much contested
// opinion over this). The complexity of the search determines the
// difficulty of the puzzle; the example above is considered easy
// because it can be solved by straight forward direct deduction.
//
// The 6K text file, sudoku.txt (right click and 'Save Link/Target
// As...'), contains fifty different Su Doku puzzles ranging in
// difficulty, but all with unique solutions (the first puzzle in the
// file is the example above).
//
// By solving all fifty puzzles find the sum of the 3-digit numbers
// found in the top left corner of each solution grid; for example, 483
// is the 3-digit number found in the top left corner of the solution
// grid above.
//
//////////////////////////////////////////////////////////////////////

// 24702

package pr096

import (
	"bufio"
	"bytes"
	"fmt"
	"io"
	"os"
)

func Run() {
	problems, err := readProblems()
	if err != nil {
		panic(err)
	}

	total := 0
	for _, board := range problems {
		branch := NewBranch(board)
		solution := branch.Solve()

		cell := int(solution[0])*100 + int(solution[1])*10 + int(solution[2])
		total += cell
	}
	fmt.Printf("%d\n", total)
}

type Branch struct {
	board  board
	places []Places
}

func (b *Branch) Solve() board {
	best := b.BestMove()

	if best == nil {
		// Having no best answer means one of two things,
		// either the board is entirely solved, or there are
		// no positions.
		for _, p := range b.board {
			// If any piece is still not solved, the board
			// is unsolvable.
			if p == 0 {
				return nil
			}
		}
		return b.board
	}

	if best.count == 1 {
		// If there is a fully-constrained choice, make it,
		// and recurse without forking the data.
		b.board.Set(best.row, best.col, best.places.Values()[0])
		b.SetPossible() // TODO: This could be faster.
		return b.Solve()
	} else {
		// Try each possible move in the best moves.
		for _, m := range best.places.Values() {
			b2 := NewBranch(b.board)
			b2.board.Set(best.row, best.col, m)
			b2.SetPossible()
			solution := b2.Solve()
			if solution != nil {
				return solution
			}
		}
		// None of the solutions work, so we're inside of a
		// dead end.
		return nil
	}
}

func (b *Branch) Format(f fmt.State, c rune) {
	fmt.Fprintf(f, "%v%v", b.board, b.places)
}

func (b *Branch) SetPossible() {
	places := make([]Places, 81)

	for r := 0; r < 9; r++ {
		for c := 0; c < 9; c++ {
			places[9*r+c] = b.board.Possible(r, c)
		}
	}
	b.places = places
	return
}

type Move struct {
	row, col int
	places   Places
	count    int
}

// Compute the best move from this board position.  Returns 'nil' if
// there are no moves left, otherwise returns the best move.
func (b *Branch) BestMove() *Move {
	var best Move
	best.count = 10

	for c := 0; c < 9; c++ {
		for r := 0; r < 9; r++ {
			pl := b.places[r*9+c]
			count := pl.Count()

			if count == 1 {
				// This cell has only on option,
				// that's our best, return it.
				best.row = r
				best.col = c
				best.places = pl
				best.count = count
				return &best
			}

			if count > 0 && count < best.count {
				best.row = r
				best.col = c
				best.places = pl
				best.count = count
			}
		}
	}

	if best.count == 10 {
		return nil
	}
	return &best
}

func NewBranch(startBoard board) (result *Branch) {
	board := newBoard()
	copy(board, startBoard)

	result = &Branch{board: board}
	result.SetPossible()
	return
}

// Attempt to solve the given board.
func (startBoard board) Solve() (solution *Branch) {
	board := newBoard()
	copy(board, startBoard)

	solution = &Branch{board: board}
	solution.SetPossible()
	return
}

func (b board) Walk() bool {
	best := 9

	for c := 0; c < 9; c++ {
		for r := 0; r < 9; r++ {
			pc := b.Possible(r, c)
			count := pc.Count()

			if count == 1 {
				// This cell only has one option, set
				// it.
				b.Set(r, c, pc.Values()[0])
				return true
			}

			if count > 0 && count < best {
				best = count
			}
		}
	}

	if best == 9 {
		// We're done here.
		return false
	}

	panic("TODO: Branch search tree")

	return false
}

// Read the problems in.
func readProblems() (result []board, err error) {
	fd, err := os.Open("src/github.com/d3zd3z/euler/ruby/sudoku.txt")
	if err != nil {
		return
	}
	rd := bufio.NewReader(fd)

	count := 0
	stop := false
	var board board
	for !stop {
		var line []byte
		line, err = rd.ReadBytes('\n')
		if err == io.EOF {
			err = nil
			stop = true
			// Last line in file is partial, so process it
			// anyway.
		}
		if err != nil {
			return
		}
		line = bytes.TrimRight(line, "\r\n")

		if bytes.Equal(line[:4], gridBytes) {
			count = 0
			board = newBoard()
		} else {
			for ch := range line {
				line[ch] -= '0'
			}
			copy(board[9*count:9*count+9], line)

			count += 1
			if count == 9 {
				result = append(result, board)
			}
		}
	}

	return
}

type board []byte

type Places int

func newBoard() board {
	return make([]byte, 9*9)
}

func (b board) Get(row, col int) byte {
	return b[9*row+col]
}

func (b board) Set(row, col int, value byte) {
	b[9*row+col] = value
}

func (b board) UnknownCount() int {
	return bytes.Count(b, []byte{0})
}

func (b board) String() string {
	var result bytes.Buffer

	for i, ch := range b {
		if ch == 0 {
			result.WriteByte(' ')
		} else {
			result.WriteByte(ch + '0')
		}

		if i%9 == 8 {
			if i > 0 {
				result.WriteByte('\n')
				if i%27 == 26 {
					result.WriteString("-----------\n")
				}
			}
		} else if i%3 == 2 && i%9 > 0 {
			result.WriteByte('|')
		}
	}

	return result.String()
}

func (b board) Possible(row, col int) (places Places) {
	places = 511

	// If this cell is taken, there are no choices.
	if b.Get(row, col) != 0 {
		return 0
	}

	// Eliminate within this row.
	for c := 0; c < 9; c++ {
		tmp := b.Get(row, c)
		if tmp > 0 {
			places &^= 1 << (tmp - 1)
		}
	}

	// Eliminate within this column.
	for r := 0; r < 9; r++ {
		tmp := b.Get(r, col)
		if tmp > 0 {
			places &^= 1 << (tmp - 1)
		}
	}

	// Eliminate within this segment.
	ra := (row / 3) * 3
	rb := ra + 3

	ca := (col / 3) * 3
	cb := ca + 3

	for r := ra; r < rb; r++ {
		for c := ca; c < cb; c++ {
			tmp := b.Get(r, c)
			if tmp > 0 {
				places &^= 1 << (tmp - 1)
			}
		}
	}

	return
}

func (p Places) Count() int {
	return pcount[p&15] + pcount[(p>>4)&15] + pcount[p>>8]
}

var pcount = []int{
	0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4,
}

func (p Places) Values() (result []byte) {
	result = make([]byte, 0, 2)

	for b := byte(0); b < 9; b++ {
		if (p & (1 << b)) != 0 {
			result = append(result, b+1)
		}
	}
	return
}

func (p Places) Format(f fmt.State, c rune) {
	fmt.Fprintf(f, "'")
	for _, v := range p.Values() {
		fmt.Fprintf(f, "%d", v)
	}
	fmt.Fprintf(f, "'")
}

var gridBytes = []byte{'G', 'r', 'i', 'd'}
