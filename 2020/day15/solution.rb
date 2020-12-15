#!/usr/bin/env ruby
# frozen_string_literal: true

require "ruby_jard"

def test_data
  # <<~DATA
  #   0,3,6
  # DATA
end

DATA = test_data || File.read(File.join(__dir__, "input.txt"))

def play(data, tgt:)
  data[0..-2].each_with_index do |d, i|
    @lookup[d] = [i]
  end
  current_index = data.size
  last_spoken = data.last
  until current_index == tgt
    next_number = @lookup[last_spoken].empty? ? 0 : (current_index - @lookup[last_spoken].last) - 1
    @lookup[last_spoken] << current_index - 1
    current_index += 1
    last_spoken = next_number
  end
  last_spoken
end

def part1
  @lookup = Hash.new { |hash, key| hash[key] = [] }
  play(DATA.strip.split(",").map(&:to_i), tgt: 2_020)
end

def part2
  @lookup = Hash.new { |hash, key| hash[key] = [] }
  play(DATA.strip.split(",").map(&:to_i), tgt: 30_000_000)
end

# puts "Solution part1:\n#{part1}"
start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
puts "Solution part2:\n#{part2}"
puts "#{(Process.clock_gettime(Process::CLOCK_MONOTONIC) - start).round 1} secs"
