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
  data[0..-2].each.with_index(1) do |d, i|
    @lookup[d] = i
  end
  current_index = data.size
  last_spoken = data.last
  until current_index == tgt
    next_number = @lookup[last_spoken] ? (current_index - @lookup[last_spoken]) : 0
    @lookup[last_spoken] = current_index
    current_index += 1
    last_spoken = next_number
  end
  last_spoken
end

def part1
  @lookup = {}
  # @lookup = Hash.new { |hash, key| hash[key] = [] }
  play(DATA.strip.split(",").map(&:to_i), tgt: 2_020)
end

def part2
  @lookup = {}
  play(DATA.strip.split(",").map(&:to_i), tgt: 30_000_000)
end

start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
# puts "Solution part1:\n#{part1}"
puts "Solution part2:\n#{part2}"
puts "#{(Process.clock_gettime(Process::CLOCK_MONOTONIC) - start).round 1} secs"
