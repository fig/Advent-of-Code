#!/usr/bin/env ruby
# frozen_string_literal: true

INPUT = File.read(File.join(__dir__, "input.txt"))

SEATS = INPUT.tr("FLBR", "0011").split.map { _1.to_i(2) }
part1 = SEATS.max
part2 = (Array(SEATS.min..SEATS.max) - SEATS)[0]

puts "Solution part1: #{part1}"
puts "Solution part2: #{part2}"
