#!/usr/bin/env ruby
def test_data
end

INPUT = test_data || File.read(File.join(__dir__, "input.txt"))

def data
  @data ||= INPUT.split.map(&:to_i)
end

def part1
  data.combination(2).find { |combo| combo.sum == 2020 }.inject(:*)
end

def part2
  data.combination(3).find { |combo| combo.sum == 2020 }.inject(:*)
end

puts "Solution part1: #{part1}"
puts "Solution part2: #{part2}"
