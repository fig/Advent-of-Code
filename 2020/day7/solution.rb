#!/usr/bin/env ruby
# frozen_string_literal: true

def test_data
  # <<~DATA
  #   light red bags contain 1 bright white bag, 2 muted yellow bags.
  #   dark orange bags contain 3 bright white bags, 4 muted yellow bags.
  #   bright white bags contain 1 shiny gold bag.
  #   muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
  #   shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
  #   dark olive bags contain 3 faded blue bags, 4 dotted black bags.
  #   vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
  #   faded blue bags contain no other bags.
  #   dotted black bags contain no other bags.
  # DATA
end

INPUT = test_data || File.read(File.join(__dir__, "input.txt"))

def rules
  @rules ||= INPUT.each_line
end

def container_tokenizer(bag)
  /(.*) bags contain.*(?=#{bag})/.freeze
end

def contents_tokenizer(bag)
  /shiny gold bags contain (\d+.*?(?=bags?)|no other) bags\./
end

def result
  @result ||= []
end

def part1
  containers(["shiny gold"])
  result.flatten.uniq!.size
end
require "ruby_jard"
def containers(bags)
  found = []
  bags.each { |bag| found << rules.flat_map { _1.scan container_tokenizer(bag) }.flatten }
  result << found.flatten!.uniq
  containers(found) unless found.empty?
end

def part2
end

puts "Solution part1: #{part1}"
puts "Solution part2: #{part2}" if part2
