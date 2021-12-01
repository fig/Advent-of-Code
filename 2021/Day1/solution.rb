#!/usr/bin/env ruby

class Solution
  # TOKENIZER = //

  def input
    test_input || File.read(File.join(__dir__, "input.txt"))
  end

  def test_input
    # <<~INPUT
    #   199
    #   200
    #   208
    #   210
    #   200
    #   207
    #   240
    #   269
    #   260
    #   263
    # INPUT
  end

  def data
    @data ||= input.split.map(&:to_i)
  end

  def part1
    data.each_cons(2).count { |a, b| a < b }
  end

  def part2
    data.each_cons(3).each_cons(2).count { |a, b| a.sum < b.sum }
  end
end

solution = Solution.new
puts "Part1: #{solution.part1}"
puts "Part2: #{solution.part2}" if solution.part2
