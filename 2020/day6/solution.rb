#!/usr/bin/env ruby
# frozen_string_literal: true

def test_data
  # <<~DATA
  #   abc
  #
  #   a
  #   b
  #   c
  #
  #   ab
  #   ac
  #
  #   a
  #   a
  #   a
  #   a
  #
  #   b
  #
  # DATA
end

INPUT = test_data || File.read(File.join(__dir__, "input.txt"))

def groups
  @groups ||= INPUT.split("\n\n")
end

def part1
  groups.sum { |group| group.delete("\n").chars.uniq.size }
end

def part2
  groups.sum { |group| group.split.map(&:chars).inject(&:intersection).size }
end

puts "Solution part1: #{part1}"
puts "Solution part2: #{part2}"
