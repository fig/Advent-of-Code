#!/usr/bin/env ruby
require "set"

class Solution
  attr_reader :nodes, :costs, :visited, :candidates

  def initialize
    @nodes = {}
    @costs = Hash.new(Float::INFINITY)
    @visited = Set.new
    @candidates = Set.new
    make_heightmap
  end

  def part1
    target = nodes.key("E")
    nodes[target] = "z"
    start = nodes.key("S")
    nodes[start] = "a"
    costs[start] = 0
    candidates << start
    do_the_dijkstra_thing(target)
  end

  def part2
    target = nodes.key("E")
    nodes[target] = "z"
    nodes[nodes.key("S")] = "a"
    starts = nodes.select { |_, v| v == "a" }
    starts.each_key { |start| costs[start] = 0 }
    candidates.merge starts.keys
    do_the_dijkstra_thing(target) - 1
  end

  private

  def make_heightmap
    input.split.each.with_index do |line, x|
      line.chars.each.with_index do |char, y|
        nodes[[x, y]] = char
      end
    end
  end

  def input
    File.read(File.join(__dir__, "input.txt"))
  end

  def do_the_dijkstra_thing(target)
    loop do
      return Float::INFINITY if candidates.empty?

      current = candidates.min_by { |node| costs[node] }
      neighbours(*current).each do |node|
        next if visited.include?(node)
        next if nodes[node] > nodes[current].succ

        costs[node] = costs[current] + 1
        candidates << node
      end
      candidates.delete current
      visited << current
      return costs[target] if current == target
    end
  end

  def neighbours(x, y)
    [
      ([x - 1, y] unless x.zero?),
      ([x, y - 1] unless y.zero?),
      ([x + 1, y] unless x == max_x),
      ([x, y + 1] unless y == max_y),
    ].compact
  end

  def max_x
    @max_x ||= length - 1
  end

  def max_y
    @max_y ||= width - 1
  end

  def length
    @length ||= input.lines.size
  end

  def width
    @width ||= input.lines.first.chomp.length
  end
end

puts "Part1: #{Solution.new.part1}"
puts "Part2: #{Solution.new.part2}"
# 468
# 459
