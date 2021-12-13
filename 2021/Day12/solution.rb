#!/usr/bin/env ruby
require "ruby_jard"

class Solution
  def initialize
    @paths = Hash.new { |h, k| h[k] = [] }

    input.lines(chomp: true).each do |path|
      a, b = *path.split("-")
      @paths[a] << b
      @paths[b] << a
    end
  end

  #   start => [A b],
  #   A     => [start c b end],
  #   b     => [start A d end],
  #   c     => [A],
  #   d     => [b],
  #   end   => [A b],

  def part1
    path = ["start"]
    count_paths(path)
  end

  def part2
  end

  private

  def count_paths(path)
    return 1 if path.last == "end"

    @paths[path.last]
      .reject { |dest| dest == dest.downcase && path.include?(dest) }
      .sum { |dest| count_paths(path + [dest]) }
  end

  def input
    test_input || File.read(File.join(__dir__, "input.txt"))
  end

  def test_input
    <<~INPUT
      start-A
      start-b
      A-c
      A-b
      b-d
      A-end
      b-end
    INPUT
    nil
  end
end
puts "Part1: #{Solution.new.part1}"
puts "Part2: #{Solution.new.part2}"

# start,A,b,A,c,A,end
# start,A,b,A,end
# start,A,b,end
# start,A,c,A,b,A,end
# start,A,c,A,b,end
# start,A,c,A,end
# start,A,end
# start,b,A,c,A,end
# start,b,A,end
# start,b,end
