#!/usr/bin/env ruby
require "ruby_jard"

class Solution
  #   TOKENIZER = %r{
  #     \A
  #     (?<protocol> https? ) ://
  #     (?<domain>   .+? )
  #     (?<path>     / .*? )?
  #     (?<query>    \? .*? )?
  #     \z
  # }mx

  def input
    test_input || File.read(File.join(__dir__, "input.txt"))
  end

  def test_input
    # <<~INPUT

    # INPUT
  end

  def data
    @data ||= input.split # .map(&:to_i)
  end

  def part1
  end

  def part2
  end
end

puts "Part1: #{Solution.new.part1}"
puts "Part2: #{Solution.new.part2}"

# def neighbours_of_2d(co_ordinates, max: 9, min: 0)
#   x, y = co_ordinates
#   [
#     [[x - 1, min].max, [y - 1, min].max],
#     [[x - 1, min].max, [y + 1, max].min],
#     [[x - 1, min].max, y],
#     [x, [y - 1, min].max],
#     [x, [y + 1, max].min],
#     [[x + 1, max].min, [y - 1, min].max],
#     [[x + 1, max].min, [y + 1, max].min],
#     [[x + 1, max].min, y],
#   ].uniq
# end

# def neighbours_of_3d(co_ordinates, max: 9, min: 0)
#   x, y, z = co_ordinates
#   [
#     [[x - 1, min].max, [y - 1, min].max, [z - 1, min].max],
#     [[x - 1, min].max, [y - 1, min].max, z],
#     [[x - 1, min].max, [y - 1, min].max, [z + 1, max].min],
#     [[x - 1, min].max, [y - 1, min].max],
#     [[x - 1, min].max, y, [z - 1, min].max],
#     [[x - 1, min].max, y, z],
#     [[x - 1, min].max, y, [z + 1, max].min],
#     [[x - 1, min].max, y],
#     [x, [y - 1, min].max, [z - 1, min].max],
#     [x, [y - 1, min].max, z],
#     [x, [y - 1, min].max, [z + 1, max].min],
#     [x, [y - 1, min].max],
#     [x, y, [z - 1, min].max],
#     [x, y, [z + 1, max].min],
#     [x, y],
#     [[x + 1, max].min, [y - 1, min].max, [z - 1, min].max],
#     [[x + 1, max].min, [y - 1, min].max, z],
#     [[x + 1, max].min, [y - 1, min].max, [z + 1, max].min],
#     [[x + 1, max].min, [y - 1, min].max],
#     [[x + 1, max].min, y, [z - 1, min].max],
#     [[x + 1, max].min, y, z],
#     [[x + 1, max].min, y, [z + 1, max].min],
#     [[x + 1, max].min, y],
#   ].uniq
# end
