#!/usr/bin/env ruby

class Solution
  attr_reader :stacks

  def initialize
    @stacks =
      input[0]
      .split("\n")
      .map(&:chars)
      .transpose
      .select! { |stack| stack.any? { |e| e.match?(/\d+/) } }
      .to_h { |stack| [stack.pop, stack.reject { |e| e == " " }] }
  end

  def part1
    crane do |quantity, source, dest|
      quantity.times { stacks[dest].unshift stacks[source].shift }
    end
  end

  def part2
    crane do |quantity, source, dest|
      stacks[dest].unshift(*stacks[source].shift(quantity))
    end
  end

  private

  def crane
    instructions.each do |instruction|
      case instruction.split
      in ["move", quantity, "from", source, "to", dest]
        yield quantity.to_i, source, dest
      else
        next
      end
    end
    stacks.values.map(&:first).join
  end

  def instructions
    @instructions ||= input[1].lines
  end

  def input
    @input ||= File.read(File.join(__dir__, "input.txt")).split("\n\n")
  end
end

puts "Part1: #{Solution.new.part1}"
puts "Part2: #{Solution.new.part2}"
# GFTNRBZPF
# VRQWPDSGP
