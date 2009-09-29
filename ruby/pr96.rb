#! /usr/bin/env ruby19
#
# Sudoku solver.

require 'benchmark'

class Puzzle
  def initialize(board = nil, name = "unknown")
    board = Array.new(9) { Array.new(9, 0) } unless board
    @board = board
    @name = name
  end
  attr_reader :name

  def show
    puts @name
    @board.each_index do |y|
      puts '-----+-----+-----' if y == 3 or y == 6
      line = @board[y].join(' ')
      line[5] = '|'
      line[-6] = '|'
      puts line
    end
  end

  # Return a list of numbers of possible values that can go in cell
  # 'n'.
  def possible(row,col)
    return [] if @board[row][col] > 0
    can = 511
    elim = ->(y,x) do
      tmp = @board[y][x]
      can &= ~(1 << (tmp - 1)) if tmp
    end

    # Eliminate rows and columns.
    (0..8).each do |num|
      elim.(row, num)
      elim.(num, col)
    end

    # Eliminate this cell.
    y = (row / 3) * 3
    x = (col / 3) * 3
    (0..2).each do |dy|
      (0..2).each do |dx|
        elim.(y+dy, x+dx)
      end
    end

    result = []
    (1..9).each do |num|
      result << num if (can & 1) != 0
      can >>= 1
    end
    result
  end

  # Count the number of unsolved positions.
  def unsolved
    @board.map { |row| row.reduce(0) { |sum, n| sum + (n == 0 ? 1 : 0) } }.reduce(&:+)
  end

  # Find a single possible solution.
  def single
    tries = nil
    trypos = nil
    (0..8).each do |row|
      (0..8).each do |col|
        pos = possible(row, col)
        if pos.length == 1
          @board[row][col] = pos[0]
          return
        elsif pos.length > 1
          if not tries
            tries = pos
            trypos = [row, col]
          elsif pos.length < tries.length
            tries = pos
            trypos = [row, col]
          end
        end
      end
    end

    # Failed to find a solution through elimination, need to try brute
    # force.
    throw :solved, false unless tries
    brute(trypos[0], trypos[1], *tries)
  end

  # Deep clone an array of arrays.
  def deepclone(ary)
    ary.collect{|row| row.dup}
  end

  # Solve the puzzle (without guessing).
  def solve
    @brute = nil
    solved = catch :solved do
      unsolved.times { single }
      true
    end
    abort "No solution" unless solved
  end

  # Return the Euler problem magic number.
  def magic
    row = @board[0]
    row[0] * 100 + row[1] * 10 + row[2]
  end

  # Try a bruteforce solution at (row, col, try, try, try)
  # Really, deduction could get us further than this, but this is
  # easier to write, and runs plenty fast.
  def brute(row, col, *tries)
    unless @brute
      #puts "Needing brute force search"
      @brute = true
    end
    #puts "Brute force at #{row},#{col}, #{tries.length} to try"
    orig = deepclone(@board)
    tries.each do |try|
      #puts "Trying #{try}"
      @board[row][col] = try
      solved = catch :solved do
        unsolved.times { single }
        true
      end
      throw :solved, true if solved
      @board = deepclone(orig)
    end
    throw :solved, false
  end

  # Read a Puzzle from +io+.  The first line is an arbitrary name.
  # Following this should be nine lines of 9 digits each.  0 indicates
  # a no solution board.
  def self.read(io)
    name = io.readline.chomp!
    board = (0..8).map do
      line = io.readline
      line.scan(/\d/).map &:to_i
    end
    new(board, name)
  end
end

def main
  sum = 0
  Benchmark.bm(7) do |bm|
    open('sudoku.txt') do |file|
      50.times do
        b = Puzzle.read(file)
        bm.report(b.name) do
          b.solve
          #b.show
          sum += b.magic
        end
      end
    end
  end
  puts "Euler answer: #{sum}"
end
main
