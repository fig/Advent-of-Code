#!/usr/bin/env ruby

class Solution
  attr_reader :count

  def input
    # "125 17"
    # "512 72 2024 2 0 2 4 2867 6032"
    File.read(File.join(__dir__, "input.txt"))
  end

  def tick(value, level, cost_value = 1)
    return cost_value if level.zero?

    cache[[level, value]] ||=
      if value.zero?
        tick(1, level - 1, cost_value)
      elsif value.to_s.length.even?
        s = value.to_s
        l = s.length / 2
        tick(s[...l].to_i, level - 1, cost_value) + tick(s[l..].to_i, level - 1, cost_value)
      else
        tick(value * 2024, level - 1, cost_value)
      end
  end

  def blink(n, line)
    line.sum { |rock| tick(rock, n) }
  end

  def cache
    @cache ||= {}
    # @cache ||= Hash.new { |h, k| h[k] = {} }
  end

  # def cost_values
  #   @cost_values ||= Hash.new { |h, k| h[k] = Hash.new(0) }
  # end

  def part1
    line = input.chomp.split.map(&:to_i)
    blink(25, line)
  end

  def part2
    line = input.chomp.split.map(&:to_i)
    blink(75, line)
  end

  def solutions
    start = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    p1 = part1
    puts "Part1: #{p1} #{[55_312, 189_092].include?(p1) ? '✅' : '❌'}"

    p2 = part2
    puts "Part2: #{p2} #{[65_601_038_650_482].include?(p2) ? '✅' : '❌'}"

    finish = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    puts "\nExecution time: #{((finish - start) * 1000).round(2)} ms"
  end
end

Solution.new.solutions
