#!/usr/bin/env ruby
require "ruby_jard"

class Solution
  def input
    test_input || File.read(File.join(__dir__, "input.txt"))
  end

  def test_input
    # <<~INPUT
    #   00100
    #   11110
    #   10110
    #   10111
    #   10101
    #   01111
    #   00111
    #   11100
    #   10000
    #   11001
    #   00010
    #   01010
    # INPUT
  end

  def part1
    gamma_rate.to_i(2) * epsilon_rate.to_i(2)
  end

  def part2
    oxygen_generator_rating.to_i(2) * co2_scrubber_rating.to_i(2)
  end

  def gamma_rate
    @gamma_rate ||= data_transposed
                    .map { |col| col.count("1") > (dataset_size / 2) ? "1" : "0" }
                    .join
  end

  def epsilon_rate
    gamma_rate.tr("01", "10")
  end

  def oxygen_generator_rating
    data_filter toggle: "1"
  end

  def co2_scrubber_rating
    data_filter toggle: "0"
  end

  def data_filter(toggle:)
    entries = data.dup
    bit_position = 0
    loop do
      bits = entries.map { |entry| entry[bit_position] }
      tally = bits.tally
      if tally["0"] == tally["1"]
        entries.select! { |entry| entry[bit_position] == toggle }
      else
        most_common, = tally.max_by(&:last)
        entries.select! { |entry| entry[bit_position] == most_common } if toggle == "1"
        entries.reject! { |entry| entry[bit_position] == most_common } if toggle == "0"
      end
      break entries[0] if entries.size == 1

      bit_position += 1
    end
  end

  def data
    @data ||= input.split
  end

  def data_transposed
    @data_transposed ||= data.map(&:chars).transpose
  end

  def dataset_size
    @dataset_size ||= input.lines.count
  end
end

solution = Solution.new
puts "Part1: #{solution.part1}"
puts "Part2: #{solution.part2}" if solution.part2
