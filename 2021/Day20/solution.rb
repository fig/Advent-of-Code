#!/usr/bin/env ruby
require "ruby_jard"

class Solution
  def input
    test_input || File.read(File.join(__dir__, "input.txt"))
  end

  def test_input
    <<~INPUT
      ..#.#..#####.#.#.#.###.##.....###.##.#..###.####..#####..#....#..#..##..###..######.###...####..#..#####..##..#.#####...##.#.#..#.##..#.#......#.###.######.###.####...#.##.##..#..#..#####.....#.#....###..#.##......#.....#..#..#..##..#...##.######.####.####.#.#...#.......#..#.#.#...####.##.#......#..#...##.#.##..#...##.#.##..###.#......#.#.......#.#.#.####.###.##...#.....####.#..#..#.##.#....##..#.####....##...##..#...#......#.#.......#.......##..####..#...#.#.#...##..#.#..###..#####........#..####......#..#

      #..#.
      #....
      ##..#
      ..#..
      ..###
    INPUT
  end

  def image_enhancement_algorithm
    @image_enhancement_algorithm ||= input.split("\n\n")[0]
  end

  def input_image
    image = {}
    @input_image ||=
      input.split("\n\n")[1].lines(chomp: true).each.with_index { |line, x|
        line.chars.each.with_index do |pixel, y|
          image[[x, y]] = pixel
        end
      }
  end

  def part1
    input_image[0][5]
  end

  def part2
  end

  def neighbours(co_ordinates)
    x, y = co_ordinates
    [
      [x - 1, y - 1],
      [x - 1, y + 1],
      [x - 1, y],
      [x, y - 1],
      [x, y],
      [x, y + 1],
      [x + 1, max.min, y - 1],
      [x + 1, max.min, y + 1],
      [x + 1, max.min, y],
    ].uniq
  end
end

puts "Part1: #{Solution.new.part1}"
puts "Part2: #{Solution.new.part2}"

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
