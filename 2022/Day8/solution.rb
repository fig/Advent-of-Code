#!/usr/bin/env ruby

module Day8
  class Solution
    def run
    end

    def part1
    end

    def part2
    end

    def input
      test_data || ::File.read(::File.join(__dir__, "input.txt"))
    end

    def test_data
      <<~TEST
        foo
      TEST
    end
  end
end

s = Day8::Solution.new
s.run
puts "Part1: #{s.part1}"
puts "Part2: #{s.part2}"
