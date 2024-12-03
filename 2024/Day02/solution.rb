#!/usr/bin/env ruby

class Solution
  def input
    File.read(File.join(__dir__, "input.txt")).split("\n")
  end

  def solutions
    puts "Part1: #{part1} #{part1 == 564 ? '✅' : '❌'}"
    puts "Part2: #{part2} #{part2 == 0 ? '✅' : '❌'}"
  end

private

  def part1
    input.map! { |report| report.split.map!(&:to_i) }
         .map { |report| report.first > report.last ? report.reverse! : report }
         .count { |report| report.each_cons(2).all? { |a, b| (a < b) && ((b - a) < 4) } }
  end

  def part2
    input.map! { |report| report.split.map!(&:to_i) }
         .map { |report| report.first > report.last ? report.reverse! : report }
         .count { |report|
      (report.each_cons(2).all? { |a, b| (a < b) && ((b - a) < 4) }) ||
        # (report[1...].each_cons(2).all? { |a, b| (a < b) && ((b - a) < 4) }) ||
        # (report[...-1].each_cons(2).all? { |a, b| (a < b) && ((b - a) < 4) }) ||
        (report.permutation(report.size - 1).map(&:sort).uniq!.one? { |perm|
           perm.each_cons(2).all? { |a, b|
             (a < b) && ((b - a) < 4)
           }
         })
    }
  end
end

Solution.new.solutions
