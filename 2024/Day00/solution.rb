#!/usr/bin/env ruby

class Solution
  def input
    File.readlines(File.join(__dir__, "input.txt"))
  end

  def lines
    @lines ||= input
  end

  def part1
  end

  def part2
  end

  def solutions
    puts "Part1: #{part1}"
    puts "Part2: #{part2}"
  end
end

Solution.new.solutions
