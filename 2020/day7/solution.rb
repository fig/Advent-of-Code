#!/usr/bin/env ruby
# frozen_string_literal: true

require "ruby_jard"

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

def result
  @result ||= []
end

def part1
  result.clear
  containers(["shiny gold"])
  result.flatten.uniq!.size
end

def containers(bags)
  found = []
  bags.each { |bag| found << rules.flat_map { _1.scan container_tokenizer(bag) }.flatten }
  result << found.flatten!.uniq
  containers(found) unless found.empty?
end

def contents_tokenizer(bag)
  /#{bag} bags contain (\d+.*|no other)/
end

def part2
  result.clear
  find_contents_of "1 shiny gold"
  result.flatten.sum(&:to_i)
end

def find_contents_of(bags)
  number, bag = bags.scan(/(\d+) (.*)/).flatten
  number.to_i.times do
    rule = rules.find { _1.start_with? bag }
    rule.scan(contents_tokenizer(bag))
    contents = Regexp.last_match[1]
    return 0 if contents == "no other"

    count(contents)
    contents.gsub(/bags?\.?/, "").split(",").map(&:strip).each { find_contents_of(_1) }
  end
end

def count(contents)
  result << contents.scan(/\d+/)
end

puts "Solution part1: #{part1}"
puts "Solution part2: #{part2}" if part2
