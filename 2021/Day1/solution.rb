#!/usr/bin/env ruby

class Solution
  def input
    test_input || File.read(File.join(__dir__, "input.txt"))
  end

  def test_input
    # <<~INPUT
    #   199
    #   200
    #   208
    #   210
    #   200
    #   207
    #   240
    #   269
    #   260
    #   263
    # INPUT
  end

  def data
    @data ||= input.split.map(&:to_i)
  end

  # 1624
  # 1653
  def solutions
    puts "Part1: #{solve_for(2)}"
    puts "Part2: #{solve_for(4)}"
  end

  private

  def solve_for(n)
    data.each_cons(n).count { _1[0] < _1[-1] }
  end
end

Solution.new.solutions
