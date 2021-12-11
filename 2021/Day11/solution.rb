#!/usr/bin/env ruby

class Solution
  def initialize
    @flashes_count = 0
    @energies = {}

    File.read(File.join(__dir__, "input.txt")).each_line(chomp: true).with_index do |row, x|
      row.chars.each.with_index do |energy, y|
        @energies[[x, y]] = energy.to_i
      end
    end
  end

  def part1
    100.times { tick }
    @flashes_count
  end

  def part2
    (1..).each do |step|
      tick
      break step if @flashed_this_step.size == 100
    end
  end

  def tick
    @flashed_this_step = []
    @energies.each { |octopus, _v| @energies[octopus] += 1 }
    @energies.select { |_k, energy| 9 < energy }
             .each { |octopus, _v| flash(octopus) }
  end

  def flash(octopus)
    @energies[octopus] = 0
    return if @flashed_this_step.include? octopus

    @flashed_this_step << octopus
    @flashes_count += 1
    neighbours_of(octopus).each do |neighbour|
      next if @flashed_this_step.include? neighbour

      @energies[neighbour] += 1
      flash(neighbour) if 9 < @energies[neighbour]
    end
  end

  def neighbours_of(octopus)
    x, y = octopus
    [
      [[x - 1, 0].max, [y - 1, 0].max],
      [[x - 1, 0].max, [y + 1, 9].min],
      [[x - 1, 0].max, y],
      [x, [y - 1, 0].max],
      [x, [y + 1, 9].min],
      [[x + 1, 9].min, [y - 1, 0].max],
      [[x + 1, 9].min, [y + 1, 9].min],
      [[x + 1, 9].min, y],
    ].uniq
  end
end

puts "Part1: #{Solution.new.part1}"
puts "Part2: #{Solution.new.part2}"
