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
    # File.read(File.join(__dir__, "input.txt"))
  end

  def machines
    @machines ||= input.split("\n\n")
  end

  def cramer
    #     A = (p_x*b_y - prize_y*b_x) / (a_x*b_y - a_y*b_x)
    #     B = (a_x*p_y - a_y*p_x) / (a_x*b_y - a_y*b_x)
    lambda do |ax, ay, bx, by, px, py|
      [
        ((px * by) - (py * bx)) / ((ax * by) - (ay * bx)),
        ((ax * py) - (ay * px)) / ((ax * by) - (ay * bx)),
      ]
    end
  end

  #   fn solve_machine(machine: &Machine, offset: isize) -> isize {
  #     let prize = (machine.prize.0, machine.prize.1);
  #     let det = machine.a.0 * machine.b.1 - machine.a.1 * machine.b.0;
  #     let a = (prize.0 * machine.b.1 - prize.1 * machine.b.0) / det;
  #     let b = (machine.a.0 * prize.1 - machine.a.1 * prize.0) / det;
  #     if (machine.a.0 * a + machine.b.0 * b, machine.a.1 * a + machine.b.1 * b) == (prize.0, prize.1) {
  #         a * 3 + b
  #     } else {
  #         0
  #     }
  # }
  def solve_machine
    lambda do |a, b, prize|
      det = (a[0] * b[1]) - (a[1] * b[0])
      a = ((prize[0] * b[1]) - (prize[1] * b[0])) / det
      b = ((a[0] * prize[1]) - (a[1] * prize[0])) / det
      if [((a[0] * a) + (b[0] * b)), ((a[1] * a) + (b[1] * b))] == prize
        (a * 3) + b
      else
        0
      end
    end
  end

  def part1
    machines.map! do |machine|
      a, b, prize =
        machine.split("\n").map { |line|
        x, y = line.scan(/\d+/).map(&:to_i)
        [x, y]
      }

      solve_machine.call(a, b, prize)
    end
  end

  def part2
  end

  def solutions
    p1 = part1
    puts "Part1: #{p1} #{[480].include?(p1) ? '✅' : '❌'}"
    puts "Part2: #{part2}"
  end
end

Solution.new.solutions
