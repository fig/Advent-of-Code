#!/usr/bin/env ruby

class Solution
  def input
    test_input || File.read(File.join(__dir__, "input.txt"))
  end

  def test_input
    <<~INPUT
      7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

      22 13 17 11  0
       8  2 23  4 24
      21  9 14 16  7
       6 10  3 18  5
       1 12 20 15 19

       3 15  0  2 22
       9 18 13 17  5
      19  8  7 25 23
      20 11 10 24  4
      14 21 16 12  6

      14 21 17 24  4
      10 16 15  9 19
      18  8 23 26 20
      22 11 13  6  5
       2  0 12  3  7
    INPUT
    nil
  end

  def data
    @data ||= input # .map(&:to_i)
  end

  def call_seq
    @call_seq ||= data.split("\n").delete_at(0).split(",")
  end

  class Board
    def initialize(lines)
      @lines = lines.split("\n").map(&:split)
    end

    def mark(n)
      @lines.each_with_index do |line, i|
        line.each_with_index do |e, j|
          @lines[i][j] = "x" if e == n
        end
      end
    end

    def line_complete?
      @lines.any? { |l| l.all? { |e| e == "x" } } ||
        @lines.transpose.any? { |l| l.all? { |e| e == "x" } }
    end

    def total
      @lines.flatten.map(&:to_i).reduce(:+)
    end
  end

  def part1
    boards = []
    data.split("\n\n")[1..].each do |board|
      boards << Board.new(board)
    end
    last_called =
      call_seq.each { |n|
        boards.each { |b| b.mark(n) }
        break n if boards.any?(&:line_complete?)
      }
    winner = boards.find(&:line_complete?)
    last_called.to_i * winner.total
  end

  def part2
    boards = []
    data.split("\n\n")[1..].each do |board|
      boards << Board.new(board)
    end
    last_called =
      loop {
        last_called =
          call_seq.each { |n|
            boards.each { |b| b.mark(n) }
            break n if boards.any?(&:line_complete?)
          }
        winner = boards.find(&:line_complete?)
        break last_called if boards.all?(&:line_complete?)

        boards.delete(winner)
      }
    last_called.to_i * boards[0].total
  end
end

solution = Solution.new
puts "Part1: #{solution.part1}"
puts "Part2: #{solution.part2}" if solution.part2
