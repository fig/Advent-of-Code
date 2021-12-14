#!/usr/bin/env ruby

class Solution
  def initialize
    @lookup = {}
    @pairs = Hash.new(0)
    @tally = Hash.new(0)
    data[1].lines(chomp: true).each do |line|
      a, b = line.split(" -> ")
      @lookup[a] = b
    end
    data[0].chars.each_cons(2) { |pr| @pairs[pr.join] += 1 }
    data[0].chars.each { |char| @tally[char] += 1 }
  end

  def solve_for(steps)
    steps.times do
      @pairs.clone.each do |pair, v|
        next if v.zero?

        insert = @lookup[pair]
        @tally[insert] += v
        @pairs[pair] -= v
        @pairs[pair[0] + insert] += v
        @pairs[insert + pair[1]] += v
      end
    end
    @tally.values.minmax.reduce(&:-).abs
  end

  private

  def data
    @data ||= input.split("\n\n")
  end

  def input
    test_input || File.read(File.join(__dir__, "input.txt"))
  end

  def test_input
    <<~INPUT
      NNCB

      CH -> B
      HH -> N
      CB -> H
      NH -> C
      HB -> C
      HC -> B
      HN -> C
      NN -> C
      BH -> H
      NC -> B
      NB -> B
      BN -> B
      BB -> N
      BC -> B
      CC -> N
      CN -> C
    INPUT
  end
end

puts "Part1: #{Solution.new.solve_for 10}"
puts "Part2: #{Solution.new.solve_for 40}"
