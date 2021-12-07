#!/usr/bin/env ruby

class Solution
  def input
    test_input || File.read("input.txt")
  end

  def test_input
    # <<~INPUT
    #   3,4,3,1,2
    # INPUT
  end

  def data
    @data ||= input.split(",").map(&:to_i).tally
  end

  def solve_for(days)
    fish = (0..8).map { |i| data[i] || 0 }
    days.times do
      fish.rotate!
      fish[6] += fish[8]
    end
    fish.sum
  end
end

puts "Part1: #{Solution.new.solve_for(80)}"
puts "Part2: #{Solution.new.solve_for(256)}"
