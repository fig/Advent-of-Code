#!/usr/bin/env ruby

class Solution
  def input
    test_input || File.read(File.join(__dir__, "input.txt"))
  end

  def test_input
    # <<~INPUT
    #   vJrwpWtwJgWrhcsFMMfFFhFp
    #   jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
    #   PmmdzqPrVvPwwTWBwg
    #   wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
    #   ttgJtRGJQctTZtZT
    #   CrZsJsPPZsGzwwsLwLmpwMDw
    # INPUT
  end

  def data
    @data ||= input.split
  end

  def solutions
    puts "Part1: #{part1}"
    puts "Part2: #{part2}"
  end

  private

  def part1
    data.sum do |line|
      middle = line.length / 2
      line[0...middle].each_char do |char|
        if line[middle..].include?(char)
          break char.ord < 97 ? char.ord - 38 : char.ord - 96
        end
      end
    end
  end

  def part2
    data.each_slice(3).sum do |group|
      group[0].each_char do |char|
        if group[1].include?(char) && group[2].include?(char)
          break char.ord < 97 ? char.ord - 38 : char.ord - 96
        end
      end
    end
  end
end

Solution.new.solutions

# 8243
# 2631
