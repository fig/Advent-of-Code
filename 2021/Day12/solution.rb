#!/usr/bin/env ruby

class Solution
  def initialize
    @paths = Hash.new { |h, k| h[k] = [] }

    input.lines(chomp: true).each do |path|
      a, b = *path.split("-")
      @paths[a] << b
      @paths[b] << a
    end
  end

  def part1
    path = ["start"]
    count_paths(path) do |dest, current_path|
      dest == dest.downcase && current_path.include?(dest)
    end
  end

  def part2
    path = ["start"]
    count_paths(path) do |dest, current_path|
      dest == "start" || (
        dest == dest.downcase &&
        current_path.tally.any? { |k, v| k == k.downcase && v > 1 } &&
        current_path.include?(dest)
      )
    end
  end

  private

  def count_paths(path, &block)
    return 1 if path.last == "end"

    @paths[path.last]
      .reject { |dest| yield dest, path }
      .sum { |dest| count_paths(path + [dest], &block) }
  end

  def input
    test_input || File.read(File.join(__dir__, "input.txt"))
  end

  def test_input
    # <<~INPUT
    #   start-A
    #   start-b
    #   A-c
    #   A-b
    #   b-d
    #   A-end
    #   b-end
    # INPUT
  end
end
puts "Part1: #{Solution.new.part1}"
puts "Part2: #{Solution.new.part2}"
