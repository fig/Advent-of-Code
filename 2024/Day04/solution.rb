#!/usr/bin/env ruby

class Solution
  X_MAS = [%w[M M S S], %w[M S M S], %w[S M S M], %w[S S M M]].freeze
  XMAS = /(?=(XMAS|SAMX))/

  def input
    File.readlines(File.join(__dir__, "input.txt"))
  end

  def lines
    @lines ||= input
  end

  def xmas_count = ->(line) { line.scan(XMAS).count }

  def horizontal_count
    lines.sum(&xmas_count)
  end

  def vertical_count
    lines.map(&:chars).transpose.map!(&:join).sum(&xmas_count)
  end

  # Slant the rectangle into a diamond shape by padding each line, because
  # that's got to be easier than scanning diagonally, right?
  def descending_count
    diagonal_count { |line, i| Array.new(lines.size - i, ".") + line + Array.new(i, ".") }
  end

  # Slant the other way to scan the other diagonal.
  def ascending_count
    diagonal_count { |line, i| Array.new(i, ".") + line + Array.new(lines.size - i, ".") }
  end

  # Flip the passed diamond onto its side, then scan it for XMAS and SAMX.
  def diagonal_count(&block)
    lines.map(&:chars).each_with_index.map(&block).transpose.map!(&:join).sum(&xmas_count)
  end

  def grid
    @grid ||=
      begin
        grid = {}
        lines.each_with_index do |line, y|
          line.chars.each_with_index { |char, x| grid[[x, y]] = char }
        end
        grid
      end
  end

  def x_mas?
    lambda { |node|
      x_y, = node
      X_MAS.any?(corners(*x_y))
    }
  end

  def corners(x, y)
    [
      grid[[x - 1, y - 1]],
      grid[[x + 1, y - 1]],
      grid[[x - 1, y + 1]],
      grid[[x + 1, y + 1]],
    ]
  end

  def part1 = horizontal_count + vertical_count + descending_count + ascending_count

  def part2
    grid
      .select { |_, v| v == "A" }
      .count(&x_mas?)
  end

  def solutions
    puts "Part1: #{part1}"
    puts "Part2: #{part2}"
  end
end

Solution.new.solutions
