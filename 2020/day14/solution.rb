#!/usr/bin/env ruby
# frozen_string_literal: true

require "ruby_jard"

DATA =  File.read(File.join(__dir__, "input.txt"))

class Permuter
  attr_reader :string, :mask

  def initialize(string, mask)
    @string = string
    @mask = mask.freeze
    @permutations = []
  end

  def run
    transforms.each do |t|
      s = string.dup
      t.chars.each do |c|
        s.sub!(/X/, c)
      end
      @permutations << s
    end
    @permutations
  end

  def number_of_floating_bits
    @number_of_floating_bits ||= mask.count("X")
  end

  def transforms
    (0..("1" * number_of_floating_bits).to_i(2)).map { |i| i.to_s(2).rjust(number_of_floating_bits, "0") }
  end
end

def data
  @data ||= DATA.split("\n")
end

def mask
  @mask ||= nil
end

def read1(val)
  bin_val = val.to_i.to_s(2).rjust(36, "0")
  masked_val =
    bin_val.chars.map!.each_with_index do |ch, i|
      case mask[i]
      when "0" then "0"
      when "1" then "1"
      else ch
      end
    end
  masked_val.join.to_i(2)
end

def read2(add, val)
  bin_add = add.to_i.to_s(2).rjust(36, "0")
  masked_add =
    bin_add.chars.map!.each_with_index do |ch, i|
      case mask[i]
      when "0" then ch
      when "1" then "1"
      else "X"
      end
    end
  Permuter.new(masked_add.join, mask).run.each do |a|
    @mem[a] = val.to_i
  end
end

def part1
  @mem = {}
  data.each do |line|
    case line
    when /mask = (.{36})/
      @mask = Regexp.last_match(1)
    when /mem\[(\d+)\] = (\d+)/
      @mem[Regexp.last_match(1)] = read1(Regexp.last_match(2))
    end
  end
  @mem.values.sum
end

def part2
  @mem = {}
  data.each do |line|
    case line
    when /mask = (.{36})/
      @mask = Regexp.last_match(1)
    when /mem\[(\d+)\] = (\d+)/
      read2(Regexp.last_match(1), Regexp.last_match(2))
    end
  end
  @mem.values.sum
end

puts "Solution part1:\n#{part1}"
puts "Solution part2:\n#{part2}"
