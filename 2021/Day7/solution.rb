#!/usr/bin/env ruby

class Solution
  def input
    test_input || File.read("input.txt")
  end

  def test_input
    <<~INPUT
      16,1,2,0,4,2,7,1,2,14
    INPUT
  end

  def data
    @data ||= input.split(",").map(&:to_i)
  end

  def part1
    (data.min..data.max).map { |position| data.sum { |e| (e - position).abs } }
                        .min
  end

  def part2
    (data.min..data.max).map { |position| data.sum { |e| triangle((e - position).abs) } }
                        .min
  end

  def triangle(n)
    (n * (n + 1)) / 2
  end
end

puts "Part1: #{Solution.new.part1}"
puts "Part2: #{Solution.new.part2}"
