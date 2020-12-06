#!/usr/bin/env ruby
# frozen_string_literal: true

def test_data
  # <<~DATA
  # put test data here and uncomment
  # DATA
end

INPUT = test_data || File.read(File.join(__dir__, "input.txt"))

class Passport
  REQUIRED_FIELDS = %i[byr iyr eyr hgt hcl ecl pid cid].freeze
  attr_reader :fields

  def initialize(data)
    @fields = data
              .split
              .map { |fields| fields.split ":" }
              .to_h
              .transform_keys(&:to_sym)
  end

  def valid?
    required_fields? && fields_valid?
  end

  def required_fields?
    [[], [:cid]].include? REQUIRED_FIELDS - fields.keys
  end

  def fields_valid?
    [
      fields[:byr].to_i.between?(1920, 2002),
      fields[:iyr].to_i.between?(2010, 2020),
      fields[:eyr].to_i.between?(2020, 2030),
      height_valid?,
      fields[:hcl].match?(/\A#[0-9a-f]{6}\z/),
      %w[amb blu brn gry grn hzl oth].include?(fields[:ecl]),
      fields[:pid].match?(/\A\d{9}\z/),
    ].all?
  end

  def height_valid?
    return false unless fields[:hgt] =~ /
      (?<value> \d+   )
      (?<unit>  cm|in )
      /x

    case Regexp.last_match[:unit]
    when "cm"
      Regexp.last_match[:value].to_i.between? 150, 193
    when "in"
      Regexp.last_match[:value].to_i.between? 59, 76
    end
  end
end

def passports
  @passports ||= INPUT.split("\n\n").map { |data| Passport.new(data) }
end

def part1
  passports.count(&:required_fields?)
end

def part2
  passports.count(&:valid?)
end

puts "Solution part1:\n#{part1}"
puts "Solution part2:\n#{part2}" if part2
