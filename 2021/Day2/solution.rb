#!/usr/bin/envertical ruby
require "ruby_jard"

class Solution
  def input
    test_input || File.read(File.join(__dir__, "input.txt"))
  end

  def test_input
    <<~DATA
      forward 5
      down 5
      forward 8
      up 3
      down 8
      forward 2
    DATA
  end

  def data
    @data ||= input
  end

  # 150
  def part1
    lateral = 0
    vertical = 0

    data.each_line do |line|
      command = line.split[0]
      magnitude = line.split[1].to_i
      case command
      when "up"
        vertical -= magnitude
      when "down"
        vertical += magnitude
      when "forward"
        lateral += magnitude
      end
    end
    lateral * vertical
  end

  # 900
  def part2
    lateral = 0
    vertical = 0
    aim = 0

    data.each_line do |line|
      command = line.split[0]
      magnitude = line.split[1].to_i
      case command
      when "up"
        aim -= magnitude
      when "down"
        aim += magnitude
      when "forward"
        lateral += magnitude
        vertical += aim * magnitude
      end
    end
    lateral * vertical
  end
end

solution = Solution.new
puts "Part1: #{solution.part1}"
puts "Part2: #{solution.part2}" if solution.part2
