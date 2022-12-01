#!/usr/bin/env ruby
require "ruby_jard"

class Solution
  def input
    test_input || File.read(File.join(__dir__, "input.txt"))
  end

  def test_input
    # <<~INPUT
    #   Player 1 starting position: 4
    #   Player 2 starting position: 8
    # INPUT
  end

  def data
    @data ||= input.split
  end

  def dice
    @dice ||= (1..100).to_a
  end

  def part1
    board = (1..10).to_a
    p1_score = 0
    p2_score = 0
    p1_position = data[4].to_i
    p2_position = data[9].to_i
    num_of_rolls = 0
    loop do
      move = roll(3)
      num_of_rolls += 1
      p1_position = board.rotate(p1_position + move).last
      p1_score += p1_position
      break if p1_score >= 1_000

      move = roll(3)
      num_of_rolls += 1
      p2_position = board.rotate(p2_position + move).last
      p2_score += p2_position
      break if p2_score >= 1_000
    end
    [p1_score, p2_score].min * (num_of_rolls * 3)
  end

  def roll(n)
    dice.rotate! n
    dice.last(n).sum
  end

  def part2
    player1 = Player.new(data[4].to_i, 0)
    player2 =  Player.new(data[9].to_i, 0)
    universe = Universe.new((1..10).to_a, player1, player2)
    universes = [universe]
    until players.all? { |p| p.score >= 21 }
      universes.map(&:roll)
    end
  end

  class Universe
    def initialize(board, player1, player2)
      @board = board
      @player1 = player1
      @player2 = player2
      start
    end

    def start
      [
        [1, 2, 3].map do |num|
          Universe.new(board, player1.roll(num), player2)
        end,
        [1, 2, 3].map do |num|
          Universe.new(board, player1, player2.roll(num))
        end,
      ]
    end
  end

  class Player
    def initialize(position, score)
      @position = position
      @score = score
    end
  end
end

puts "Part1: #{Solution.new.part1}"
puts "Part2: #{Solution.new.part2}"
