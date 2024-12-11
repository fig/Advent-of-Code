#!/usr/bin/env ruby

class Solution
  def rocks
    @rocks ||= File.read(File.join(__dir__, "input.txt")).split.map(&:to_i)
  end

  def cache
    @cache ||= Hash.new { |h, k| h[k] = {} }
  end

  def tick(value, level)
    return 1 if level.zero?

    cache[level][value] ||=
      if value.zero?
        tick(1, level - 1)
      elsif (string = value.to_s) && string.length.even?
        mid = string.length / 2
        tick(string[...mid].to_i, level - 1) + tick(string[mid..].to_i, level - 1)
      else
        tick(value * 2024, level - 1)
      end
  end

  def blink(blinks, rocks)
    rocks.sum { |rock| tick(rock, blinks) }
  end

  def part1
    blink(25, rocks)
  end

  def part2
    blink(75, rocks)
  end

  def solutions
    p1 = part1
    p2 = part2

    puts "Part1: #{p1} #{[55_312, 189_092].include?(p1) ? '✅' : '❌'}"
    puts "Part2: #{p2} #{[65_601_038_650_482, 224_869_647_102_559].include?(p2) ? '✅' : '❌'}"

    require "benchmark"
    puts "Benchmarking..."

    bm = (((1..10).to_a.sum { cache.clear && Benchmark.realtime { part1 } }) / 10)
    puts "Part1: #{(bm * 1000).round 3} ms"
    bm = (((1..10).to_a.sum { cache.clear && Benchmark.realtime { part2 } }) / 10)
    puts "Part2: #{(bm * 1000).round 3} ms"
  end
end

Solution.new.solutions

# Benchmarks (i5-8265U / 16GB RAM / Linux)
# Part1: ~   5 ms
# Part2: ~ 245 ms
