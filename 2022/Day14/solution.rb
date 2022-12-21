#!/usr/bin/env ruby
require "matrix"

class Solution
  attr_reader :cave, :sand_path

  def initialize
    @cave = Hash.new(".")
    @sand_path = [Vector[500, 0]]
    input.lines(chomp: true).each do |rock|
      draw rock
    end
  end

  def input
    test_input || File.read(File.join(__dir__, "input.txt"))
  end

  def test_input
    # <<~INPUT
    #   498,4 -> 498,6 -> 496,6
    #   503,4 -> 502,4 -> 502,9 -> 494,9
    # INPUT
  end

  def data
    @data ||= input.lines(chomp: true)
                   .map { |line| line.split(" -> ") }
                   .flatten!
                   .map! { |line| line.split(",") }
  end

  def min_x
    @min_x ||= data.map!(&:first).map(&:to_i).min
  end

  def max_y
    @max_y ||= 1 + data.map!(&:last).map(&:to_i).max
  end

  def draw(rock)
    rock.split(" -> ").each_cons(2) do |a, b|
      x1, y1 = a.split(",").map(&:to_i)
      x2, y2 = b.split(",").map(&:to_i)
      if x1 == x2
        Range.new(*[y1, y2].sort).each do |y|
          cave[[x1, y]] = "#"
        end
      else
        Range.new(*[x1, x2].sort).each do |x|
          cave[[x, y1]] = "#"
        end
      end
    end
  end

  def part1
    units_of_sand = 0
    loop do
      sand_position = sand_path.pop
      loop do
        case [
          cave[(sand_position + Vector[-1, 1]).to_a],
          cave[(sand_position + Vector[0, 1]).to_a],
          cave[(sand_position + Vector[1, 1]).to_a],
        ]
        in [_, ".", _]
          sand_path << sand_position
          sand_position += Vector[0, 1]
        in [".", "#", *]
          sand_path << sand_position
          sand_position += Vector[-1, 1]
          return units_of_sand if sand_position[0] == min_x
        in [ *, "."]
          sand_path << sand_position
          sand_position += Vector[1, 1]
        else
          break cave[sand_position.to_a] = "#"
        end
      end
      units_of_sand += 1
    end
  end

  def part2
    units_of_sand = 0
    loop do
      sand_position = sand_path.pop || Vector[500, 0]
      return units_of_sand if cave[sand_position.to_a] == "#"

      loop do
        if sand_position[1] == max_y
          cave[sand_position.to_a] = "#"
          break
        end

        case [
          cave[(sand_position + Vector[-1, 1]).to_a],
          cave[(sand_position + Vector[0, 1]).to_a],
          cave[(sand_position + Vector[1, 1]).to_a],
        ]
        in [_, ".", _]
          sand_path << sand_position
          sand_position += Vector[0, 1]
        in [".", "#", *]
          sand_path << sand_position
          sand_position += Vector[-1, 1]
        in [ *, "."]
          sand_path << sand_position
          sand_position += Vector[1, 1]
        else
          break cave[sand_position.to_a] = "#"
        end
      end
      units_of_sand += 1
    end
  end
end

puts "Part1: #{Solution.new.part1}"
puts "Part2: #{Solution.new.part2}"
# 1199
# 23925
# ~650ms
