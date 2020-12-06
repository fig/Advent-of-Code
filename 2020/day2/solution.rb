#!/usr/bin/env ruby
def test_data
  # <<~DATA.freeze
  #   1-3 a: abcde
  #   1-3 b: cdefg
  #   2-9 c: ccccccccc
  # DATA
end

DATA = test_data || File.read(File.join(__dir__, "input.txt"))
TOKENIZER = /(\d+)-(\d+) (\w): (\w+)/.freeze

def entries
  @entries ||= DATA.scan TOKENIZER
end

def part1
  entries.count { |min, max, tgt, pwd| pwd.count(tgt).between? min.to_i, max.to_i }
end

def part2
  entries.count do |pos_a, pos_b, tgt, pwd|
    (pwd[pos_a.to_i - 1] == tgt) ^ (pwd[pos_b.to_i - 1] == tgt)
  end
end

puts "Solution part1:\n#{part1}"
puts "Solution part2:\n#{part2}" if part2
