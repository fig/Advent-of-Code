#!/usr/bin/env ruby

class Solution
  def part1
    find_uniq_sequence length: 4
  end

  def part2
    find_uniq_sequence length: 14
  end

  private

  def find_uniq_sequence(length:)
    length + stream.chars.each_cons(length).find_index { |seq| seq.uniq == seq }
  end

  def stream
    @stream ||= input
  end

  def input
    test_input || File.read(File.join(__dir__, "input.txt"))
  end

  def test_input
    # "mjqjpqmgbljsphdztnvjfqwrcgsmlb\n"
  end
end

puts "Part1: #{Solution.new.part1}"
puts "Part2: #{Solution.new.part2}"
# 1361
# 3263
