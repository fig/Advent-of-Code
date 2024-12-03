#!/usr/bin/env ruby

class Solution
  def input
    File.read(File.join(__dir__, "input.txt")).split("\n")
  end

  def solutions
    puts "Part1: #{part1} #{part1 == 2_815_556 ? '✅' : '❌'}"
    puts "Part2: #{part2} #{part2 == 23_927_637 ? '✅' : '❌'}"
  end

private

  def part1
    input.map { |line| line.split.map(&:to_i) }
         .transpose
         .map!(&:sort!)
         .transpose
         .sum { |row| (row.first - row.last).abs }
  end

  def part2
    input.map { |line| line.split.map(&:to_i) }
         .transpose
         .then { |left, right| left.sum { |num| num * right.count(num) } }
  end
end

Solution.new.solutions
