#!/usr/bin/env ruby

class Solution
  COST = [3, 1]
  def input
    <<~INPUT
      Button A: X+94, Y+34
      Button B: X+22, Y+67
      Prize: X=8400, Y=5400

      Button A: X+26, Y+66
      Button B: X+67, Y+21
      Prize: X=12748, Y=12176

      Button A: X+17, Y+86
      Button B: X+84, Y+37
      Prize: X=7870, Y=6450

      Button A: X+69, Y+23
      Button B: X+27, Y+71
      Prize: X=18641, Y=10279
    INPUT
    File.read(File.join(__dir__, "input.txt"))
  end

  def machines
    @machines ||=
      input.split("\n\n").map { |machine|
        machine.split("\n").map { |line| line.scan(/\d+/).map(&:to_i) }
               .then do |a, b, prize|
                 {
                   a:     { x: a[0], y: a[1] },
                   b:     { x: b[0], y: b[1] },
                   prize: { x: prize[0], y: prize[1] },
                 }
               end
      }
  end

  def cramers_rule
    lambda  { |machine, offset: 0|
      prize = { x: machine[:prize][:x] + offset, y: machine[:prize][:y] + offset }
      det = (machine[:a][:x] * machine[:b][:y]) - (machine[:a][:y] * machine[:b][:x])
      return 0 if det.zero?

      a = ((prize[:x] * machine[:b][:y]) - (prize[:y] * machine[:b][:x])) / det
      b = ((machine[:a][:x] * prize[:y]) - (machine[:a][:y] * prize[:x])) / det
      if [
        (machine[:a][:x] * a) + (machine[:b][:x] * b),
        (machine[:a][:y] * a) + (machine[:b][:y] * b),
      ] == prize.values

        (a * 3) + b
      else
        0
      end
    }
  end

  def part1
    machines.sum(&cramers_rule)
  end

  def part2
    machines.sum { |machine| cramers_rule.call(machine, offset: 10_000_000_000_000) }
  end

  def solutions
    p1 = part1
    p2 = part2
    puts "Part1: #{p1} #{[480, 28_753].include?(p1) ? '✅' : '❌'}"
    puts "Part2: #{p2} #{[875_318_608_908, 102_718_967_795_500].include?(p2) ? '✅' : '❌'}"
  end
end

Solution.new.solutions
