#!/usr/bin/env ruby

class Solution
  def part1
    find_uniq_sequence 4
  end

  def part2
    find_uniq_sequence 14
  end

  private

  def find_uniq_sequence(length)
    stream.chars.each_cons(length).with_index(length) do |chars, i|
      break i if chars.uniq.size == length
    end
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
