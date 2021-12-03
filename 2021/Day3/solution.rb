#!/usr/bin/env ruby
require "ruby_jard"

class Solution
  # TOKENIZER = //

  def input
    test_input || File.read(File.join(__dir__, "input.txt"))
  end

  def test_input
    <<~INPUT
      00100
      11110
      10110
      10111
      10101
      01111
      00111
      11100
      10000
      11001
      00010
      01010
    INPUT
  end

  def data
    @data ||= input.split # .map(&:to_i)
  end

  def word_length
    @word_length ||= data.first.length
  end

  def part1
    tally = Array.new(word_length, 0)
    data.each do |l|
      l.chars.each_with_index do |c, i|
        tally[i] += c.to_i
      end
    end
    gamma = tally.map { |t| t > (data.length / 2) ? "1" : "0" }
                 .join
                 .to_i(2)
    epsilon = tally.map { |t| t > (data.length / 2) ? "0" : "1" }
                   .join
                   .to_i(2)
    gamma * epsilon
  end

  def part2
  end
end

solution = Solution.new
puts "Part1: #{solution.part1}"
puts "Part2: #{solution.part2}" if solution.part2
