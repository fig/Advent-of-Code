#!/usr/bin/env ruby

class Solution
  def input
    test_input || File.read(File.join(__dir__, "input.txt"))
  end

  def test_input
    # <<~INPUT
    #   1000
    #   2000
    #   3000

    #   4000

    #   5000
    #   6000

    #   7000
    #   8000
    #   9000

    #   10000
    # INPUT
  end

  def data
    @data ||=
      input.split("\n\n").map { |elf|
        elf.split.map(&:to_i)
      }
  end

  def solutions
    puts "Part1: #{part1}"
    puts "Part2: #{part2}"
  end

  private

  def part1
    data.map(&:sum).max
  end

  def part2
    data.map(&:sum).max(3).sum
  end
end

Solution.new.solutions
