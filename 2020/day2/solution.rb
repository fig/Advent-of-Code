#!/usr/bin/env ruby
def test_data
  # <<~DATA.freeze
  #   1-3 a: abcde
  #   1-3 b: cdefg
  #   2-9 c: ccccccccc
  # DATA
end

DATA = test_data || File.read("input.txt")

TOKENIZER = /(\d+)-(\d+) (\w): (\w+)/.freeze

def part1
  entries = DATA.scan TOKENIZER
  entries.count { |min, max, x, pwd| (min.to_i..max.to_i).cover?(pwd.count(x)) }
end

def part2
  # entries = DATA.scan TOKENIZER
  # entries.count { |a, b, x, pwd| (pwd[a.to_i - 1] == x) ^ (pwd[b.to_i - 1] == x) }
end

puts "Solution part1:\n#{part1}"
puts "Solution part2:\n#{part2}" if part2
