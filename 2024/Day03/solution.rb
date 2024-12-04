#!/usr/bin/env ruby

require "strscan"

class Solution
  FUNCTION = /mul\((\d+,\d+)\)/

  def input
    File.read(File.join(__dir__, "input.txt"))
  end

  def compute(code)
    code.scan(FUNCTION).flatten.sum { |str| str.split(",").map(&:to_i).reduce(:*) }
  end

  def part1
    compute(input)
  end

  def part2
    acc = 0
    scanner = StringScanner.new(input)
    loop do
      break acc += compute(scanner.rest) unless (match = scanner.scan_until(/don't\(\)/))

      acc += compute(match)
      break(acc) unless scanner.skip_until(/do\(\)/)
    end
  end

  def solutions
    puts "Part1: #{part1}"
    puts "Part2: #{part2}"
  end
end

Solution.new.solutions
