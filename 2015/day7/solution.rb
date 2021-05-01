#!/usr/bin/env ruby
# frozen_string_literal: true

INPUT = File.read(File.join(__dir__, "input.txt"))

def data
  @data ||= INPUT.split("\n")
end

class Wire
  OR =
    lambda { |input|
      a, b = input.split(" OR ")
      WIRES[a] | WIRES[b]
    }

  def initialize(id, input)
    @id = id
    @input = input
  end

  def output
    resolve input
  end

  def resolve(input)
    input.scan(/[[:upper:]]/).call(input)
  end
end

puts "Solution part1: "
puts "Solution part2: "
