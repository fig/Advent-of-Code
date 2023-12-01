#!/usr/bin/env ruby

class Solution
  NUMS = {
    "one"   => "1",
    "two"   => "2",
    "three" => "3",
    "four"  => "4",
    "five"  => "5",
    "six"   => "6",
    "seven" => "7",
    "eight" => "8",
    "nine"  => "9",
  }.freeze

  def input
    File.read(File.join(__dir__, "input.txt")).split("\n")
  end

  def solutions
    puts "Part1: #{part1}"
    puts "Part2: #{part2}"
  end

private

  def part1
    input.map { |line| line.scan(/\d/) }
         .map! { |digits| [digits.first, digits.last] }
         .sum { |digits| digits.join.to_i }
  end

  def part2
    input.map { |line| line.scan(/(?=(\d|one|two|three|four|five|six|seven|eight|nine))/).flatten }
         .map! { |matches| [matches.first, matches.last] }
         .map! { |matches| matches.map { |match| NUMS[match] || match } }
         .sum { |digits| digits.join.to_i }
  end
end

Solution.new.solutions
