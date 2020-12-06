# frozen_string_literal: true

# !/usr/bin/env ruby

def test_data
end

INPUT = test_data || File.read(File.join(__dir__, "input.txt"))

def data
  @data ||= INPUT
end

class Slope
  attr_reader :right, :down

  def initialize(right:, down:)
    @right = right
    @down = down
  end

  def count_trees
    scan_slope
    markers.count "#"
  end

  private

  def scan_slope
    (0..).each do |counter|
      map.shift(down)
      break if map.empty?

      row = map.first
      markers << row[(right * counter) % row.length]
    end
  end

  def markers
    @markers ||= []
  end

  def map
    @map ||= INPUT.dup.split
  end
end

def part1
  Slope.new(right: 3, down: 1).count_trees
end

def part2
  [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
    .map! { |pair| { right: pair[0], down: pair[1] } }
    .map! { |args| Slope.new(**args).count_trees }
    .inject :*
end

puts "Solution part1: #{part1}"
puts "Solution part2: #{part2}"
