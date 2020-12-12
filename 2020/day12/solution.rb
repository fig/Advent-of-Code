#!/usr/bin/env ruby
# frozen_string_literal: true

require "ruby_jard"

def test_data
  # <<~DATA
  #   F10
  #   N3
  #   F7
  #   R90
  #   F11
  # DATA
end

DATA = test_data || File.read(File.join(__dir__, "input.txt"))
TOKENIZER = /(\w)(\d{1,3})/.freeze

def input
  DATA.scan(TOKENIZER).map { |i, v| [i, v.to_i] }
end

def part1
  heading = 90
  north = 0
  east = 0
  input.each do |instruction, value|
    case instruction
    when "N"
      north += value
    when "E"
      east += value
    when "S"
      north -= value
    when "W"
      east -= value
    when "R"
      heading = (heading + value).modulo 360
    when "L"
      heading = (heading - value).modulo 360
    when "F"
      case heading
      when 0
        north += value
      when 90
        east += value
      when 180
        north -= value
      when 270
        east -= value
      end
    end
  end
  north.abs + east.abs
end

def part2
  wp = { e: 10, n: 1 }
  north = 0
  east = 0
  input.each do |instruction, value|
    case instruction
    when "N"
      wp[:n] += value
    when "E"
      wp[:e] += value
    when "S"
      wp[:n] -= value
    when "W"
      wp[:e] -= value
    when "R"
      case value
      when 90
        wp[:n], wp[:e] = -wp[:e], wp[:n]
      when 180
        wp[:n] = -wp[:n]
        wp[:e] = -wp[:e]
      when 270
        wp[:n], wp[:e] = wp[:e], -wp[:n]
      end
    when "L"
      case value
      when 90
        wp[:n], wp[:e] = wp[:e], -wp[:n]
      when 180
        wp[:n] = -wp[:n]
        wp[:e] = -wp[:e]
      when 270
        wp[:n], wp[:e] = -wp[:e], wp[:n]
      end
    when "F"
      north += wp[:n] * value
      east += wp[:e] * value
    end
  end
  north.abs + east.abs
end

puts "Solution part1:\n#{part1}"
puts "Solution part2:\n#{part2}"
