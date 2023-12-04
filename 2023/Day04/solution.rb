#!/usr/bin/env ruby

class Solution
  def input
    sample || File.read(File.join(__dir__, "input.txt"))
  end

  def cards
    input.lines
  end

  def sample
    # <<~SAMPLE
    #   Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
    #   Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
    #   Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
    #   Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
    #   Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
    #   Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
    # SAMPLE
  end

  def part2
    multipliers = Hash.new(1)
    total = 0
    cards.each do |card|
      card_id = card[/Card\s+(\d+)/, 1].to_i
      total += multipliers[card_id]
      mine, winning = card.split(":").last.split("|").map(&:split)
      matching = (mine & winning).size
      1.upto(matching) { |i| multipliers[card_id + i] += multipliers[card_id] }
    end
    total
  end

  def part1
    total = 0
    cards.each do |card|
      mine, winning = card.split(":").last.split("|").map(&:split)
      matching = mine & winning
      total += 2**(matching.size - 1) if matching.any?
    end
    total
  end

  def solutions
    puts "Part1: #{part1}"
    puts "Part2: #{part2}"
  end
end

Solution.new.solutions
