#!/usr/bin/env ruby
# frozen_string_literal: true

INPUT = File.read(File.join(__dir__, "input.txt"))

def data
  @data ||= INPUT.split.map(&:to_i)
end

l = ->(n) { data.combination(n).find { _1.sum == 2020 }.inject(:*) }

puts "Solution part1: #{l[2]}"
puts "Solution part2: #{l[3]}"
