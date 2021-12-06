#!/usr/bin/env ruby
require "ruby_jard"

class Solution
  # TOKENIZER = //

  def input
    test_input || File.read(File.join(__dir__, "input.txt"))
  end

  def test_input
    <<~INPUT
      0,9 -> 5,9
      8,0 -> 0,8
      9,4 -> 3,4
      2,2 -> 2,1
      7,0 -> 7,4
      6,4 -> 2,0
      0,9 -> 2,9
      3,4 -> 1,4
      0,0 -> 8,8
      5,5 -> 8,2
    INPUT
    nil
  end

  def data
    @data ||= input.split("\n").map { |l| l.split(" -> ").map { |p| p.split(",").map(&:to_i) } }
  end

  def seen
    @seen ||= Hash.new(0)
  end

  def part1
    data
      .select { |pair| straight_line?(pair) }
      .each { |coords| extrapolate(coords) }
    seen.count { |k, v| 1 < v }
  end

  def straight_line?(pair)
    pair[0][0] == pair[1][0] || pair[0][1] == pair[1][1]
  end

  def part2
    data
      .reject { |pair| straight_line?(pair) }
      .each { |coords| extrapolate_diag(coords) }
    seen.count { |k, v| v > 1 }
  end

  # plot every coordinate between a pair of coordinates
  def extrapolate(pair)
    pair[0].map! { |c| c.to_i }
    pair[1].map! { |c| c.to_i }

    x_range =
      if pair[0][0] < pair[1][0]
        (pair[0][0]..pair[1][0]).to_a
      else
        (pair[1][0]..pair[0][0]).to_a.reverse
      end
    y_range =
      if pair[0][1] < pair[1][1]
        (pair[0][1]..pair[1][1]).to_a
      else
        (pair[1][1]..pair[0][1]).to_a.reverse
      end
    x_range.each do |x|
      y_range.each do |y|
        seen[[x, y]] += 1
      end
    end
  end

  def extrapolate_diag(pair)
    pair[0].map! { |c| c.to_i }
    pair[1].map! { |c| c.to_i }

    x_range =
      if pair[0][0] < pair[1][0]
        (pair[0][0]..pair[1][0]).to_a
      else
        (pair[1][0]..pair[0][0]).to_a.reverse
      end
    y_range =
      if pair[0][1] < pair[1][1]
        (pair[0][1]..pair[1][1]).to_a
      else
        (pair[1][1]..pair[0][1]).to_a.reverse
      end
    x_range.zip(y_range).each do |vec|
      seen[vec] += 1
    end
  end
end

solution = Solution.new
puts "Part1: #{solution.part1}"
puts "Part2: #{solution.part2}"
