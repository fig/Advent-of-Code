#!/usr/bin/env ruby
# frozen_string_literal: true

def test_data
  <<~DATA
    939
    7,13,x,x,59,x,31,19
  DATA
end

DATA = test_data || File.read(File.join(__dir__, "input.txt"))
Bus = Struct.new(:period, :offset)

def data
  @data ||= DATA.split
end

def earliest_departure
  @earliest_departure ||= data[0].to_i
end

def buses
  @buses ||= data[1].split(",").map!(&:to_i)
end

def buses_with_offset
  @buses_with_offset ||=
    buses.each_with_index.map { |b, i| Bus.new(b, i) unless b.zero? }.compact!
end

def lead_bus
  buses_with_offset[0]
end

def following_buses
  buses_with_offset[1..]
end

def find_timestamp(start, step, bus_a, bus_b)
  (start..).step(step).find do |t|
    (t % bus_a.period).zero? && ((t + bus_b.offset) % bus_b.period).zero?
  end
end

def part1
  my_bus =
    buses.reject(&:zero?)
         .min_by { |bus| ((earliest_departure / bus) + 1) * bus - earliest_departure }
  (my_bus - (earliest_departure % my_bus)) * my_bus
end

# I couldn't have done part2 without the hint from /u/PillarsBliz
# https://www.reddit.com/r/adventofcode/comments/kc60ri/2020_day_13_can_anyone_give_me_a_hint_for_part_2/gfnnfm3/
def part2
  t = 0
  step = lead_bus.period
  following_buses.each_with_object(lead_bus) do |follower, lead|
    t = find_timestamp(
      find_timestamp(t, step, lead, follower),
      step,
      lead,
      follower,
    )
    step *= follower.period
  end
  t
end

puts "Solution part1:\n#{part1}"
puts "Solution part2:\n#{part2}"
