#!/usr/bin/env ruby
# frozen_string_literal: true

require "ruby_jard"

def test_data
  # <<~DATA
  #   0,3,6
  # DATA
end

DATA = test_data || File.read(File.join(__dir__, "input.txt"))

def next_number(data, tgt:)
  until data.length == tgt
    last_spoken = data[-1]
    data << if data[0..-2].include? last_spoken
              difference_between_the_turn_number_when_it_was_last_spoken_and_the_turn_number_of_the_time_it_was_most_recently_spoken_before_then(data, last_spoken)
            else
              0
            end
  end
  data.last
end

def difference_between_the_turn_number_when_it_was_last_spoken_and_the_turn_number_of_the_time_it_was_most_recently_spoken_before_then(data, last_spoken)
  tmp = data.dup
  last_spoken_index = tmp.rindex(last_spoken)
  tmp[last_spoken_index] = "X"
  previously_spoken_index = tmp.rindex(last_spoken)
  last_spoken_index - previously_spoken_index
end

def part1
  next_number(DATA.strip.split(",").map(&:to_i), tgt: 2_020)
end

def part2
  # next_number(DATA.strip.split(",").map(&:to_i), tgt: 30_000_000)
end

puts "Solution part1:\n#{part1}"
puts "Solution part2:\n#{part2}"
