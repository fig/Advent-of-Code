#!/usr/bin/env ruby
require "ruby_jard"

class Solution
  Probe =
    Struct.new(:x, :y, :vx, :vy) do
      def step
        x2 = x + vx
        y2 = y + vy
        vx2 = vx
        vx2 = vx + 1 if vx.negative?
        vx2 = vx - 1 if vx.positive?
        vy2 = vy - 1
        Probe.new(x2, y2, vx2, vy2)
      end
    end

  def initialize
    @max_y = {}
    @attempts = []
  end

  def input
    test_input || File.read(File.join(__dir__, "input.txt"))
  end

  def test_input
    # <<~INPUT
    # target area: x=20..30, y=-10..-5
    # INPUT
  end

  def target
    /\Atarget\sarea:\sx=(?<x1>\d+)\.\.(?<x2>\d+),\sy=(?<y1>-?\d+)\.\.(?<y2>-?\d+)\n\z/mx =~ input

    {
      x: (x1.to_i..x2.to_i),
      y: (y1.to_i..y2.to_i),
    }
  end

  def on_target?(x, y)
    target[:x].cover?(x) && target[:y].cover?(y)
  end

  def part1
    (0..400).each do |xv|
      (-200..200).each do |yv|
        init = [xv, yv]
        @max_y[init] = []
        probe = Probe.new(0, 0, *init)
        while probe.x <= target[:x].max
          previous = probe
          probe = probe.step
          @max_y[init] << probe.y
          break if probe.x == previous.x && probe.y < target[:y].min
          break if probe.x >= target[:x].min && target[:y].cover?(probe.y)
        end
        if on_target?(probe.x, probe.y)
          puts "#{init} landed in the target. Max height #{@max_y[init].max}\t#{probe}"
        else
          @max_y[init] = [0]
        end
      end
    end

    puts "\n\nfinished"
    k, v = @max_y.max_by { |k, v| v.max }
    puts "values #{k} reached a height of #{v.max}."
  end

  def part2
  end
end

puts "Part1: #{Solution.new.part1}" # 4095
puts "Part2: #{Solution.new.part2}" # 3773
