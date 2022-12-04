#!/usr/bin/env ruby

require "set"

class Solution
  def input
    test_input || File.read("input.txt")
  end

  def test_input
    # <<~INPUT
    #   2-4,6-8
    #   2-3,4-5
    #   5-7,7-9
    #   2-8,3-7
    #   6-6,4-6
    #   2-6,4-8
    # INPUT
  end

  def data
    input.split
  end

  def sets
    @sets ||=
      data.map { |line|
        line.split(",").map { Range.new(*_1.split("-")).to_set }
      }
  end

  def solutions
    puts "Part1: #{part1}"
    puts "Part2: #{part2}"
  end

  private

  def part1
    sets.count { |a, b| a <= b || a >= b }
  end

  def part2
    sets.count { |a, b| (a & b).any? }
  end
end

Solution.new.solutions

# 651
# 956
