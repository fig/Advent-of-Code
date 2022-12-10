#!/usr/bin/env ruby

class Solution
  OUTCOMES1 = {
    "A X" => 4,
    "A Y" => 8,
    "A Z" => 3,
    "B X" => 1,
    "B Y" => 5,
    "B Z" => 9,
    "C X" => 7,
    "C Y" => 2,
    "C Z" => 6,
  }.freeze

  OUTCOMES2 = {
    "A X" => 3,
    "A Y" => 4,
    "A Z" => 8,
    "B X" => 1,
    "B Y" => 5,
    "B Z" => 9,
    "C X" => 2,
    "C Y" => 6,
    "C Z" => 7,
  }.freeze

  def input
    test_input || File.read(File.join(__dir__, "input.txt"))
  end

  def test_input
    # <<~INPUT
    #   A Y
    #   B X
    #   C Z
    # INPUT
  end

  def data
    @data ||= input.lines(chomp: true)
  end

  def solutions
    puts "Part1: #{play(OUTCOMES1)}"
    puts "Part2: #{play(OUTCOMES2)}"
  end

  private

  def play(outcomes)
    data.reduce(0) { |acc, elem| acc + outcomes[elem] }
  end
end

Solution.new.solutions

# 13526
# 14204
