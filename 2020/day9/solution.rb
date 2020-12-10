#!/usr/bin/env ruby
# frozen_string_literal: true

require "ruby_jard"

def test_data
  # <<~DATA
  #   35
  #   20
  #   15
  #   25
  #   47
  #   40
  #   62
  #   55
  #   65
  #   95
  #   102
  #   117
  #   150
  #   182
  #   127
  #   219
  #   299
  #   277
  #   309
  #   576
  # DATA
end

DATA = test_data || File.read(File.join(__dir__, "input.txt"))

def input
  @input ||= DATA.split.map(&:to_i)
end

PREAMBLE = 25

def part1
  input.find.each_with_index do |n, i|
    (PREAMBLE - 1) < i &&
      input[(i - PREAMBLE), PREAMBLE].combination(2).none? { |c| c.sum == n }
  end
end

def part2
  tgt = part1
  (2..input.length).each do |n|
    input.each_cons(n) do |a|
      return a.minmax.sum if a.sum == tgt
    end
  end
end

puts "Solution part1:\n#{part1 == 542_529_149}"
puts "Solution part2:\n#{part2 == 75_678_618 || part2}"
