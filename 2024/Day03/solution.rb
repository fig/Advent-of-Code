#!/usr/bin/env ruby

require "strscan"

class Solution
  FUNCTION = /mul\((\d+,\d+)\)/

  def input
    File.read(File.join(__dir__, "input.txt"))
  end

  def compute(code)
    code.scan(FUNCTION).flatten.sum { |str| str.split(",").map(&:to_i).reduce(:*) }
  end

  def part1
    compute(input)
  end

  def part2
    acc = 0
    scanner = StringScanner.new(input)
    loop do
      break acc += compute(scanner.rest) unless (match = scanner.scan_until(/don't\(\)/))

      acc += compute(match)
      break(acc) unless scanner.skip_until(/do\(\)/)
    end
  end

  # hat-tip /u/keidax
  def part2_flip_flop
    input.scan(/mul\((\d{1,3}),(\d{1,3})\)|(do)\(\)|(don't)\(\)/).sum do |x, y, on, off|
      next 0 if off..on

      x.to_i * y.to_i
    end
  end

  def solutions
    puts "Part1:          #{part1}"
    puts "Part2:          #{part2}"
    puts "Part2 FlipFlop: #{part2_flip_flop}"
  end
end

Solution.new.solutions

# Benchmark StringScanner vs Flip-Flop
require "benchmark/ips"

Benchmark.ips do |x|
  x.report("StringScanner") { Solution.new.part2 }
  x.report("Flip-Flop") { Solution.new.part2_flip_flop }
  x.compare!
end

# ruby 3.3.6 (2024-11-05 revision 75015d4c1f) [x86_64-linux]
# Warming up --------------------------------------
#        StringScanner   155.000 i/100ms
#            Flip-Flop    97.000 i/100ms
# Calculating -------------------------------------
#        StringScanner      1.534k (± 5.9%) i/s  (651.78 μs/i) -      7.750k in   5.076146s
#            Flip-Flop    959.970 (± 8.9%) i/s    (1.04 ms/i) -      4.753k in   5.010195s

# Comparison:
#        StringScanner:     1534.3 i/s
#            Flip-Flop:      960.0 i/s - 1.60x  slower
