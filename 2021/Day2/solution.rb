#!/usr/bin/env ruby

class Solution
  # TOKENIZER = //

  def input
    test_input || File.read(File.join(__dir__, "input.txt"))
  end

  def test_input
    # <<~INPUT

    # INPUT
  end

  def data
    @data ||= input.split # .map(&:to_i)
  end

  def part1
  end

  def part2
  end
end

solution = Solution.new
puts "Part1: #{solution.part1}"
puts "Part2: #{solution.part2}" if solution.part2
