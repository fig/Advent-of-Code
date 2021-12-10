#!/usr/bin/env ruby
require "ruby_jard"

class Solution
  attr_accessor :points

  def initialize
    @points = []
    data.each_with_index { |row, x|
      row.each_with_index do |point, y|
        @points << Point.new(point, x, y, self)
      end
    }
  end

  def input
    test_input || File.read(File.join(__dir__, "input.txt"))
  end

  def test_input
    <<~INPUT
      2199943210
      3987894921
      9856789892
      8767896789
      9899965678
    INPUT
  end

  def data
    @data ||= input.split.map { |e| e.chars.map(&:to_i) }
  end

  def lowpoints
    @lowpoints ||= []
  end

  class Point
    attr_accessor :value, :x, :y, :world, :in_pool

    def initialize(value, x, y, world)
      @value = value
      @x = x
      @y = y
      @world = world
      @in_pool = false
    end

    def in_pool?
      @in_pool
    end

    def mates
      self.in_pool = true
      return self if neighbors.all? { |n| n.in_pool? || n.value == 9 }

      neighbors.reject { |n| n.in_pool? || n.value == 9 }
               .map!(&:mates) << self
    end

    def neighbors
      [leftneighbor, rightneighbor, bellowneighbor, aboveneighbor].compact
    end

    def leftneighbor
      world.points.find { |p| p.x == x - 1 && p.y == y } unless x.zero?
    end

    def rightneighbor
      world.points.find { |p| p.x == x + 1 && p.y == y } unless x == (world.data.length - 1)
    end

    def bellowneighbor
      world.points.find { |p| p.x == x && p.y == y + 1 } unless y == (world.data[0].length - 1)
    end

    def aboveneighbor
      world.points.find { |p| p.x == x && p.y == y - 1 } unless y.zero?
    end
  end

  class Lowpoint < Point
    attr_accessor :value, :x, :y, :world, :pool

    def initialize(value, x, y, world)
      super(value, x, y, world)
      @pool = []
      @in_pool = true
      find_pool
    end

    def find_pool
      pool << neighbors.select { |n| n.value < 9 }
      pool.flatten.each do |point|
        pool << point.mates
      end
    end

    def poolsize
      pool.flatten.uniq!.size
    end
  end

  def lowpoint?(x, y)
    lefthigher?(x, y) && righthigher?(x, y) && abovehigher?(x, y) && belowhigher?(x, y)
  end

  def lefthigher?(x, y)
    return true if y.zero?

    data[x][y] < data[x][y - 1]
  end

  def righthigher?(x, y)
    return true if y == data[0].length - 1

    data[x][y] < data[x][y + 1]
  end

  def abovehigher?(x, y)
    return true if x.zero?

    data[x][y] < data[x - 1][y]
  end

  def belowhigher?(x, y)
    return true if x == data.length - 1

    data[x][y] < data[x + 1][y]
  end

  def part1
    data.each_with_index do |row, x|
      row.each_with_index do |point, y|
        lowpoints << Lowpoint.new(point, x, y, self) if lowpoint?(x, y)
      end
    end
    lowpoints.sum { |lp| lp.value + 1 }
  end

  def part2
    part1
    lowpoints.map(&:poolsize).max(3).reduce(:*)
  end
end

puts "Part1: #{Solution.new.part1}"
puts "Part2: #{Solution.new.part2}"
