#!/usr/bin/env ruby
require 'ruby_jard'

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

puts "Part1: #{Solution.new.part1}"
puts "Part2: #{Solution.new.part2}"
