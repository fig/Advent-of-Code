#!/usr/bin/env ruby
# frozen_string_literal: true

require "ruby_jard"

def test_data
  # <<~DATA
  #   16
  #   10
  #   15
  #   5
  #   1
  #   11
  #   7
  #   19
  #   6
  #   12
  #   4
  # DATA
end

DATA = test_data || File.read(File.join(__dir__, "input.txt"))

def adapters
  @adapters ||= DATA.split.map(&:to_i)
end

def device
  @device ||= adapters.max + 3
end

def input
  @input ||= (adapters << 0 << device).sort.each_cons(2)
end

def ones
  input.count { |a, b| b - a == 1 }
end

def threes
  input.count { |a, b| b - a == 3 }
end

def number_of_arrangements(current = 0)
  return 1 if current == device

  @arrangements ||= {}
  @arrangements[current] ||= valid_next_options(current).sum { |option| number_of_arrangements(option) }
end

def valid_next_options(adapter)
  @options ||= {}
  @options[adapter] ||= adapters.select { |val| (1..3).cover? val - adapter }
end

def part1
  ones * threes
end

def part2
  number_of_arrangements
end

puts "Solution part1:\n#{part1}"
puts "Solution part2:\n#{part2}"
