#!/usr/bin/env ruby
require "set"

class Solution
  def initialize(multiplier:)
    @multiplier = multiplier
    @nodes = {}
  end

  def solve
    input.split.each.with_index do |line, x|
      line.chars.each.with_index do |char, y|
        @nodes[[x, y]] = char.to_i
      end
    end

    multiply_input_by(@multiplier)

    do_the_dijkstra_thing
  end

  private

  def multiply_input_by(multiplier)
    return if multiplier == 1

    @nodes.dup.each do |key, value|
      (1...multiplier).each do |x|
        @nodes[[key[0] + (length * x), key[1]]] = ((value - 1 + x) % 9) + 1
      end
    end

    @nodes.dup.each do |key, value|
      (1...multiplier).each do |y|
        @nodes[[key[0], key[1] + (length * y)]] = ((value - 1 + y) % 9) + 1
      end
    end
  end

  def do_the_dijkstra_thing
    cost = Hash.new(Float::INFINITY)
    cost[[0, 0]] = 0
    target = [max_x, max_y]
    visited =  Set.new
    candidates = Set.new

    candidates << [0, 0]

    loop do
      current = candidates.min_by { |node| cost[node] }
      neighbours(*current).each do |node|
        next if visited.include? node

        cost[node] = [cost[node], cost[current] + @nodes[node]].min
        candidates << node
      end
      candidates.delete current
      visited << current
      return cost[target] if current == target
    end
  end

  def input
    test_input || File.read(File.join(__dir__, "input.txt"))
  end

  def test_input
    # <<~INPUT
    #   1163751742
    #   1381373672
    #   2136511328
    #   3694931569
    #   7463417111
    #   1319128137
    #   1359912421
    #   3125421639
    #   1293138521
    #   2311944581
    # INPUT
  end

  def neighbours(x, y)
    [
      ([x - 1, y] unless x.zero?),
      ([x, y - 1] unless y.zero?),
      ([x + 1, y] unless x == max_x),
      ([x, y + 1] unless y == max_y),
    ].compact
  end

  def width
    @width ||= input.lines.first.chomp.length
  end

  def length
    @length ||= input.lines.size
  end

  def max_x
    @max_x ||= (width * @multiplier) - 1
  end

  def max_y
    @max_y ||= (length * @multiplier) - 1
  end
end

puts "Part1: #{Solution.new(multiplier: 1).solve}" # 40 / 441
puts "Part2: #{Solution.new(multiplier: 5).solve}" # 315 / 2849
# ~ 1 min 10 sec for the competition input
