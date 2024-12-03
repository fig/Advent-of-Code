#!/usr/bin/env ruby

class Solution
  def input
    File.readlines(File.join(__dir__, "input.txt"))
  end

  def reports
    @reports ||=
      input.map { |report| report.split.map(&:to_i).tap { |r| r.reverse! if r.first > r.last } }
  end

  def safe? = ->(r) { r.each_cons(2).all? { |a, b| (1..3).cover?(b - a) } }

  def safe_with_dampener? = ->(r) { r.combination(r.length - 1).any?(&safe?) }

  def part1
    reports.count(&safe?)
  end

  def part2
    reports.count(&safe_with_dampener?)
  end

  def solutions
    puts "Part1: #{part1} #{part1 == 564 ? '✅' : '❌'}"
    puts "Part2: #{part2} #{part2 == 604 ? '✅' : '❌'}"
  end
end

Solution.new.solutions
