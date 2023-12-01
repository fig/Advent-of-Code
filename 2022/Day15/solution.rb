#!/usr/bin/env ruby

class Solution
  def input
    test_input || File.read(File.join(__dir__, "input.txt"))
  end

  def test_input
    <<~INPUT
      Sensor at x=2, y=18: closest beacon is at x=-2, y=15
      Sensor at x=9, y=16: closest beacon is at x=10, y=16
      Sensor at x=13, y=2: closest beacon is at x=15, y=3
      Sensor at x=12, y=14: closest beacon is at x=10, y=16
      Sensor at x=10, y=20: closest beacon is at x=10, y=16
      Sensor at x=14, y=17: closest beacon is at x=10, y=16
      Sensor at x=8, y=7: closest beacon is at x=2, y=10
      Sensor at x=2, y=0: closest beacon is at x=2, y=10
      Sensor at x=0, y=11: closest beacon is at x=2, y=10
      Sensor at x=20, y=14: closest beacon is at x=25, y=17
      Sensor at x=17, y=20: closest beacon is at x=21, y=22
      Sensor at x=16, y=7: closest beacon is at x=15, y=3
      Sensor at x=14, y=3: closest beacon is at x=15, y=3
      Sensor at x=20, y=1: closest beacon is at x=15, y=3
    INPUT
  end

  def sensors
    @sensors ||= {}
  end

  def solutions
    puts "Part1: #{part1}"
    # puts "Part2: #{part2}"
  end

  private

  def part1
    input.each_line do |line|
      sensor, beacon = line.split(":").map(&:strip)
      sensor_x, sensor_y = sensor.scan(/-?\d+/).map(&:to_i)
      beacon_x, beacon_y = beacon.scan(/-?\d+/).map(&:to_i)

      sensors[[sensor_x, sensor_y]] = [beacon_x, beacon_y]
    end
    sensors
  end

  def part2
  end
end

Solution.new.solutions
