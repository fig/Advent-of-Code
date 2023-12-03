#!/usr/bin/env ruby

class Solution
  BAG = { red: 12, green: 13, blue: 14 }.freeze

  def input
    File.read(File.join(__dir__, "input.txt"))
  end

  def games
    input.lines
  end

  def part1
    possible_games =
      games.reject { |game|
        game.split(":")[1].split(/[;,]/).any? { |reveal|
          num, color = reveal.split
          num.to_i > BAG[color.to_sym]
        }
      }
    possible_games.sum { |game| game.match(/Game (\d+)/)[1].to_i }
  end

  def part2
    games.sum { |game|
      tally = { red: 0, green: 0, blue: 0 }
      game.split(":")[1].split(/[;,]/).each do |reveal|
        num, color = reveal.split
        tally[color.to_sym] = [tally[color.to_sym], num.to_i].max
      end
      tally.values.inject(:*)
    }
  end

  def solutions
    puts "Part1: #{part1}" # 2776
    puts "Part2: #{part2}" # 68638
  end
end

Solution.new.solutions
