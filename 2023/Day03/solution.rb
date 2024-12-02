#!/usr/bin/env ruby

require "strscan"

class Solution
  def input
    sample || File.read(File.join(__dir__, "input.txt"))
  end

  def sample
    <<~SAMPLE
      467..114..
      ...*......
      ..35..633.
      ......#...
      617*......
      .....+.58.
      ..592.....
      ......755.
      ...$.*....
      .664.598..
    SAMPLE
  end

  def part1
    part_nums = []
    input.lines.each_with_index do |line, i|
      s = StringScanner.new(line)
      s.scan_until(/[^\d\.]/)
      next if s.eos?

      if input.lines[i - 1][s.pos - 2, 3].match?(/\d/)
      p input.lines[i - 1][s.pos - 2, 3]
    end
  end

  def solutions
    puts "Part1: #{part1}"
    puts "Part2: #{part2}"
  end

  def part2
  end
end

Solution.new.solutions
