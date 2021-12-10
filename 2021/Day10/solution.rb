#!/usr/bin/env ruby

class Solution
  OPENERS = %w|( [ { <|.freeze
  CLOSERS = %w|) ] } >|.freeze

  PT1_POINTS = { ")" => 3, "]" => 57, "}" => 1_197, ">" => 25_137 }.freeze
  PT2_POINTS = { "(" => 1, "[" => 2, "{" => 3, "<" => 4 }.freeze

  def input
    test_input || File.read(File.join(__dir__, "input.txt"))
  end

  def test_input
    <<~INPUT
      [({(<(())[]>[[{[]{<()<>>
      [(()[<>])]({[<{<<[]>>(
      {([(<{}[<>[]}>{[]{[(<()>
      (((({<>}<{<{<>}{[]{[]{}
      [[<[([]))<([[{}[[()]]]
      [{[{({}]{}}([{[{{{}}([]
      {<[[]]>}<{[{[{[]{()[[[]
      [<(<(<(<{}))><([]([]()
      <{([([[(<>()){}]>(<<{{
      <{([{{}}[<[[[<>{}]]]>[]]
    INPUT
  end

  def data
    @data ||= input.split
  end

  def corrupted?(line)
    context = []
    line.chars.each do |c|
      if OPENERS.include? c
        context.push c
      else
        opener = OPENERS[CLOSERS.index c]
        return c unless context.pop == opener
      end
    end
    nil
  end

  def opentags(line)
    context = []
    line.chars.each do |c|
      if OPENERS.include? c
        context.push c
      else
        context.pop
      end
    end
    context.reverse
  end

  def part1
    data.filter_map { |line| corrupted? line }
        .map{PT1_POINTS[_1]}
        .sum
  end

  def part2
    data.reject! { |line| corrupted? line }
        .map! { |line| opentags(line) }
        .map! { |line| line.map{PT2_POINTS[_1]} }
        .map! { |line| line.reduce(0) { |acc, elem| (acc * 5) + elem } }
        .sort!
    data[data.length / 2]
  end
end

puts "Part1: #{Solution.new.part1}"
puts "Part2: #{Solution.new.part2}"
