#!/usr/bin/env ruby
# frozen_string_literal: true

def test_data
  <<~DATA
    light red bags contain 1 bright white bag, 2 muted yellow bags.
    dark orange bags contain 3 bright white bags, 4 muted yellow bags.
    bright white bags contain 1 shiny gold bag.
    muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
    shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
    dark olive bags contain 3 faded blue bags, 4 dotted black bags.
    vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
    faded blue bags contain no other bags.
    dotted black bags contain no other bags.
  DATA
end

INPUT = test_data || File.read(File.join(__dir__, "input.txt"))

def rules
  @rules ||= INPUT.each_line
end

TOKENIZER = /(.*) bags contain.*(?=shiny gold)/.freeze

def part1
end

def part2
end

puts "Solution part1: #{part1}"
puts "Solution part2: #{part2}"
