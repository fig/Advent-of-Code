#!/usr/bin/env ruby

class Solution
  def input
    "125 17"
    # File.read(File.join(__dir__, "input.txt"))
  end

  class Rock
    attr_accessor :value

    def initialize(value)
      @value = value.to_i
    end

    def tick
      if @value.zero?
        Rock.new(1)
      elsif @value.to_s.length.even?
        s = @value.to_s
        l = s.length / 2
        [Rock.new(s[...l]), Rock.new(s[l..])]
      else
        Rock.new(@value * 2024)
      end
    end
  end

  def blink(n, line)
    n.times do |i|
      line.map!(&:tick)
      line.flatten!
    end
    line.size
  end

  def part1
    line = input.chomp.split.map! { |v| Rock.new(v) }
    blink(25, line)
  end

  def part2
    blink(75, line)
  end

  def solutions
    start = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    p1 = part1
    puts "Part1: #{p1} #{[55_312, 189_092].include?(p1) ? '✅' : '❌'}"

    # p2 = part2
    # puts "Part2: #{p2} #{[65_601_038_650_482].include?(p2) ? '✅' : '❌'}"

    finish = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    puts "\nExecution time: #{((finish - start) * 1000).round(2)} ms"
  end
end

Solution.new.solutions
